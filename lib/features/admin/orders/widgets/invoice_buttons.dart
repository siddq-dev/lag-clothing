import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';
import '../../../../../services/invoice_service.dart';

class InvoiceButtons extends StatelessWidget {
  const InvoiceButtons({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.receipt_long, size: 28),

            const SizedBox(width: 12),

            const Expanded(
              child: Text(
                "Invoice",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            //----------------------------------------------------------
            // Download Invoice
            //----------------------------------------------------------
            OutlinedButton.icon(
              onPressed: () async {
                try {
                  await InvoiceService.downloadInvoice(order);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invoice downloaded successfully."),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Download failed\n$e")),
                    );
                  }
                }
              },
              icon: const Icon(Icons.download),
              label: const Text("Download"),
            ),

            const SizedBox(width: 12),

            //----------------------------------------------------------
            // Print Invoice
            //----------------------------------------------------------
            FilledButton.icon(
              onPressed: () async {
                try {
                  await InvoiceService.printInvoice(order);
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Print failed\n$e")));
                  }
                }
              },
              icon: const Icon(Icons.print),
              label: const Text("Print"),
            ),
          ],
        ),
      ),
    );
  }
}
