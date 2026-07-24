import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../detail_row/detail_row.dart';

class ConfirmationDetails extends StatelessWidget {
  const ConfirmationDetails({super.key});

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
      child: const Column(
        children: [

          DetailRow(
            title: "Order ID",
            value: "#LAG202607230001",
          ),

          DetailRow(
            title: "Payment Status",
            value: "Successful",
            icon: Icons.check_circle,
            valueColor: Colors.green,
          ),

          DetailRow(
            title: "Order Amount",
            value: "₹6096",
            valueColor: Colors.white,
          ),

          DetailRow(
            title: "Estimated Delivery",
            value: "25 Jul – 27 Jul 2026",
          ),

        ],
      ),
    );
  }
}