import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/cart_provider.dart';
import '../../../../providers/coupon_provider.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';

class CouponBox extends StatefulWidget {
  const CouponBox({super.key});

  @override
  State<CouponBox> createState() => _CouponBoxState();
}

class _CouponBoxState extends State<CouponBox> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon() async {
    final couponProvider = context.read<CouponProvider>();

    final cartProvider = context.read<CartProvider>();

    final subtotal = cartProvider.subtotal;

    final productIds = cartProvider.items.map((e) => e.productId).toList();

    final success = await couponProvider.applyCoupon(
      code: _controller.text.trim(),
      subtotal: subtotal,
      productIds: productIds,
    );

    if (!mounted) return;

    if (success) {
      context.read<CartProvider>().applyDiscount(couponProvider.discount);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text("Coupon Applied (${couponProvider.couponCode})"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(couponProvider.error ?? "Invalid Coupon"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final couponProvider = context.watch<CouponProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (couponProvider.coupon != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified, color: Colors.green),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    couponProvider.couponCode,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Text(
                  "- ₹${couponProvider.discount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    couponProvider.removeCoupon();

                    context.read<CartProvider>().removeDiscount();

                    _controller.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Enter Coupon Code",
                  ),
                ),
              ),

              const SizedBox(width: AppSpacing.md),

              ElevatedButton(
                onPressed: couponProvider.isLoading ? null : _applyCoupon,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: couponProvider.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text("Apply"),
              ),
            ],
          ),
      ],
    );
  }
}
