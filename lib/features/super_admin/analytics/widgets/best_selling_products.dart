import 'package:flutter/material.dart';

class BestSellingProducts extends StatelessWidget {
  const BestSellingProducts({
    super.key,
    required this.products,
  });

  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Best Selling Products",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ListView.separated(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              separatorBuilder: (_, __) =>
                  const Divider(),
              itemBuilder: (context, index) {
                final product = products[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      "${index + 1}",
                    ),
                  ),
                  title: Text(
                    product["name"] ?? "",
                  ),
                  subtitle: Text(
                    "Sold : ${product["sold"]}",
                  ),
                  trailing: Text(
                    "₹${product["revenue"]}",
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