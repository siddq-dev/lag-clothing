import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class OrderTimeline extends StatelessWidget {
  const OrderTimeline({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final currentIndex = _statusIndex(order.orderStatus);

    const statuses = [
      "Placed",
      "Confirmed",
      "Packed",
      "Shipped",
      "Out For Delivery",
      "Delivered",
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Timeline",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ...List.generate(statuses.length, (index) {
              final completed = index <= currentIndex;

              final isLast = index == statuses.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: completed
                            ? Colors.green
                            : Colors.grey.shade400,
                        child: Icon(
                          completed ? Icons.check : Icons.circle,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),

                      if (!isLast)
                        Container(
                          width: 2,
                          height: 45,
                          color: completed
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                    ],
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        statuses[index],
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: completed
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: completed ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),

            if (order.orderStatus == OrderStatus.cancelled)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "Order Cancelled",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            if (order.orderStatus == OrderStatus.returned)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  "Order Returned",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int _statusIndex(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 0;

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

      default:
        return -1;
    }
  }
}
