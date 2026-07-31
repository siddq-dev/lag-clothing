import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/order_model.dart';
import '../../../../../providers/order_provider.dart';

class UpdateOrderStatusCard extends StatefulWidget {
  const UpdateOrderStatusCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  State<UpdateOrderStatusCard> createState() =>
      _UpdateOrderStatusCardState();
}

class _UpdateOrderStatusCardState
    extends State<UpdateOrderStatusCard> {
  late OrderStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.order.orderStatus;
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
              "Update Order Status",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<OrderStatus>(
              value: selectedStatus,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Order Status",
              ),

              items: OrderStatus.values
                  .map(
                    (status) => DropdownMenuItem(
                      value: status,
                      child: Text(
                        status.name,
                      ),
                    ),
                  )
                  .toList(),

              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedStatus = value;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                icon: const Icon(Icons.save),

                label: provider.isLoading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Update Status",
                      ),

                onPressed: provider.isLoading
                    ? null
                    : () async {
                        try {
                          await provider
                              .updateOrderStatus(
                            widget.order.id,
                            selectedStatus,
                          );

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Order status updated successfully",
                              ),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                e.toString(),
                              ),
                            ),
                          );
                        }
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}