import 'package:flutter/material.dart';

import '/providers/analytics_provider.dart';

class SummaryCards extends StatelessWidget {
  const SummaryCards({
    super.key,
    required this.provider,
  });

  final AnalyticsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        _card(
          "Revenue",
          "₹${provider.revenue.toStringAsFixed(0)}",
          Icons.currency_rupee,
          Colors.green,
        ),

        _card(
          "Orders",
          provider.orders.toString(),
          Icons.shopping_bag,
          Colors.blue,
        ),

        _card(
          "Customers",
          provider.customers.toString(),
          Icons.people,
          Colors.orange,
        ),

        _card(
          "Products",
          provider.products.toString(),
          Icons.inventory_2,
          Colors.purple,
        ),

        _card(
          "Visitors",
          provider.visitors.toString(),
          Icons.language,
          Colors.teal,
        ),

        _card(
          "Average Order",
          "₹${provider.averageOrder.toStringAsFixed(0)}",
          Icons.analytics,
          Colors.red,
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
    return SizedBox(
      width: 250,
      child: Card(
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
                radius: 28,
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
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}