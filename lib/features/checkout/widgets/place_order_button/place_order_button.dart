import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../../themes/app_colors.dart';

class PlaceOrderButton extends StatelessWidget {
  const PlaceOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckoutProvider>();

    final isLoading = provider.isLoading;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        icon: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.shopping_bag_outlined),
        label: Text(
          isLoading ? 'Placing Order...' : 'Place Order',
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: isLoading
            ? null
            : () async {
                final success = await provider.placeOrder();

                if (!context.mounted) {
                  return;
                }

                if (success) {
                  context.go(AppRouter.orderSuccess);

                  return;
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(provider.error ?? 'Order Failed')),
                );
              },
      ),
    );
  }
}
