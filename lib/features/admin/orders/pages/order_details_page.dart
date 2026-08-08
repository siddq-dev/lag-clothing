import 'package:flutter/material.dart';
import 'package:lag_clothing/features/admin/orders/widgets/order_information_card.dart';

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

class AdminOrderDetailsPage extends StatelessWidget {
  final dynamic order;

  const AdminOrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            OrderInformationCard(order: order),

            const SizedBox(height: 20),

            AddressInformationCard(
              shippingAddress: order.shippingAddress,
              billingAddress: order.billingAddress,
            ),

            PaymentStatusDropdown(order: order),
            const SizedBox(height: 20),

            InvoiceButtons(order: order),
            const SizedBox(height: 20),

            CustomerInformationCard(order: order),
            const SizedBox(height: 20),

            ShippingInformationCard(order: order),
            const SizedBox(height: 20),

            PaymentInformationCard(order: order),
            const SizedBox(height: 20),

            InvoiceButtons(order: order),
            const SizedBox(height: 20),

            OrderItemsTable(order: order),
            const SizedBox(height: 20),

            OrderSummaryCard(order: order),
            const SizedBox(height: 20),

            OrderTimeline(order: order),
            const SizedBox(height: 20),

            UpdateOrderStatusCard(order: order),
            const SizedBox(height: 20),

            OrderNotesCard(order: order),
            const SizedBox(height: 20),

            OrderActionButtons(order: order),
          ],
        ),
      ),
    );
  }
}
