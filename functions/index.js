const {onRequest} = require("firebase-functions/v2/https");
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {defineSecret} = require("firebase-functions/params");
const logger = require("firebase-functions/logger");
const {BrevoClient} = require("@getbrevo/brevo");
const admin = require("firebase-admin");

admin.initializeApp();

const brevoApiKey = defineSecret("BREVO_API_KEY");

/**
 * Creates a Brevo API client using the Firebase Secret Manager API key.
 *
 * @return {BrevoClient} Configured Brevo client.
 */
function getBrevoClient() {
  return new BrevoClient({
    apiKey: brevoApiKey.value(),
  });
}

/**
 * Escapes user-provided values before inserting them into HTML.
 *
 * @param {unknown} value Value to escape.
 * @return {string} HTML-safe string.
 */
function escapeHtml(value) {
  return String(value)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#039;");
}

/**
 * Converts a value to a string with a fallback.
 *
 * @param {unknown} value Value to convert.
 * @param {string} fallback Value to use when the input is empty.
 * @return {string} Converted string.
 */
function stringValue(value, fallback) {
  if (value === null || value === undefined) {
    return fallback || "";
  }

  return value.toString();
}

/**
 * ============================================================
 * TEST BREVO EMAIL
 * ============================================================
 *
 * Manually test the Brevo integration using:
 *
 * https://us-central1-lag-clothing-e4567.cloudfunctions.net/testBrevoEmail
 */
exports.testBrevoEmail = onRequest(
    {
      secrets: [brevoApiKey],
    },
    async (req, res) => {
      try {
        const client = getBrevoClient();

        const result =
          await client.transactionalEmails.sendTransacEmail({
            subject: "LAG Clothing - Brevo Test",

            htmlContent: `
              <!DOCTYPE html>
              <html>
                <body style="
                  margin: 0;
                  padding: 0;
                  background-color: #f5f5f5;
                  font-family: Arial, Helvetica, sans-serif;
                ">
                  <div style="
                    max-width: 600px;
                    margin: 40px auto;
                    background-color: #ffffff;
                    border-radius: 12px;
                    overflow: hidden;
                  ">
                    <div style="
                      background-color: #111111;
                      padding: 24px;
                      text-align: center;
                    ">
                      <h1 style="
                        margin: 0;
                        color: #ffffff;
                        font-size: 26px;
                      ">
                        LAG Clothing
                      </h1>
                    </div>

                    <div style="padding: 30px;">
                      <h2 style="
                        margin-top: 0;
                        color: #111111;
                      ">
                        Brevo Email Test
                      </h2>

                      <p style="
                        color: #444444;
                        font-size: 16px;
                        line-height: 1.6;
                      ">
                        This is a test email sent from the
                        LAG Clothing Firebase Cloud Function.
                      </p>

                      <p style="
                        color: #444444;
                        font-size: 16px;
                        line-height: 1.6;
                      ">
                        If you received this email, the Brevo
                        integration is working successfully.
                      </p>

                      <div style="
                        margin-top: 25px;
                        padding: 16px;
                        background-color: #f5f5f5;
                        border-radius: 8px;
                      ">
                        <strong>Status:</strong>
                        <span style="color: green;">
                          Email integration successful
                        </span>
                      </div>
                    </div>

                    <div style="
                      padding: 20px;
                      text-align: center;
                      background-color: #111111;
                      color: #aaaaaa;
                      font-size: 13px;
                    ">
                      LAG Clothing
                    </div>
                  </div>
                </body>
              </html>
            `,

            // Temporary verified sender for testing.
            // Later change to order@lagclothing.com.
            sender: {
              name: "Clothing App",
              email: "mhdsiddq17@gmail.com",
            },

            // Your test email.
            to: [
              {
                email: "abualmahdi07@gmail.com",
              },
            ],
          });

        logger.info("Brevo test email sent successfully", {
          result,
        });

        res.status(200).json({
          success: true,
          message: "Brevo test email sent successfully.",
        });
      } catch (error) {
        logger.error("Brevo test email failed", {
          error: error.message,
          stack: error.stack,
        });

        res.status(500).json({
          success: false,
          message: "Brevo test email failed.",
          error: error.message,
        });
      }
    },
);

/**
 * ============================================================
 * ORDER CREATED -> SEND CUSTOMER EMAIL
 * ============================================================
 *
 * Firestore path:
 *
 * orders/{orderId}
 *
 * Whenever a new order is created:
 *
 * 1. Read the order.
 * 2. Get userId from the order.
 * 3. Find the Firebase Auth customer.
 * 4. Get the customer's email.
 * 5. Build the email.
 * 6. Send the email through Brevo.
 */
exports.sendOrderConfirmationEmail = onDocumentCreated(
    {
      document: "orders/{orderId}",
      secrets: [brevoApiKey],
      region: "us-central1",
    },
    async (event) => {
      try {
        const snapshot = event.data;

        if (!snapshot) {
          logger.error("Order creation event has no data.");
          return;
        }

        const order = snapshot.data();
        const orderId = event.params.orderId;

        logger.info("New order created", {
          orderId,
        });

        /**
         * --------------------------------------------------------
         * GET USER ID
         * --------------------------------------------------------
         */

        const userId = order.userId ?
          order.userId.toString() :
          "";

        if (!userId) {
          logger.error("Order does not contain userId", {
            orderId,
          });

          return;
        }

        /**
         * --------------------------------------------------------
         * GET CUSTOMER FROM FIREBASE AUTH
         * --------------------------------------------------------
         */

        let customer;

        try {
          customer = await admin.auth().getUser(userId);
        } catch (error) {
          logger.error("Unable to find Firebase Auth user", {
            orderId,
            userId,
            error: error.message,
          });

          return;
        }

        const customerEmail = customer.email;

        if (!customerEmail) {
          logger.error("Customer does not have an email address", {
            orderId,
            userId,
          });

          return;
        }

        /**
         * --------------------------------------------------------
         * CUSTOMER NAME
         * --------------------------------------------------------
         */

        const customerNameValue =
          customer.displayName || "Customer";

        const customerName =
          stringValue(customerNameValue, "Customer");

        /**
         * --------------------------------------------------------
         * ORDER DATA
         * --------------------------------------------------------
         */

        const orderNumber =
          stringValue(order.orderNumber, orderId);

        const total =
          Number(order.total || order.grandTotal || 0);

        const subtotal =
          Number(order.subtotal || 0);

        const shippingCharge =
          Number(
              order.shippingCharge ||
              order.shipping ||
              0,
          );

        const discount =
          Number(order.discount || 0);

        const tax =
          Number(order.tax || 0);

        const paymentMethod =
          stringValue(
              order.paymentMethod,
              "Not specified",
          );

        const paymentStatus =
          stringValue(
              order.paymentStatus,
              "pending",
          );

        /**
         * --------------------------------------------------------
         * BUILD ORDER ITEMS HTML
         * --------------------------------------------------------
         */

        const items =
          Array.isArray(order.items) ?
            order.items :
            [];

        let itemsHtml = "";

        if (items.length === 0) {
          itemsHtml = `
            <p style="
              color: #666666;
              font-size: 14px;
            ">
              Order items information is unavailable.
            </p>
          `;
        } else {
          itemsHtml = items
              .map((item) => {
                const productName =
                  stringValue(
                      item.productName,
                      "Product",
                  );

                const size =
                  stringValue(
                      item.size,
                      "-",
                  );

                const color =
                  stringValue(
                      item.color,
                      "-",
                  );

                const quantity =
                  Number(item.quantity || 0);

                const price =
                  Number(item.price || 0);

                const itemTotal =
                  Number(item.total || 0);

                return `
                  <div style="
                    padding: 16px 0;
                    border-bottom: 1px solid #eeeeee;
                  ">

                    <div style="
                      font-size: 16px;
                      font-weight: bold;
                      color: #111111;
                    ">
                      ${escapeHtml(productName)}
                    </div>

                    <div style="
                      margin-top: 6px;
                      color: #666666;
                      font-size: 14px;
                    ">
                      Size: ${escapeHtml(size)}
                      &nbsp; | &nbsp;
                      Color: ${escapeHtml(color)}
                      &nbsp; | &nbsp;
                      Quantity: ${quantity}
                    </div>

                    <div style="
                      margin-top: 6px;
                      color: #333333;
                      font-size: 14px;
                    ">
                      ₹${price.toFixed(2)} each
                    </div>

                    <div style="
                      margin-top: 6px;
                      color: #111111;
                      font-size: 15px;
                      font-weight: bold;
                    ">
                      Item total: ₹${itemTotal.toFixed(2)}
                    </div>

                  </div>
                `;
              })
              .join("");
        }

        /**
         * --------------------------------------------------------
         * SHIPPING ADDRESS
         * --------------------------------------------------------
         */

        const shippingAddress =
          order.shippingAddress || {};

        const fullName =
          shippingAddress.fullName ?
            shippingAddress.fullName.toString() :
            customerName;

        const addressLine1 =
          shippingAddress.addressLine1 ?
            shippingAddress.addressLine1.toString() :
            "";

        const addressLine2 =
          shippingAddress.addressLine2 ?
            shippingAddress.addressLine2.toString() :
            "";

        const landmark =
          shippingAddress.landmark ?
            shippingAddress.landmark.toString() :
            "";

        const city =
          shippingAddress.city ?
            shippingAddress.city.toString() :
            "";

        const state =
          shippingAddress.state ?
            shippingAddress.state.toString() :
            "";

        const pincode =
          shippingAddress.pincode ?
            shippingAddress.pincode.toString() :
            "";

        const country =
          shippingAddress.country ?
            shippingAddress.country.toString() :
            "India";

        /**
         * --------------------------------------------------------
         * SEND EMAIL
         * --------------------------------------------------------
         */

        const client = getBrevoClient();

        const result =
          await client.transactionalEmails.sendTransacEmail({
            subject:
              `LAG Clothing - Order Confirmation #${orderNumber}`,

            htmlContent: `
              <!DOCTYPE html>
              <html>

                <body style="
                  margin: 0;
                  padding: 0;
                  background-color: #f5f5f5;
                  font-family: Arial, Helvetica, sans-serif;
                ">

                  <div style="
                    max-width: 600px;
                    margin: 30px auto;
                    background: #ffffff;
                    border-radius: 12px;
                    overflow: hidden;
                  ">

                    <!-- HEADER -->

                    <div style="
                      background: #111111;
                      padding: 25px;
                      text-align: center;
                    ">

                      <h1 style="
                        margin: 0;
                        color: #ffffff;
                        font-size: 28px;
                      ">
                        LAG Clothing
                      </h1>

                    </div>

                    <!-- CONTENT -->

                    <div style="
                      padding: 30px;
                    ">

                      <h2 style="
                        margin-top: 0;
                        color: #111111;
                      ">
                        Order Confirmed 🎉
                      </h2>

                      <p style="
                        color: #444444;
                        font-size: 16px;
                        line-height: 1.6;
                      ">
                        Hi ${escapeHtml(fullName)},
                      </p>

                      <p style="
                        color: #444444;
                        font-size: 16px;
                        line-height: 1.6;
                      ">
                        Thank you for shopping with LAG Clothing.
                        Your order has been successfully placed.
                      </p>

                      <!-- ORDER NUMBER -->

                      <div style="
                        margin: 20px 0;
                        padding: 18px;
                        background: #f5f5f5;
                        border-radius: 8px;
                      ">

                        <div style="
                          color: #777777;
                          font-size: 13px;
                        ">
                          ORDER NUMBER
                        </div>

                        <div style="
                          margin-top: 5px;
                          color: #111111;
                          font-size: 20px;
                          font-weight: bold;
                        ">
                          #${escapeHtml(orderNumber)}
                        </div>

                      </div>

                      <!-- ITEMS -->

                      <h3 style="
                        color: #111111;
                        margin-top: 30px;
                      ">
                        Order Items
                      </h3>

                      ${itemsHtml}

                      <!-- SUMMARY -->

                      <h3 style="
                        color: #111111;
                        margin-top: 30px;
                      ">
                        Order Summary
                      </h3>

                      <table style="
                        width: 100%;
                        border-collapse: collapse;
                        font-size: 14px;
                      ">

                        <tr>
                          <td style="
                            padding: 6px 0;
                            color: #666666;
                          ">
                            Subtotal
                          </td>

                          <td style="
                            padding: 6px 0;
                            text-align: right;
                          ">
                            ₹${subtotal.toFixed(2)}
                          </td>
                        </tr>

                        <tr>
                          <td style="
                            padding: 6px 0;
                            color: #666666;
                          ">
                            Shipping
                          </td>

                          <td style="
                            padding: 6px 0;
                            text-align: right;
                          ">
                            ₹${shippingCharge.toFixed(2)}
                          </td>
                        </tr>

                        <tr>
                          <td style="
                            padding: 6px 0;
                            color: #666666;
                          ">
                            Discount
                          </td>

                          <td style="
                            padding: 6px 0;
                            text-align: right;
                          ">
                            -₹${discount.toFixed(2)}
                          </td>
                        </tr>

                        <tr>
                          <td style="
                            padding: 6px 0;
                            color: #666666;
                          ">
                            Tax
                          </td>

                          <td style="
                            padding: 6px 0;
                            text-align: right;
                          ">
                            ₹${tax.toFixed(2)}
                          </td>
                        </tr>

                        <tr>
                          <td style="
                            padding: 12px 0;
                            border-top: 1px solid #dddddd;
                            font-weight: bold;
                            font-size: 17px;
                          ">
                            Total
                          </td>

                          <td style="
                            padding: 12px 0;
                            border-top: 1px solid #dddddd;
                            text-align: right;
                            font-weight: bold;
                            font-size: 17px;
                          ">
                            ₹${total.toFixed(2)}
                          </td>
                        </tr>

                      </table>

                      <!-- PAYMENT -->

                      <div style="
                        margin-top: 25px;
                        padding: 16px;
                        background: #f5f5f5;
                        border-radius: 8px;
                      ">

                        <div>
                          <strong>Payment method:</strong>
                          ${escapeHtml(paymentMethod)}
                        </div>

                        <div style="margin-top: 6px;">
                          <strong>Payment status:</strong>
                          ${escapeHtml(paymentStatus)}
                        </div>

                      </div>

                      <!-- ADDRESS -->

                      <h3 style="
                        color: #111111;
                        margin-top: 30px;
                      ">
                        Delivery Address
                      </h3>

                      <div style="
                        color: #555555;
                        font-size: 14px;
                        line-height: 1.6;
                      ">

                        ${escapeHtml(fullName)}<br>

                        ${escapeHtml(addressLine1)}<br>

                        ${
                          addressLine2 ?
                            `${escapeHtml(addressLine2)}<br>` :
                            ""
}

                        ${
                          landmark ?
                            `${escapeHtml(landmark)}<br>` :
                            ""
}

                        ${escapeHtml(city)},
                        ${escapeHtml(state)}
                        ${escapeHtml(pincode)}<br>

                        ${escapeHtml(country)}

                      </div>

                      <!-- FOOTER MESSAGE -->

                      <p style="
                        margin-top: 30px;
                        color: #555555;
                        font-size: 14px;
                        line-height: 1.6;
                      ">
                        We will keep you updated as your order
                        moves through the delivery process.
                      </p>

                    </div>

                    <!-- FOOTER -->

                    <div style="
                      padding: 20px;
                      text-align: center;
                      background: #111111;
                      color: #aaaaaa;
                      font-size: 13px;
                    ">
                      LAG Clothing
                    </div>

                  </div>

                </body>

              </html>
            `,

            // Temporary verified sender.
            // Later change this to order@lagclothing.com.
            sender: {
              name: "Clothing App",
              email: "mhdsiddq17@gmail.com",
            },

            to: [
              {
                email: customerEmail,
                name: fullName,
              },
            ],
          });

        logger.info(
            "Order confirmation email sent successfully",
            {
              orderId,
              orderNumber,
              customerEmail,
              result,
            },
        );

        return;
      } catch (error) {
        logger.error(
            "Failed to send order confirmation email",
            {
              error: error.message,
              stack: error.stack,
            },
        );

        return;
      }
    },
);

/**
 * ============================================================
 * CONTACT FORM -> SEND EMAIL TO LAG CLOTHING
 * ============================================================
 *
 * Called from the Flutter Contact Us form.
 *
 * Expected data:
 *
 * {
 *   name: String,
 *   email: String,
 *   phone: String,
 *   message: String,
 * }
 *
 * The customer never receives the Brevo API key.
 * The API key remains inside Firebase Functions.
 *
 * Flow:
 *
 * Flutter Contact Form
 *        ↓
 * Firebase HTTPS Function
 *        ↓
 * Brevo
 *        ↓
 * LAG Clothing support email
 *
 */

exports.sendContactMessage = onRequest(
    {
      secrets: [brevoApiKey],
      region: "us-central1",
    },
    async (req, res) => {
      /**
       * --------------------------------------------------------
       * CORS
       * --------------------------------------------------------
       */

      res.set("Access-Control-Allow-Origin", "*");
      res.set("Access-Control-Allow-Methods", "POST, OPTIONS");
      res.set(
          "Access-Control-Allow-Headers",
          "Content-Type",
      );

      /**
       * Handle browser preflight request.
       */

      if (req.method === "OPTIONS") {
        res.status(204).send("");
        return;
      }

      /**
       * --------------------------------------------------------
       * ONLY POST REQUESTS
       * --------------------------------------------------------
       */

      if (req.method !== "POST") {
        res.status(405).json({
          success: false,
          message: "Method not allowed.",
        });

        return;
      }

      try {
        /**
         * --------------------------------------------------------
         * READ REQUEST BODY
         * --------------------------------------------------------
         */

        const body = req.body || {};

        const name =
      body.name != null?
       body.name.toString().trim(): "";

        const email =
  body.email != null?
   body.email.toString().trim(): "";

        const phone =
  body.phone != null?
   body.phone.toString().trim(): "";

        const message =
  body.message != null?
   body.message.toString().trim(): "";

        /**
         * --------------------------------------------------------
         * VALIDATION
         * --------------------------------------------------------
         */

        if (!name) {
          res.status(400).json({
            success: false,
            message: "Name is required.",
          });

          return;
        }

        if (!email) {
          res.status(400).json({
            success: false,
            message: "Email address is required.",
          });

          return;
        }

        if (!message) {
          res.status(400).json({
            success: false,
            message: "Message is required.",
          });

          return;
        }

        /**
         * Basic email validation.
         */

        const emailRegex =
          /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailRegex.test(email)) {
          res.status(400).json({
            success: false,
            message: "Please provide a valid email address.",
          });

          return;
        }

        /**
         * --------------------------------------------------------
         * ESCAPE USER INPUT
         * --------------------------------------------------------
         *
         * Never insert raw user input into HTML.
         */

        const safeName = escapeHtml(name);
        const safeEmail = escapeHtml(email);
        const safePhone = escapeHtml(
            phone || "Not provided",
        );
        const safeMessage = escapeHtml(message)
            .replace(/\n/g, "<br>");

        /**
         * --------------------------------------------------------
         * EMAIL CONFIGURATION
         * --------------------------------------------------------
         *
         * IMPORTANT:
         *
         * Keep this as your currently verified Brevo sender
         * until your LAG Clothing domain email is configured.
         */

        const sender = {
          name: "LAG Clothing",
          email: "mhdsiddq17@gmail.com",
        };

        /**
         * --------------------------------------------------------
         * SUPPORT EMAIL
         * --------------------------------------------------------
         *
         * Change this to the actual LAG Clothing support
         * email address when ready.
         *
         * For now we use the same email destination already
         * present in your existing Brevo test configuration.
         */

        const supportEmail =
          "abualmahdi07@gmail.com";

        /**
         * --------------------------------------------------------
         * BUILD EMAIL
         * --------------------------------------------------------
         */

        const htmlContent = `
          <!DOCTYPE html>
          <html>

            <head>
              <meta charset="UTF-8">
              <title>New Contact Message</title>
            </head>

            <body style="
              margin: 0;
              padding: 0;
              background-color: #f5f5f5;
              font-family: Arial, Helvetica, sans-serif;
            ">

              <div style="
                max-width: 650px;
                margin: 40px auto;
                background-color: #ffffff;
                border-radius: 12px;
                overflow: hidden;
              ">

                <!-- HEADER -->

                <div style="
                  background-color: #111111;
                  padding: 25px;
                  text-align: center;
                ">

                  <h1 style="
                    margin: 0;
                    color: #ffffff;
                    font-size: 28px;
                  ">
                    LAG Clothing
                  </h1>

                </div>

                <!-- CONTENT -->

                <div style="
                  padding: 30px;
                ">

                  <h2 style="
                    margin-top: 0;
                    color: #111111;
                  ">
                    New Contact Form Message
                  </h2>

                  <p style="
                    color: #555555;
                    font-size: 15px;
                    line-height: 1.6;
                  ">
                    A customer has submitted a new message
                    through the LAG Clothing Contact Us page.
                  </p>

                  <!-- CUSTOMER DETAILS -->

                  <div style="
                    margin-top: 25px;
                    padding: 20px;
                    background-color: #f7f7f7;
                    border-radius: 10px;
                  ">

                    <h3 style="
                      margin-top: 0;
                      color: #111111;
                    ">
                      Customer Details
                    </h3>

                    <p style="
                      margin: 8px 0;
                      color: #444444;
                    ">
                      <strong>Name:</strong>
                      ${safeName}
                    </p>

                    <p style="
                      margin: 8px 0;
                      color: #444444;
                    ">
                      <strong>Email:</strong>
                      ${safeEmail}
                    </p>

                    <p style="
                      margin: 8px 0;
                      color: #444444;
                    ">
                      <strong>Phone:</strong>
                      ${safePhone}
                    </p>

                  </div>

                  <!-- MESSAGE -->

                  <div style="
                    margin-top: 25px;
                    padding: 20px;
                    background-color: #ffffff;
                    border: 1px solid #e5e5e5;
                    border-radius: 10px;
                  ">

                    <h3 style="
                      margin-top: 0;
                      color: #111111;
                    ">
                      Message
                    </h3>

                    <p style="
                      margin: 0;
                      color: #444444;
                      font-size: 15px;
                      line-height: 1.7;
                    ">
                      ${safeMessage}
                    </p>

                  </div>

                  <!-- REPLY -->

                  <div style="
                    margin-top: 25px;
                    padding: 16px;
                    background-color: #f5f5f5;
                    border-radius: 8px;
                  ">

                    <p style="
                      margin: 0;
                      color: #555555;
                      font-size: 14px;
                    ">
                      To reply to this customer, use:
                      <strong>${safeEmail}</strong>
                    </p>

                  </div>

                </div>

                <!-- FOOTER -->

                <div style="
                  padding: 20px;
                  text-align: center;
                  background-color: #111111;
                  color: #aaaaaa;
                  font-size: 13px;
                ">

                  LAG Clothing<br>
                  Contact Us Notification

                </div>

              </div>

            </body>

          </html>
        `;

        /**
         * --------------------------------------------------------
         * SEND THROUGH BREVO
         * --------------------------------------------------------
         */

        const client = getBrevoClient();

        const result =
          await client.transactionalEmails.sendTransacEmail({
            subject:
              `LAG Clothing - New Contact Message from ${name}`,

            htmlContent: htmlContent,

            sender: sender,

            to: [
              {
                email: supportEmail,
                name: "LAG Clothing Support",
              },
            ],

            /**
             * Reply directly to the customer.
             *
             * When you open the email in your email client
             * and press Reply, it can reply to the customer.
             */

            replyTo: {
              email: email,
              name: name,
            },
          });

        /**
         * --------------------------------------------------------
         * LOG SUCCESS
         * --------------------------------------------------------
         */

        logger.info(
            "Contact form email sent successfully",
            {
              name: name,
              email: email,
              result: result,
            },
        );

        /**
         * --------------------------------------------------------
         * RESPONSE TO FLUTTER
         * --------------------------------------------------------
         */

        res.status(200).json({
          success: true,
          message:
            "Your message has been sent successfully.",
        });
      } catch (error) {
        /**
         * --------------------------------------------------------
         * ERROR HANDLING
         * --------------------------------------------------------
         */

        logger.error(
            "Contact form email failed",
            {
              error: error.message,
              stack: error.stack,
            },
        );

        res.status(500).json({
          success: false,
          message:
            "Unable to send your message right now. Please try again later.",
        });
      }
    },
);
