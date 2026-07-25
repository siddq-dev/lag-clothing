import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

import '../../../my_orders/widgets/status_badge/status_badge.dart';

class OrderInformation extends StatelessWidget {
  const OrderInformation({
    super.key,
    required this.status,
    required this.orderId,
    required this.orderDate,
    required this.deliveryDate,
  });

  final String status;
  final String orderId;
  final String orderDate;
  final String deliveryDate;

  String get deliveryTitle {
    switch (status.toLowerCase()) {
      case "delivered":
        return "Delivered On";

      case "shipped":
      case "processing":
        return "Expected Delivery";

      case "cancelled":
        return "Delivery";

      default:
        return "Delivery";
    }
  }

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
            "Order Information",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          Row(
            children: [

              SizedBox(
                width: 170,
                child: Text(
                  "Status",
                  style: AppTextStyles.bodyLarge,
                ),
              ),

              StatusBadge(
                status: status,
              ),

            ],
          ),

          const SizedBox(height: 18),

          _infoRow(
            "Order ID",
            orderId,
          ),

          const SizedBox(height: 18),

          _infoRow(
            "Order Date",
            orderDate,
          ),

          const SizedBox(height: 18),

          _infoRow(
            deliveryTitle,
            status.toLowerCase() == "cancelled"
                ? "-"
                : deliveryDate,
          ),

        ],
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value,
  ) {
    return Row(
      children: [

        SizedBox(
          width: 170,
          child: Text(
            title,
            style: AppTextStyles.bodyLarge,
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white,
            ),
          ),
        ),

      ],
    );
  }
}