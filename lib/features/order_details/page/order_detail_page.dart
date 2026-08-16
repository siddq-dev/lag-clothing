import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../../../models/order_model.dart';

import '../widgets/details_header/details_header.dart';
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

  @override
  Widget build(BuildContext context) {
    final orderDate = order.createdAt != null
        ? _formatDate(order.createdAt!.toDate())
        : '-';

    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // HEADER
                  // =====================================================
                  const DetailsHeader(),

                  const SizedBox(height: 35),

                  // =====================================================
                  // ORDER INFORMATION
                  // =====================================================
                  OrderInformation(
                    status: _formatStatus(order.orderStatus),
                    orderId: '#${order.orderNumber}',
                    orderDate: orderDate,
                    deliveryDate: '-',
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // ORDERED PRODUCTS
                  // =====================================================
                  OrderItems(items: order.items),

                  const SizedBox(height: 30),

                  // =====================================================
                  // SHIPPING INFORMATION
                  // =====================================================
                  ShippingInformation(
                    name: order.shippingAddress.fullName,
                    phone: order.shippingAddress.phone,
                    addressLine1: order.shippingAddress.addressLine1,
                    addressLine2: order.shippingAddress.addressLine2,
                    city: order.shippingAddress.city,
                    state: order.shippingAddress.state,
                    pincode: order.shippingAddress.pincode,
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // PAYMENT INFORMATION
                  // =====================================================
                  PaymentInformation(
                    paymentMethod: _formatPaymentMethod(order.paymentMethod),
                    paymentStatus: _formatPaymentStatus(order.paymentStatus),
                    transactionId: '-',
                    paymentDate: orderDate,
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // ORDER TIMELINE
                  // =====================================================
                  OrderTimeline(
                    currentStep: _getTimelineStep(order.orderStatus),
                  ),

                  const SizedBox(height: 30),

                  // =====================================================
                  // ORDER SUMMARY
                  // =====================================================
                  OrderSummary(
                    subtotal: order.subtotal,
                    shipping: order.shippingCharge,
                    tax: order.tax,
                    discount: order.discount,
                    total: order.total,
                  ),

                  const SizedBox(height: 40),

                  // =====================================================
                  // ACTION BUTTONS
                  // =====================================================
                  ActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // DATE FORMATTER
  // ===========================================================

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

  // ===========================================================
  // ORDER STATUS
  // ===========================================================

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

  // ===========================================================
  // PAYMENT STATUS
  // ===========================================================

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

  // ===========================================================
  // PAYMENT METHOD
  // ===========================================================

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

  // ===========================================================
  // TIMELINE STEP
  // ===========================================================

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
