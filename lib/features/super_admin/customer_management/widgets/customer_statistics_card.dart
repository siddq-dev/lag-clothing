import 'package:flutter/material.dart';

class CustomerStatisticsCard extends StatelessWidget {
  const CustomerStatisticsCard({
    super.key,
    required this.totalOrders,
    required this.totalSpend,
    required this.averageOrder,
    required this.lastOrder,
  });

  final int totalOrders;
  final double totalSpend;
  final double averageOrder;
  final DateTime? lastOrder;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _card(
            "Total Orders",
            totalOrders.toString(),
            Icons.shopping_bag,
            Colors.blue,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Total Spend",
            "₹${totalSpend.toStringAsFixed(0)}",
            Icons.payments,
            Colors.green,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Average Order",
            "₹${averageOrder.toStringAsFixed(0)}",
            Icons.analytics,
            Colors.orange,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _card(
            "Last Order",
            lastOrder == null
                ? "-"
                : lastOrder!
                    .toString()
                    .split(" ")
                    .first,
            Icons.history,
            Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _card(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor:
                  color.withOpacity(.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}