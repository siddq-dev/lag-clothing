import 'package:flutter/material.dart';

import '../../../models/order_model.dart';
import '../widgets/tracking_step.dart';

class OrderTrackingPage extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingPage({super.key, required this.order});

  int getStatusIndex() {
    switch (order.orderStatus) {
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

      case OrderStatus.cancelled:
      case OrderStatus.refundRequested:
      case OrderStatus.exchangeRequested:
      case OrderStatus.returned:
        return -1;
    }
  }

  String _statusTitle() {
    switch (order.orderStatus) {
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
        return 'Order Cancelled';

      case OrderStatus.refundRequested:
        return 'Refund Requested';

      case OrderStatus.exchangeRequested:
        return 'Exchange Requested';

      case OrderStatus.returned:
        return 'Order Returned';
    }
  }

  String _statusDescription() {
    switch (order.orderStatus) {
      case OrderStatus.placed:
        return 'Your order has been received';

      case OrderStatus.confirmed:
        return 'Your order has been confirmed';

      case OrderStatus.packed:
        return 'Your package is being prepared';

      case OrderStatus.shipped:
        return 'Package handed to delivery partner';

      case OrderStatus.outForDelivery:
        return 'Delivery partner is nearby';

      case OrderStatus.delivered:
        return 'Order successfully delivered';

      case OrderStatus.cancelled:
        return 'This order has been cancelled';

      case OrderStatus.refundRequested:
        return 'Your refund request is being processed';

      case OrderStatus.exchangeRequested:
        return 'Your exchange request is being processed';

      case OrderStatus.returned:
        return 'This order has been returned';
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = getStatusIndex();

    final steps = [
      {'title': 'Order Placed', 'subtitle': 'Your order has been received'},
      {'title': 'Confirmed', 'subtitle': 'Your order has been confirmed'},
      {'title': 'Packed', 'subtitle': 'Your package is being prepared'},
      {'title': 'Shipped', 'subtitle': 'Package handed to delivery partner'},
      {'title': 'Out For Delivery', 'subtitle': 'Delivery partner is nearby'},
      {'title': 'Delivered', 'subtitle': 'Order successfully delivered'},
    ];

    final isSpecialStatus =
        order.orderStatus == OrderStatus.cancelled ||
        order.orderStatus == OrderStatus.refundRequested ||
        order.orderStatus == OrderStatus.exchangeRequested ||
        order.orderStatus == OrderStatus.returned;

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Track Order'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'Order #${order.orderNumber}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (order.trackingId.isNotEmpty)
              Text(
                'Tracking ID: ${order.trackingId}',
                style: const TextStyle(color: Colors.grey),
              ),

            const SizedBox(height: 30),

            if (isSpecialStatus)
              Card(
                color: Colors.grey.shade900,
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        _statusTitle(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        _statusDescription(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (!isSpecialStatus)
              Expanded(
                child: ListView.builder(
                  itemCount: steps.length,

                  itemBuilder: (context, index) {
                    return TrackingStep(
                      title: steps[index]['title']!,
                      subtitle: steps[index]['subtitle']!,
                      completed: index < current,
                      active: index == current,
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
