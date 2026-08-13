import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/order_model.dart';
import '../../../../../providers/order_provider.dart';

class UpdateOrderStatusCard extends StatefulWidget {
  const UpdateOrderStatusCard({super.key, required this.order});

  final OrderModel order;

  @override
  State<UpdateOrderStatusCard> createState() => _UpdateOrderStatusCardState();
}

class _UpdateOrderStatusCardState extends State<UpdateOrderStatusCard> {
  late OrderStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.order.orderStatus;
  }

  String _statusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';

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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update Order Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              'Current status: ${_statusLabel(widget.order.orderStatus)}',
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<OrderStatus>(
              initialValue: selectedStatus,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Order Status',
              ),

              items: OrderStatus.values
                  .map(
                    (status) => DropdownMenuItem<OrderStatus>(
                      value: status,
                      child: Text(_statusLabel(status)),
                    ),
                  )
                  .toList(),

              onChanged: provider.isLoading
                  ? null
                  : (value) {
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
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Update Status'),

                onPressed: provider.isLoading
                    ? null
                    : () async {
                        try {
                          await provider.updateOrderStatus(
                            widget.order.id,
                            selectedStatus,
                          );

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order status changed to '
                                '${_statusLabel(selectedStatus)}',
                              ),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
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
