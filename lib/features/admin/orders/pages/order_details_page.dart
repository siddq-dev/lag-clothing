import 'package:flutter/material.dart';

import '../widgets/customer_information_card.dart';
import '../widgets/order_items_table.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/payment_information_card.dart';
import '../widgets/shipping_information_card.dart';
import '../widgets/order_timeline.dart';
import '../widgets/update_order_status_card.dart';
import '../widgets/order_action_buttons.dart';
import '../widgets/order_notes_card.dart';


class AdminOrderDetailsPage extends StatelessWidget {
  const AdminOrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: const [

            CustomerInformationCard(),

            SizedBox(height: 20),

            ShippingInformationCard(),

            SizedBox(height: 20),

            PaymentInformationCard(),

            SizedBox(height: 20),

            OrderItemsTable(),

            SizedBox(height: 20),

            OrderSummaryCard(),

            SizedBox(height: 20),

            OrderTimeline(),

            const SizedBox(height: 20),

const UpdateOrderStatusCard(),

const SizedBox(height: 20),

const OrderNotesCard(),

const SizedBox(height: 20),

const OrderActionButtons(),

          ],
        ),
      ),
    );
  }
}