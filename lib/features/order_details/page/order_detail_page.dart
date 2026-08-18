import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../../../models/order_model.dart';

import '../widgets/order_information/order_information.dart';
import '../widgets/order_item/order_item.dart';
import '../widgets/shipping_information/shipping_information.dart';
import '../widgets/payment_information/payment_information.dart';
import '../widgets/order_timeline/order_timeline.dart';
import '../widgets/order_summary/order_summary.dart';
import '../widgets/action_buttons/action_buttons.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

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
    return WebsiteLayout(
      currentRoute: AppRouter.adminOrderDetails,
      child: Container(
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: _buildDesktopContent(context),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DESKTOP CONTENT
  // ============================================================

  Widget _buildDesktopContent(BuildContext context) {
    final orderDate = order.createdAt != null
        ? _formatDate(order.createdAt!.toDate())
        : '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ========================================================
        // HEADER
        // ========================================================
        _desktopHeader(context),

        const SizedBox(height: 28),

        // ========================================================
        // ORDER INFORMATION
        // ========================================================
        _sectionContainer(
          child: OrderInformation(
            status: _formatStatus(order.orderStatus),
            orderId: '#${order.orderNumber}',
            orderDate: orderDate,
            deliveryDate: '-',
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // ORDER ITEMS
        // ========================================================
        _sectionContainer(child: OrderItems(items: order.items)),

        const SizedBox(height: 20),

        // ========================================================
        // SHIPPING INFORMATION
        // ========================================================
        _sectionContainer(
          child: ShippingInformation(
            name: order.shippingAddress.fullName,
            phone: order.shippingAddress.phone,
            addressLine1: order.shippingAddress.addressLine1,
            addressLine2: order.shippingAddress.addressLine2,
            city: order.shippingAddress.city,
            state: order.shippingAddress.state,
            pincode: order.shippingAddress.pincode,
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // PAYMENT INFORMATION
        // ========================================================
        _sectionContainer(
          child: PaymentInformation(
            paymentMethod: _formatPaymentMethod(order.paymentMethod),
            paymentStatus: _formatPaymentStatus(order.paymentStatus),
            transactionId: '-',
            paymentDate: orderDate,
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // ORDER TIMELINE
        // ========================================================
        _sectionContainer(
          child: OrderTimeline(
            currentStep: _getTimelineStep(order.orderStatus),
          ),
        ),

        const SizedBox(height: 20),

        // ========================================================
        // ORDER SUMMARY
        // ========================================================
        _sectionContainer(
          child: OrderSummary(
            subtotal: order.subtotal,
            shipping: order.shippingCharge,
            tax: order.tax,
            discount: order.discount,
            total: order.total,
          ),
        ),

        const SizedBox(height: 28),

        // ========================================================
        // ACTION BUTTONS
        // ========================================================
        _sectionContainer(child: ActionButtons()),

        const SizedBox(height: 10),
      ],
    );
  }

  // ============================================================
  // DESKTOP HEADER
  // ============================================================

  Widget _desktopHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          // ======================================================
          // BACK BUTTON
          // ======================================================
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              tooltip: 'Back to Order Management',
              onPressed: () {
                context.go(AppRouter.adminOrderDetails);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          const SizedBox(width: 14),

          // ======================================================
          // TITLE
          // ======================================================
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'View order information and delivery status.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          // ======================================================
          // ORDER NUMBER
          // ======================================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red.withValues(alpha: 0.20)),
            ),
            child: Text(
              '#${order.orderNumber}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        // ========================================================
        // BACK BUTTON
        // ========================================================
        leading: IconButton(
          tooltip: 'Back to Order Management',
          onPressed: () {
            context.go(AppRouter.adminOrderDetails);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),

        // ========================================================
        // TITLE
        // ========================================================
        title: const Text(
          'Order Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        // ========================================================
        // ORDER NUMBER
        // ========================================================
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.20)),
                ),
                child: Text(
                  '#${order.orderNumber}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: SafeArea(child: _buildMobileContent()),
    );
  }

  // ============================================================
  // MOBILE CONTENT
  // ============================================================

  Widget _buildMobileContent() {
    final orderDate = order.createdAt != null
        ? _formatDate(order.createdAt!.toDate())
        : '-';

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====================================================
            // MOBILE HEADER
            // ====================================================
            _mobileHeader(),

            const SizedBox(height: 18),

            // ====================================================
            // ORDER INFORMATION
            // ====================================================
            _sectionContainer(
              child: OrderInformation(
                status: _formatStatus(order.orderStatus),
                orderId: '#${order.orderNumber}',
                orderDate: orderDate,
                deliveryDate: '-',
              ),
            ),

            const SizedBox(height: 16),

            // ====================================================
            // ORDER ITEMS
            // ====================================================
            _sectionContainer(child: OrderItems(items: order.items)),

            const SizedBox(height: 16),

            // ====================================================
            // SHIPPING INFORMATION
            // ====================================================
            _sectionContainer(
              child: ShippingInformation(
                name: order.shippingAddress.fullName,
                phone: order.shippingAddress.phone,
                addressLine1: order.shippingAddress.addressLine1,
                addressLine2: order.shippingAddress.addressLine2,
                city: order.shippingAddress.city,
                state: order.shippingAddress.state,
                pincode: order.shippingAddress.pincode,
              ),
            ),

            const SizedBox(height: 16),

            // ====================================================
            // PAYMENT INFORMATION
            // ====================================================
            _sectionContainer(
              child: PaymentInformation(
                paymentMethod: _formatPaymentMethod(order.paymentMethod),
                paymentStatus: _formatPaymentStatus(order.paymentStatus),
                transactionId: '-',
                paymentDate: orderDate,
              ),
            ),

            const SizedBox(height: 16),

            // ====================================================
            // ORDER TIMELINE
            // ====================================================
            _sectionContainer(
              child: OrderTimeline(
                currentStep: _getTimelineStep(order.orderStatus),
              ),
            ),

            const SizedBox(height: 16),

            // ====================================================
            // ORDER SUMMARY
            // ====================================================
            _sectionContainer(
              child: OrderSummary(
                subtotal: order.subtotal,
                shipping: order.shippingCharge,
                tax: order.tax,
                discount: order.discount,
                total: order.total,
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // ACTION BUTTONS
            // ====================================================
            _sectionContainer(child: ActionButtons()),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MOBILE HEADER
  // ============================================================

  Widget _mobileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'View order information and delivery status.',
            style: TextStyle(color: Colors.grey, fontSize: 12.5),
          ),

          const SizedBox(height: 14),

          // ======================================================
          // ORDER NUMBER
          // ======================================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.withValues(alpha: 0.20)),
            ),
            child: Text(
              '#${order.orderNumber}',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION CONTAINER
  // ============================================================

  Widget _sectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  // ============================================================
  // DATE FORMATTER
  // ============================================================

  static String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // ============================================================
  // ORDER STATUS
  // ============================================================

  static String _formatStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Confirmed';

      case OrderStatus.confirmed:
        return 'Confirmed';

      case OrderStatus.packed:
        return 'Packed';

      case OrderStatus.shipped:
        return 'Shipped';

      case OrderStatus.outForDelivery:
        return 'Out For Delivery';

      case OrderStatus.delivered:
        return 'Delivered';

      case OrderStatus.cancelled:
        return 'Cancelled';

      case OrderStatus.refundRequested:
        return 'Refund Requested';

      case OrderStatus.exchangeRequested:
        return 'Exchange Requested';

      case OrderStatus.returned:
        return 'Returned';
    }
  }

  // ============================================================
  // PAYMENT STATUS
  // ============================================================

  static String _formatPaymentStatus(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';

      case PaymentStatus.paid:
        return 'Paid';

      case PaymentStatus.failed:
        return 'Failed';

      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  // ============================================================
  // PAYMENT METHOD
  // ============================================================

  static String _formatPaymentMethod(String method) {
    if (method.trim().isEmpty) {
      return '-';
    }

    switch (method.toLowerCase()) {
      case 'cod':
        return 'Cash on Delivery';

      case 'upi':
        return 'UPI';

      case 'card':
        return 'Card';

      case 'netbanking':
        return 'Net Banking';

      case 'wallet':
        return 'Wallet';

      default:
        return method.toUpperCase();
    }
  }

  // ============================================================
  // TIMELINE STEP
  // ============================================================

  static int _getTimelineStep(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
      case OrderStatus.confirmed:
        return 1;

      case OrderStatus.packed:
        return 2;

      case OrderStatus.shipped:
        return 3;

      case OrderStatus.outForDelivery:
        return 4;

      case OrderStatus.delivered:
        return 5;

      case OrderStatus.cancelled:
      case OrderStatus.refundRequested:
      case OrderStatus.exchangeRequested:
      case OrderStatus.returned:
        return -1;
    }
  }
}
