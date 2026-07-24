import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({
    super.key,
    required this.currentStep,
  });

  /// 0 = Order Confirmed
  /// 1 = Packed
  /// 2 = Shipped
  /// 3 = Out For Delivery
  /// 4 = Delivered
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final steps = [
      "Order Confirmed",
      "Packed",
      "Shipped",
      "Out For Delivery",
      "Delivered",
    ];

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
            "Order Timeline",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          ...List.generate(steps.length, (index) {

            final completed = index <= currentStep;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Column(
                  children: [

                    CircleAvatar(
                      radius: 13,
                      backgroundColor: completed
                          ? Colors.green
                          : Colors.grey.shade700,
                      child: Icon(
                        completed
                            ? Icons.check
                            : Icons.circle,
                        size: completed ? 16 : 10,
                        color: Colors.white,
                      ),
                    ),

                    if (index != steps.length - 1)
                      Container(
                        width: 2,
                        height: 42,
                        color: completed
                            ? Colors.green
                            : Colors.grey.shade700,
                      ),

                  ],
                ),

                const SizedBox(width: 18),

                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    steps[index],
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: completed
                          ? Colors.white
                          : Colors.grey.shade500,
                      fontWeight: completed
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),

              ],
            );
          }),

        ],
      ),
    );
  }
}