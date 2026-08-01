import 'package:flutter/material.dart';

import '/models/sales_chart_model.dart';

class SalesChart extends StatelessWidget {
  const SalesChart({
    super.key,
    required this.data,
  });

  final List<SalesChartModel> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 350,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                "Sales Overview",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final sale = data[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.show_chart,
                      ),
                      title: Text(
                        sale.date
                            .toDate()
                            .toString()
                            .split(" ")
                            .first,
                      ),
                      trailing: Text(
                        "₹${sale.revenue.toStringAsFixed(0)}",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}