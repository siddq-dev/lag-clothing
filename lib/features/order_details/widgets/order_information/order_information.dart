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

  // ============================================================
  // DELIVERY TITLE
  // ============================================================

  String get deliveryTitle {
    switch (status.toLowerCase()) {
      case 'delivered':
        return 'Delivered On';

      case 'shipped':
      case 'processing':
      case 'confirmed':
      case 'packed':
      case 'out for delivery':
        return 'Expected Delivery';

      case 'cancelled':
      case 'refund requested':
      case 'exchange requested':
      case 'returned':
        return 'Delivery';

      default:
        return 'Delivery';
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Mobile breakpoint
    final isMobile = width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======================================================
          // TITLE
          // ======================================================
          Text('Order Information', style: AppTextStyles.heading2),

          SizedBox(height: isMobile ? AppSpacing.lg : AppSpacing.xl),

          // ======================================================
          // STATUS
          // ======================================================
          if (isMobile) _buildMobileStatus() else _buildDesktopStatus(),

          SizedBox(height: isMobile ? 16 : 18),

          // ======================================================
          // ORDER ID
          // ======================================================
          _buildResponsiveInfoRow(
            title: 'Order ID',
            value: orderId,
            isMobile: isMobile,
          ),

          SizedBox(height: isMobile ? 16 : 18),

          // ======================================================
          // ORDER DATE
          // ======================================================
          _buildResponsiveInfoRow(
            title: 'Order Date',
            value: orderDate,
            isMobile: isMobile,
          ),

          SizedBox(height: isMobile ? 16 : 18),

          // ======================================================
          // DELIVERY
          // ======================================================
          _buildResponsiveInfoRow(
            title: deliveryTitle,
            value: status.toLowerCase() == 'cancelled' ? '-' : deliveryDate,
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP STATUS
  // ============================================================

  Widget _buildDesktopStatus() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 170,
          child: Text('Status', style: AppTextStyles.bodyLarge),
        ),

        Flexible(child: StatusBadge(status: status)),
      ],
    );
  }

  // ============================================================
  // MOBILE STATUS
  // ============================================================

  Widget _buildMobileStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Status', style: AppTextStyles.bodyLarge),

        const SizedBox(height: 8),

        // Flexible width prevents the badge from forcing
        // the parent Row/Column beyond the screen width.
        Align(
          alignment: Alignment.centerLeft,
          child: StatusBadge(status: status),
        ),
      ],
    );
  }

  // ============================================================
  // RESPONSIVE INFORMATION ROW
  // ============================================================

  Widget _buildResponsiveInfoRow({
    required String title,
    required String value,
    required bool isMobile,
  }) {
    if (isMobile) {
      return _buildMobileInfoRow(title: title, value: value);
    }

    return _buildDesktopInfoRow(title: title, value: value);
  }

  // ============================================================
  // DESKTOP INFORMATION ROW
  // ============================================================

  Widget _buildDesktopInfoRow({required String title, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 170,
          child: Text(title, style: AppTextStyles.bodyLarge),
        ),

        Expanded(
          child: Text(
            value,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE INFORMATION ROW
  // ============================================================

  Widget _buildMobileInfoRow({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --------------------------------------------------------
        // LABEL
        // --------------------------------------------------------
        Text(title, style: AppTextStyles.bodyLarge),

        const SizedBox(height: 7),

        // --------------------------------------------------------
        // VALUE
        // --------------------------------------------------------
        SizedBox(
          width: double.infinity,
          child: Text(
            value,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
