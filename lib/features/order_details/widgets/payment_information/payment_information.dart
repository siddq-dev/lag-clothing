import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class PaymentInformation extends StatelessWidget {
  const PaymentInformation({
    super.key,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.transactionId,
    required this.paymentDate,
  });

  final String paymentMethod;
  final String paymentStatus;
  final String transactionId;
  final String paymentDate;

  Color get statusColor {
    switch (paymentStatus.toLowerCase()) {
      case "successful":
        return Colors.green;

      case "pending":
        return Colors.orange;

      case "failed":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData get statusIcon {
    switch (paymentStatus.toLowerCase()) {
      case "successful":
        return Icons.check_circle;

      case "pending":
        return Icons.schedule;

      case "failed":
        return Icons.cancel;

      default:
        return Icons.info;
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
            "Payment Information",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          _infoRow(
            "Payment Method",
            paymentMethod,
          ),

          const SizedBox(height: 18),

          Row(
            children: [

              SizedBox(
                width: 170,
                child: Text(
                  "Payment Status",
                  style: AppTextStyles.bodyLarge,
                ),
              ),

              Icon(
                statusIcon,
                color: statusColor,
                size: 22,
              ),

              const SizedBox(width: 10),

              Text(
                paymentStatus,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          _infoRow(
            "Transaction ID",
            transactionId,
          ),

          const SizedBox(height: 18),

          _infoRow(
            "Paid On",
            paymentDate,
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
      crossAxisAlignment: CrossAxisAlignment.start,
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