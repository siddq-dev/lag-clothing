import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../../../models/cart_models.dart';
import '../../../models/feature_product_model.dart';

import '../widgets/checkout_header/checkout_header.dart';
import '../widgets/shipping_form/shipping_form.dart';
import '../widgets/payment_section/payment_section.dart';
import '../widgets/billing_address/billing_address.dart';
import '../widgets/order_review/order_review.dart';
import '../widgets/checkout_summary/checkout_summary.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CartProduct> cartItems = [

      CartProduct(
        product: shopProducts[0],
        quantity: 1,
      ),

      CartProduct(
        product: shopProducts[3],
        quantity: 2,
      ),

      CartProduct(
        product: shopProducts[6],
        quantity: 1,
      ),

    ];

    return WebsiteLayout(
      currentRoute: AppRouter.checkout,
      child: Column(
        children: [

          const CheckoutHeader(),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 50,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {

                /// Mobile Layout
                if (constraints.maxWidth < 900) {
                  return Column(
                    children: [

                      const ShippingForm(),

                      const SizedBox(height: 30),

                      const PaymentSection(),

                      const SizedBox(height: 30),

                      const BillingAddress(),

                      const SizedBox(height: 30),

                      OrderReview(
                        cartItems: cartItems,
                      ),

                      const SizedBox(height: 30),

                      const CheckoutSummary(),

                    ],
                  );
                }

                /// Desktop Layout
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [

                          const ShippingForm(),

                          const SizedBox(height: 30),

                          const PaymentSection(),

                          const SizedBox(height: 30),

                          const BillingAddress(),

                        ],
                      ),
                    ),

                    const SizedBox(width: 32),

                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [

                          OrderReview(
                            cartItems: cartItems,
                          ),

                          const SizedBox(height: 30),

                          const CheckoutSummary(),

                        ],
                      ),
                    ),

                  ],
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}