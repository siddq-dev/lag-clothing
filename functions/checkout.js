const {
  onCall,
  HttpsError,
} = require("firebase-functions/v2/https");

const admin = require("firebase-admin");

const db = admin.firestore();

const REGION = "us-central1";
const TAX_RATE = 0.05;

/**
 * Rounds a monetary value to 2 decimal places.
 * @param {number} value The value to round.
 * @return {number} The rounded value.
 */
function roundMoney(value) {
  return Math.round((Number(value) + Number.EPSILON) * 100) / 100;
}

/**
 * Safely trims a value to a string, returning "" for null/undefined.
 * @param {*} value The value to clean.
 * @return {string} The cleaned string.
 */
function cleanString(value) {
  return value == null ? "" : String(value).trim();
}

/**
 * Calculates the discount amount for a coupon against a subtotal.
 * @param {object} params The calculation params.
 * @return {number} The discount amount.
 */
function calculateCouponDiscount({
  coupon,
  subtotal,
  productIds,
}) {
  if (!coupon) {
    return 0;
  }

  if (coupon.active !== true) {
    throw new HttpsError(
        "failed-precondition",
        "This coupon is no longer active.",
    );
  }

  const now = new Date();

  if (coupon.startDate) {
    const startDate = coupon.startDate.toDate();
    if (now < startDate) {
      throw new HttpsError(
          "failed-precondition",
          "This coupon is not active yet.",
      );
    }
  }

  if (coupon.endDate) {
    const endDate = coupon.endDate.toDate();
    if (now > endDate) {
      throw new HttpsError(
          "failed-precondition",
          "This coupon has expired.",
      );
    }
  }

  const usageLimit = Number(coupon.usageLimit || 0);
  const usedCount = Number(coupon.usedCount || 0);

  if (usedCount >= usageLimit) {
    throw new HttpsError(
        "failed-precondition",
        "This coupon has reached its usage limit.",
    );
  }

  const minimumOrderAmount =
    Number(coupon.minimumOrderAmount || 0);

  if (subtotal < minimumOrderAmount) {
    throw new HttpsError(
        "failed-precondition",
        `Minimum order amount for this coupon is ${minimumOrderAmount}.`,
    );
  }

  const applicableProducts =
    Array.isArray(coupon.applicableProducts) ?
      coupon.applicableProducts :
      [];

  if (applicableProducts.length > 0) {
    const hasApplicableProduct = productIds.some(
        (productId) => applicableProducts.includes(productId),
    );

    if (!hasApplicableProduct) {
      throw new HttpsError(
          "failed-precondition",
          "This coupon does not apply to the products in your order.",
      );
    }
  }

  const discountType = cleanString(coupon.discountType);
  const discountValue = Number(coupon.discountValue || 0);
  const maximumDiscount = Number(coupon.maximumDiscount || 0);

  let discount = 0;

  if (discountType === "fixed") {
    discount = discountValue;
  } else {
    discount = subtotal * (discountValue / 100);

    if (maximumDiscount > 0) {
      discount = Math.min(discount, maximumDiscount);
    }
  }

  discount = Math.min(discount, subtotal);

  return roundMoney(Math.max(0, discount));
}

exports.createSecureOrder = onCall(
    {
      region: REGION,
    },
    async (request) => {
    // ==========================================================
    // AUTHENTICATION
    // ==========================================================

      if (!request.auth) {
        throw new HttpsError(
            "unauthenticated",
            "You must be signed in to place an order.",
        );
      }

      const uid = request.auth.uid;
      const data = request.data || {};

      // ==========================================================
      // BASIC INPUT VALIDATION
      // ==========================================================

      const items = Array.isArray(data.items) ?
      data.items :
      [];

      if (items.length === 0) {
        throw new HttpsError(
            "invalid-argument",
            "Your cart is empty.",
        );
      }

      const shippingAddress = data.shippingAddress;

      const billingAddress = data.billingAddress;

      const paymentMethod = cleanString(data.paymentMethod);

      if (!shippingAddress || typeof shippingAddress !== "object") {
        throw new HttpsError(
            "invalid-argument",
            "Shipping address is required.",
        );
      }

      if (!billingAddress || typeof billingAddress !== "object") {
        throw new HttpsError(
            "invalid-argument",
            "Billing address is required.",
        );
      }

      if (!paymentMethod) {
        throw new HttpsError(
            "invalid-argument",
            "Payment method is required.",
        );
      }

      // ==========================================================
      // NORMALIZE CART ITEMS
      // ==========================================================

      const normalizedItems = items.map((item) => {
        if (!item || typeof item !== "object") {
          throw new HttpsError(
              "invalid-argument",
              "Invalid cart item.",
          );
        }

        const productId = cleanString(item.productId);
        const sku = cleanString(item.sku);
        const size = cleanString(item.size);
        const color = cleanString(item.color);
        const quantity = Number(item.quantity);

        if (!productId) {
          throw new HttpsError(
              "invalid-argument",
              "A cart item is missing its product ID.",
          );
        }

        if (!Number.isInteger(quantity) || quantity <= 0) {
          throw new HttpsError(
              "invalid-argument",
              "Cart quantity must be a positive integer.",
          );
        }

        return {
          productId,
          sku,
          size,
          color,
          quantity,
        };
      });

      // ==========================================================
      // COUPON
      // ==========================================================

      const couponCode = cleanString(data.couponCode).toUpperCase();

      // ==========================================================
      // FIRESTORE TRANSACTION
      // ==========================================================

      const result = await db.runTransaction(async (transaction) => {
      // --------------------------------------------------------
      // PRODUCT REFERENCES
      // --------------------------------------------------------

        const productIds = [
          ...new Set(
              normalizedItems.map((item) => item.productId),
          ),
        ];

        const productRefs = productIds.map((productId) =>
          db.collection("products").doc(productId),
        );

        const productSnapshots = await Promise.all(
            productRefs.map((ref) => transaction.get(ref)),
        );

        const products = new Map();

        for (let i = 0; i < productRefs.length; i++) {
          const snapshot = productSnapshots[i];

          if (!snapshot.exists) {
            throw new HttpsError(
                "not-found",
                `Product not found: ${productIds[i]}`,
            );
          }

          products.set(
              productIds[i],
              {
                ref: productRefs[i],
                snapshot,
                data: snapshot.data(),
              },
          );
        }

        // --------------------------------------------------------
        // VALIDATE PRODUCTS + CALCULATE SUBTOTAL
        // --------------------------------------------------------

        let subtotal = 0;

        const orderItems = [];

        // Product-level stock changes.
        const productStockChanges = new Map();

        // Variant-level stock changes.
        const variantChanges = new Map();

        for (const item of normalizedItems) {
          const product = products.get(item.productId);

          if (!product || !product.data) {
            throw new HttpsError(
                "not-found",
                `Product not found: ${item.productId}`,
            );
          }

          const productData = product.data;

          const productName =
          cleanString(productData.name) ||
          cleanString(item.productName) ||
          "Product";

          const productImage =
          cleanString(productData.image) ||
          cleanString(item.productImage);

          // ------------------------------------------------------
          // PRODUCT PRICE
          // ------------------------------------------------------

          const regularPrice =
          productData.price == null ?
            null :
            Number(productData.price);

          if (
            regularPrice == null ||
          !Number.isFinite(regularPrice) ||
          regularPrice < 0
          ) {
            throw new HttpsError(
                "failed-precondition",
                `Unable to verify price for ${productName}.`,
            );
          }

          const salePrice =
          productData.salePrice == null ?
            null :
            Number(productData.salePrice);

          const effectivePrice =
          salePrice != null &&
          Number.isFinite(salePrice) &&
          salePrice > 0 ?
            salePrice :
            regularPrice;

          // ------------------------------------------------------
          // PRODUCT STOCK
          // ------------------------------------------------------

          const currentStock =
          Number(productData.stock || 0);

          const requestedProductStock =
          productStockChanges.get(item.productId) || 0;

          const newRequestedProductStock =
          requestedProductStock + item.quantity;

          if (
            currentStock <
          newRequestedProductStock
          ) {
            throw new HttpsError(
                "failed-precondition",
                `Insufficient stock for ${productName}.`,
            );
          }

          productStockChanges.set(
              item.productId,
              newRequestedProductStock,
          );

          // ------------------------------------------------------
          // VARIANT VALIDATION
          // ------------------------------------------------------

          const variants = productData.variants;

          let matchingVariant = null;

          if (Array.isArray(variants)) {
            matchingVariant = variants.find(
                (variant) =>
                  variant &&
              cleanString(variant.sku) === item.sku,
            );

            if (!matchingVariant) {
              throw new HttpsError(
                  "failed-precondition",
                  `Variant ${item.color} / ${item.size} for ` +
                  `${productName} no longer exists.`,
              );
            }

            const variantStock =
            Number(matchingVariant.stock || 0);

            const variantKey =
            `${item.productId}::${item.sku}`;

            const requestedVariantStock =
            variantChanges.get(variantKey) || 0;

            const newRequestedVariantStock =
            requestedVariantStock + item.quantity;

            if (
              variantStock <
            newRequestedVariantStock
            ) {
              throw new HttpsError(
                  "failed-precondition",
                  `Insufficient stock for ${productName} ` +
                  `(${item.color} / ${item.size}).`,
              );
            }

            variantChanges.set(
                variantKey,
                newRequestedVariantStock,
            );
          }

          // ------------------------------------------------------
          // SERVER-TRUSTED ORDER ITEM
          // ------------------------------------------------------

          const lineTotal =
          roundMoney(effectivePrice * item.quantity);

          subtotal = roundMoney(
              subtotal + lineTotal,
          );

          orderItems.push({
            productId: item.productId,
            productName,
            productImage,
            size: item.size,
            color: item.color,
            quantity: item.quantity,
            price: roundMoney(effectivePrice),
            total: lineTotal,
          });
        }

        // --------------------------------------------------------
        // TAX
        // --------------------------------------------------------

        const tax = roundMoney(
            subtotal * TAX_RATE,
        );

        // --------------------------------------------------------
        // COUPON
        // --------------------------------------------------------

        let discount = 0;

        let couponSnapshot = null;
        let couponRef = null;

        if (couponCode) {
          const couponQuerySnapshot = await db
              .collection("coupon_codes")
              .where("code", "==", couponCode)
              .limit(1)
              .get();

          if (couponQuerySnapshot.empty) {
            throw new HttpsError(
                "not-found",
                "Invalid coupon code.",
            );
          }

          couponRef = couponQuerySnapshot.docs[0].ref;

          couponSnapshot = await transaction.get(couponRef);

          if (!couponSnapshot.exists) {
            throw new HttpsError(
                "not-found",
                "Invalid coupon code.",
            );
          }

          const couponData = couponSnapshot.data();

          discount = calculateCouponDiscount({
            coupon: couponData,
            subtotal,
            productIds,
          });
        }

        // --------------------------------------------------------
        // GRAND TOTAL
        // --------------------------------------------------------

        const grandTotal = roundMoney(
            Math.max(
                0,
                subtotal + tax - discount,
            ),
        );

        // --------------------------------------------------------
        // ORDER IDENTIFIERS
        // --------------------------------------------------------

        const orderRef =
        db.collection("orders").doc();

        const now =
        admin.firestore.FieldValue.serverTimestamp();

        const orderNumber =
        `LAG${Date.now()}`;

        const trackingId =
        `TRK${Date.now()}`;

        // --------------------------------------------------------
        // UPDATE PRODUCTS
        // --------------------------------------------------------

        for (const [productId, quantity] of productStockChanges) {
          const product = products.get(productId);

          const productData = product.data;

          const currentStock =
          Number(productData.stock || 0);

          const updateData = {
            stock: currentStock - quantity,
            soldCount:
            admin.firestore.FieldValue.increment(quantity),
            updatedAt: now,
          };

          // ------------------------------------------------------
          // UPDATE VARIANTS
          // ------------------------------------------------------

          if (Array.isArray(productData.variants)) {
            const updatedVariants =
            productData.variants.map((rawVariant) => {
              if (
                !rawVariant ||
                typeof rawVariant !== "object"
              ) {
                return rawVariant;
              }

              const variant = {
                ...rawVariant,
              };

              const sku =
                cleanString(variant.sku);

              const key =
                `${productId}::${sku}`;

              const quantityToRemove =
                variantChanges.get(key) || 0;

              if (quantityToRemove > 0) {
                const variantStock =
                  Number(variant.stock || 0);

                const newVariantStock =
                  variantStock - quantityToRemove;

                variant.stock =
                  newVariantStock;

                variant.available =
                  newVariantStock > 0;
              }

              return variant;
            });

            updateData.variants =
            updatedVariants;
          }

          transaction.update(
              product.ref,
              updateData,
          );

          // ------------------------------------------------------
          // INVENTORY LOG
          // ------------------------------------------------------

          const inventoryLogRef =
          db.collection("inventory_logs").doc();

          transaction.set(
              inventoryLogRef,
              {
                id: inventoryLogRef.id,
                productId,
                productName:
              cleanString(productData.name) ||
              "Product",
                type: "stockOut",
                quantity,
                previousStock: currentStock,
                newStock:
              currentStock - quantity,
                reference: orderNumber,
                performedBy: uid,
                createdAt: now,
              },
          );
        }

        // --------------------------------------------------------
        // INCREMENT COUPON USAGE
        // --------------------------------------------------------

        if (couponSnapshot && couponRef) {
          transaction.update(
              couponSnapshot.ref,
              {
                usedCount:
              admin.firestore.FieldValue.increment(1),
                updatedAt: now,
              },
          );
        }

        // --------------------------------------------------------
        // CREATE ORDER
        // --------------------------------------------------------

        transaction.set(
            orderRef,
            {
              id: orderRef.id,
              userId: uid,

              orderNumber,
              trackingId,

              shippingAddress,
              billingAddress,

              items: orderItems,

              paymentMethod,
              paymentStatus: "pending",
              orderStatus: "pending",

              subtotal,
              tax,
              discount,
              grandTotal,

              ...(couponCode ?
            {
              couponCode,
            } :
            {}),

              createdAt: now,
              updatedAt: now,
            },
        );

        return {
          orderId: orderRef.id,
          orderNumber,
          trackingId,
          subtotal,
          tax,
          discount,
          grandTotal,
        };
      });

      return result;
    },
);
