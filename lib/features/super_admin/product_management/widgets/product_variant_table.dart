import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductVariantTable extends StatelessWidget {
  const ProductVariantTable({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    if (product.variants.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              'No variants available.',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'Color',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  'Size',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  'SKU',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              DataColumn(
                label: Text(
                  'Stock',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
            rows: product.variants.map((variant) {
              return DataRow(
                cells: [
                  DataCell(Text(variant.color)),
                  DataCell(Text(variant.size)),
                  DataCell(Text(variant.sku)),
                  DataCell(
                    Text(
                      variant.stock.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: variant.stock <= 0
                            ? Colors.red
                            : variant.stock <= 5
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
