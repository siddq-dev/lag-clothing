import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({
    super.key,
    required this.orderId,
    required this.productName,
    required this.quantity,
    required this.totalAmount,
    required this.orderDate,
    required this.paymentStatus,
    required this.imageUrl,
  });

  final String orderId;
  final String productName;
  final int quantity;
  final String totalAmount;
  final String orderDate;
  final String paymentStatus;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    "Order #$orderId",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text("Quantity : $quantity"),

                  const SizedBox(height: 5),

                  Text(
                    "Total : $totalAmount",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Ordered : $orderDate",
                  ),

                  const SizedBox(height: 8),

                  Chip(
                    label: Text(paymentStatus),
                    backgroundColor:
                        Colors.green.shade100,
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}