import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../../../models/feature_product_model.dart';
import '../../../models/cart_models.dart';

import '../widgets/cart_header/cart_header.dart';
import '../widgets/cart_item/cart_item.dart';
import '../widgets/order_summary/order_summary.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.cart,
      child: Column(
        children: const [

          CartHeader(),

          _CartBody(),

        ],
      ),
    );
  }
}

class _CartBody extends StatelessWidget {
  const _CartBody();

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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// LEFT SIDE
          Expanded(
            flex: 7,
            child: Column(
              children: [

                ...cartItems.map(
                  (item) => CartItem(
                    product: item.product,
                    quantity: item.quantity,
                  ),
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.shop,
                      );
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      "Continue Shopping",
                    ),
                  ),
                ),

              ],
            ),
          ),

          const SizedBox(width: 40),

          /// RIGHT SIDE
          Expanded(
            flex: 3,
            child: OrderSummary(
              cartItems: cartItems,
            ),
          ),

        ],
      ),
    );
  }
}