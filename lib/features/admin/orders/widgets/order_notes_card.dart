import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/order_model.dart';
import '../../../../../providers/order_provider.dart';

class OrderNotesCard extends StatefulWidget {
  const OrderNotesCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  State<OrderNotesCard> createState() =>
      _OrderNotesCardState();
}

class _OrderNotesCardState
    extends State<OrderNotesCard> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.order.adminNotes,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Admin Notes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Write internal notes...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      await provider.updateAdminNotes(
                        widget.order.id,
                        controller.text.trim(),
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Notes Updated",
                          ),
                        ),
                      );
                    },
              icon: const Icon(Icons.save),
              label: const Text("Save Notes"),
            ),
          ],
        ),
      ),
    );
  }
}