import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

import '../../../my_orders/widgets/order_item/order_item.dart';

class OrderedProducts extends StatelessWidget {
  const OrderedProducts({
    super.key,
    required this.items,
  });

  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "Ordered Products",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          ...items,

        ],
      ),
    );
  }
}