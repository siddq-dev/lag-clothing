import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/order_model.dart';
import '../../../../../providers/order_provider.dart';

class PaymentStatusDropdown extends StatelessWidget {
  const PaymentStatusDropdown({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Text(
              "Payment Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(width: 30),

            Expanded(
              child: DropdownButtonFormField<PaymentStatus>(
                initialValue: order.paymentStatus,

                decoration: const InputDecoration(border: OutlineInputBorder()),

                items: PaymentStatus.values.map((status) {
                  return DropdownMenuItem(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),

                onChanged: (value) async {
                  if (value == null) return;

                  await context.read<OrderProvider>().updatePaymentStatus(
                    order.id,
                    value,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
