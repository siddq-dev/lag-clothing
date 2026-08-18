import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lag_clothing/features/admin/orders/widgets/order_information_card.dart';

import '../../../../routes/app_routes.dart';

import '../widgets/customer_information_card.dart';
import '../widgets/order_items_table.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_information_card.dart';
import '../widgets/shipping_information_card.dart';
import '../widgets/order_timeline.dart';
import '../widgets/update_order_status_card.dart';
import '../widgets/order_action_buttons.dart';
import '../widgets/order_notes_card.dart';
import '../widgets/address_information_card.dart';
import '../widgets/payment_status_dropdown.dart';
import '../widgets/invoice_buttons.dart';

import '../../../super_admin/dashboard/widgets/super_admin_sidebar.dart';

class AdminOrderDetailsPage extends StatelessWidget {
  final dynamic order;

  const AdminOrderDetailsPage({super.key, required this.order});

  // ============================================================
  // BACK TO ORDERS
  // ============================================================

  void _goBackToOrders(BuildContext context) {
    context.go(AppRouter.adminOrderDetails);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    if (isMobile) {
      return _buildMobile(context);
    }

    return _buildDesktop(context);
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // ========================================================
          // DESKTOP SIDEBAR
          // ========================================================
          const SizedBox(
            width: 260,
            child: SuperAdminSidebar(currentRoute: AppRouter.adminOrderDetails),
          ),

          // ========================================================
          // MAIN CONTENT
          // ========================================================
          Expanded(
            child: Container(
              color: Colors.black,
              child: _buildDesktopContent(context),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP CONTENT
  // ============================================================

  Widget _buildDesktopContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ========================================================
          // DESKTOP HEADER
          // ========================================================
          _buildDesktopHeader(context),

          const SizedBox(height: 25),

          // ========================================================
          // ORDER INFORMATION
          // ========================================================
          OrderInformationCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ADDRESS INFORMATION
          // ========================================================
          AddressInformationCard(
            shippingAddress: order.shippingAddress,
            billingAddress: order.billingAddress,
          ),

          const SizedBox(height: 20),

          // ========================================================
          // PAYMENT STATUS
          // ========================================================
          PaymentStatusDropdown(order: order),

          const SizedBox(height: 20),

          // ========================================================
          // INVOICE
          // ========================================================
          InvoiceButtons(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // CUSTOMER INFORMATION
          // ========================================================
          CustomerInformationCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // SHIPPING INFORMATION
          // ========================================================
          ShippingInformationCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // PAYMENT INFORMATION
          // ========================================================
          PaymentInformationCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // INVOICE BUTTONS
          // ========================================================
          InvoiceButtons(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ORDER ITEMS
          // ========================================================
          OrderItemsTable(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ORDER SUMMARY
          // ========================================================
          OrderSummaryCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ORDER TIMELINE
          // ========================================================
          OrderTimeline(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // UPDATE ORDER STATUS
          // ========================================================
          UpdateOrderStatusCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ORDER NOTES
          // ========================================================
          OrderNotesCard(order: order),

          const SizedBox(height: 24),

          // ========================================================
          // ORDER ACTIONS
          // ========================================================
          OrderActionButtons(order: order),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP HEADER
  // ============================================================

  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --------------------------------------------------------
        // BACK BUTTON
        // --------------------------------------------------------
        IconButton(
          tooltip: 'Back to Orders',
          onPressed: () => _goBackToOrders(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),

        const SizedBox(width: 8),

        // --------------------------------------------------------
        // TITLE
        // --------------------------------------------------------
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 6),

              Text(
                'View and manage customer order information.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================================================
      // MOBILE APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        // --------------------------------------------------------
        // BACK BUTTON
        // --------------------------------------------------------
        leading: IconButton(
          tooltip: 'Back to Orders',
          onPressed: () => _goBackToOrders(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),

        // --------------------------------------------------------
        // TITLE
        // --------------------------------------------------------
        title: const Text(
          'Order Details',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // No hamburger
        // No extra actions
        actions: const [],
      ),

      // ==========================================================
      // MOBILE BODY
      // ==========================================================
      body: SafeArea(child: _buildMobileContent()),
    );
  }

  // ============================================================
  // MOBILE CONTENT
  // ============================================================

  Widget _buildMobileContent() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // MOBILE PAGE HEADER
            // ======================================================
            const Text(
              'Order Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'View and manage order information.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // ORDER INFORMATION
            // ======================================================
            OrderInformationCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ADDRESS INFORMATION
            // ======================================================
            AddressInformationCard(
              shippingAddress: order.shippingAddress,
              billingAddress: order.billingAddress,
            ),

            const SizedBox(height: 18),

            // ======================================================
            // PAYMENT STATUS
            // ======================================================
            PaymentStatusDropdown(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // INVOICE
            // ======================================================
            InvoiceButtons(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // CUSTOMER INFORMATION
            // ======================================================
            CustomerInformationCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // SHIPPING INFORMATION
            // ======================================================
            ShippingInformationCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // PAYMENT INFORMATION
            // ======================================================
            PaymentInformationCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // INVOICE
            // ======================================================
            InvoiceButtons(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ORDER ITEMS
            // ======================================================
            OrderItemsTable(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ORDER SUMMARY
            // ======================================================
            OrderSummaryCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ORDER TIMELINE
            // ======================================================
            OrderTimeline(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // UPDATE ORDER STATUS
            // ======================================================
            UpdateOrderStatusCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ORDER NOTES
            // ======================================================
            OrderNotesCard(order: order),

            const SizedBox(height: 18),

            // ======================================================
            // ORDER ACTIONS
            // ======================================================
            OrderActionButtons(order: order),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
