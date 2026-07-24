import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

import '../order_item/order_item.dart';
import '../status_badge/status_badge.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.status,
    required this.orderId,
    required this.orderDate,
    required this.deliveryDate,
    required this.totalAmount,
    required this.itemsCount,
    required this.items,
  });

  final String status;
  final String orderId;
  final String orderDate;
  final String deliveryDate;
  final double totalAmount;
  final int itemsCount;
  final List<OrderItem> items;

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
      margin: const EdgeInsets.only(bottom: 30),
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

          /// STATUS
          StatusBadge(status: status),

          const SizedBox(height: 24),

          _infoRow("Order ID", orderId),

          const SizedBox(height: 12),

          _infoRow("Order Date", orderDate),

          const SizedBox(height: 12),

          _infoRow(
            deliveryTitle,
            status.toLowerCase() == "cancelled"
                ? "-"
                : deliveryDate,
          ),

          const SizedBox(height: 12),

          _infoRow(
            "Items",
            "$itemsCount Jerseys",
          ),

          const SizedBox(height: 12),

          _infoRow(
            "Amount",
            "₹${totalAmount.toStringAsFixed(0)}",
            isAmount: true,
          ),

          const SizedBox(height: 25),

          const Divider(),

          const SizedBox(height: 20),

          ...items,

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              if (status.toLowerCase() != "delivered" &&
                  status.toLowerCase() != "cancelled")
                OutlinedButton.icon(
                  onPressed: () {
                    // Track Order
                  },
                  icon: const Icon(Icons.local_shipping_outlined),
                  label: const Text("Track Order"),
                ),

              if (status.toLowerCase() == "processing")
                const SizedBox(width: 12),

              if (status.toLowerCase() == "processing")
                OutlinedButton.icon(
                  onPressed: () {
                    // Cancel Order
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  icon: const Icon(Icons.cancel_outlined),
                  label: const Text("Cancel"),
                ),

              const SizedBox(width: 12),

              ElevatedButton.icon(
                onPressed: () {
                  // View Details
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text("View Details"),
              ),

            ],
          ),

        ],
      ),
    );
  }

  Widget _infoRow(
    String title,
    String value, {
    bool isAmount = false,
  }) {
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
            style: isAmount
                ? AppTextStyles.heading3.copyWith(
                    color: AppColors.primary,
                  )
                : AppTextStyles.bodyLarge,
          ),
        ),

      ],
    );
  }
}