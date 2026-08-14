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
    // ------------------------------------------------------------
    // WebsiteLayout uses its default `scrollable: true`, exactly
    // like every other page (e.g. product details). The whole
    // page — header, cart body, and Footer — scrolls together,
    // so Footer always sits naturally after the cart content
    // instead of being squeezed into a fixed leftover height.
    // ------------------------------------------------------------
    return const WebsiteLayout(
      currentRoute: AppRouter.cart,
      child: Column(children: [CartHeader(), _CartBody()]),
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<CartProvider>().listenCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CartProvider>();

    final cartItems = provider.items;

    // ------------------------------------------------------------
    // A finite height (instead of Expanded) for the loading/error/
    // empty states, so they still look centered on screen without
    // requiring an unbounded-height ancestor to provide flex space.
    // ------------------------------------------------------------
    final centeredHeight = MediaQuery.sizeOf(context).height * 0.6;

    if (provider.isLoading) {
      return SizedBox(
        height: centeredHeight,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null && cartItems.isEmpty) {
      return SizedBox(
        height: centeredHeight,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 50),
                const SizedBox(height: 15),
                Text(provider.error!, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: provider.listenCart,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (cartItems.isEmpty) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: centeredHeight),
        child: const EmptyCart(),
      );
    }
    // ------------------------------------------------------------
    // Items exist — no need for its own SingleChildScrollView,
    // since the whole page (via WebsiteLayout) already scrolls.
    // ------------------------------------------------------------
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              children: [
                ...cartItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CartItem(item: item),
                  );
                }),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.go(AppRouter.shop);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Continue Shopping'),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 40),

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
