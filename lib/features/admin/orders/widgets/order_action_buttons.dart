import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/order_model.dart';
import '../../../../../providers/order_provider.dart';

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [

            FilledButton.icon(
              icon: const Icon(Icons.cancel),
              label: const Text("Cancel Order"),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      await provider.updateOrderStatus(
                        order.id,
                        OrderStatus.cancelled,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Order Cancelled",
                          ),
                        ),
                      );
                    },
            ),

            FilledButton.icon(
              icon: const Icon(Icons.assignment_return),
              label: const Text("Return Order"),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      await provider.updateOrderStatus(
                        order.id,
                        OrderStatus.returned,
                      );

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Order Returned",
                          ),
                        ),
                      );
                    },
            ),

            FilledButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text("Delete"),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      final confirm =
                          await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text(
                            "Delete Order",
                          ),
                          content: const Text(
                            "Delete this order permanently?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(
                                      context,
                                      false),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                            FilledButton(
                              onPressed: () =>
                                  Navigator.pop(
                                      context,
                                      true),
                              child: const Text(
                                "Delete",
                              ),
                            ),
                          ],
                        ),
                      );

                      if (confirm != true) return;

                      await provider.deleteOrder(
                        order.id,
                      );

                      if (!context.mounted) return;

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Order Deleted",
                          ),
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}