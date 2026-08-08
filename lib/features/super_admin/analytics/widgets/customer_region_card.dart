import 'package:flutter/material.dart';

import '/models/customer_region_model.dart';

class CustomerRegionCard extends StatelessWidget {
  const CustomerRegionCard({super.key, required this.regions});

  final List<CustomerRegionModel> regions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customers by Region",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: regions.length,
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (context, index) {
                final region = regions[index];

                return ListTile(
                  leading: const Icon(Icons.public),
                  title: Text(region.country),
                  subtitle: Text("${region.customers} Customers"),
                  trailing: Text("₹${region.revenue.toStringAsFixed(0)}"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
