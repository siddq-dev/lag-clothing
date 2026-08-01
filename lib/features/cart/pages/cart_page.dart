import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../providers/cart_provider.dart';
import '../../../routes/app_routes.dart';

import '../widgets/cart_header/cart_header.dart';
import '../widgets/cart_item/cart_item.dart';
import '../widgets/order_summary/order_summary.dart';
import '../widgets/empty_cart/empty_cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebsiteLayout(
      currentRoute: AppRouter.cart,
      child: Column(
        children: [
          CartHeader(),
          Expanded(
            child: _CartBody(),
          ),
        ],
      ),
    );
  }
}

class _CartBody extends StatefulWidget {
  const _CartBody();

  @override
  State<_CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<_CartBody> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CartProvider>().listenCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CartProvider>();
    final cartItems = provider.items;

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Text(provider.error!),
      );
    }

    if (cartItems.isEmpty) {
      return const EmptyCart();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 40,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //--------------------------------------------------
          // LEFT SIDE
          //--------------------------------------------------

          Expanded(
            flex: 7,
            child: Column(
              children: [
                ...cartItems.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CartItem(
                      item: item,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.go(AppRouter.shop);
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

          //--------------------------------------------------
          // RIGHT SIDE
          //--------------------------------------------------

          Expanded(
            flex: 3,
            child: OrderSummary(
              subtotal: provider.subtotal,
              shipping: provider.shipping,
              tax: provider.tax,
              discount: provider.discount,
              total: provider.grandTotal,
            ),
          ),
        ],
      ),
    );
  }
}