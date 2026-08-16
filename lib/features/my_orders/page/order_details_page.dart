import 'package:flutter/material.dart';
import 'package:lag_clothing/models/address_model.dart';

import '../../../models/order_model.dart';

import '../widgets/order_summary.dart';
import '../widgets/order_status_chip.dart';
import '../widgets/cancel_order_button.dart';
import '../widgets/download_invoice_button.dart';
import '../widgets/buy_again_button.dart';

import '../widgets/order_item/order_item.dart';

import 'order_tracking_page.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.order});

  final OrderModel order;

  String _formatStatus(String value) {
    if (value.trim().isEmpty) {
      return 'Pending';
    }

    final words = value
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.trim().isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .toList();

    return words.join(' ');
  }

  String _formatPaymentStatus(PaymentStatus status) {
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

  String _formatDate() {
    if (order.createdAt == null) {
      return '-';
    }

    final date = order.createdAt!.toDate();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // ========================================================
            // ORDER HEADER
            // ========================================================
            _OrderHeader(
              orderNumber: order.orderNumber,
              date: _formatDate(),
              status: _formatStatus(order.orderStatus.name),
            ),

            const SizedBox(height: 20),

            // ========================================================
            // PRODUCTS
            // ========================================================
            OrderItems(items: order.items),

            const SizedBox(height: 20),

            // ========================================================
            // ORDER SUMMARY
            // ========================================================
            OrderSummary(order: order),

            const SizedBox(height: 20),

            // ========================================================
            // PAYMENT INFORMATION
            // ========================================================
            _PaymentCard(
              paymentMethod: order.paymentMethod,
              paymentStatus: _formatPaymentStatus(order.paymentStatus),
            ),

            const SizedBox(height: 20),

            // ========================================================
            // SHIPPING ADDRESS
            // ========================================================
            _AddressCard(
              title: 'Shipping Address',
              address: order.shippingAddress,
            ),

            const SizedBox(height: 20),

            // ========================================================
            // BILLING ADDRESS
            // ========================================================
            _AddressCard(
              title: 'Billing Address',
              address: order.billingAddress,
            ),

            const SizedBox(height: 20),

            // ========================================================
            // TRACKING
            // ========================================================
            if (order.trackingId.trim().isNotEmpty)
              _TrackingCard(trackingId: order.trackingId),

            if (order.trackingId.trim().isNotEmpty) const SizedBox(height: 20),

            // ========================================================
            // TRACK ORDER
            // ========================================================
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderTrackingPage(order: order),
                    ),
                  );
                },
                icon: const Icon(Icons.local_shipping_outlined),
                label: const Text('Track Order'),
              ),
            ),

            const SizedBox(height: 12),

            // ========================================================
            // INVOICE
            // ========================================================
            SizedBox(width: double.infinity, child: DownloadInvoiceButton()),

            const SizedBox(height: 12),

            // ========================================================
            // CANCEL
            // ========================================================
            SizedBox(
              width: double.infinity,
              child: CancelOrderButton(orderId: order.id),
            ),

            const SizedBox(height: 12),

            // ========================================================
            // BUY AGAIN
            // ========================================================
            SizedBox(
              width: double.infinity,
              child: BuyAgainButton(order: order),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// ORDER HEADER
// ==================================================================

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    required this.orderNumber,
    required this.date,
    required this.status,
  });

  final String orderNumber;
  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Number',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '#$orderNumber',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Placed on $date',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            OrderStatusChip(status: status),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// PAYMENT CARD
// ==================================================================

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.paymentMethod,
    required this.paymentStatus,
  });

  final String paymentMethod;
  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _row('Payment Method', paymentMethod.toUpperCase()),

            const SizedBox(height: 8),

            _row('Payment Status', paymentStatus),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// ==================================================================
// ADDRESS CARD
// ==================================================================

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.title, required this.address});

  final String title;
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              address.fullName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 6),

            Text(address.phone, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 10),

            Text(
              address.addressLine1,
              style: const TextStyle(color: Colors.white),
            ),

            if (address.addressLine2.trim().isNotEmpty)
              Text(
                address.addressLine2,
                style: const TextStyle(color: Colors.white),
              ),

            if (address.landmark.trim().isNotEmpty)
              Text(
                address.landmark,
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 6),

            Text(
              '${address.city}, '
              '${address.state} - '
              '${address.pincode}',
              style: const TextStyle(color: Colors.white),
            ),

            Text(address.country, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// TRACKING CARD
// ==================================================================

class _TrackingCard extends StatelessWidget {
  const _TrackingCard({required this.trackingId});

  final String trackingId;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.local_shipping, color: Colors.white),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tracking ID',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    trackingId,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
