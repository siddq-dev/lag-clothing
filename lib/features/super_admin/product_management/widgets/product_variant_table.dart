import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductVariantTable extends StatelessWidget {
  final ProductModel product;

  const ProductVariantTable({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Color")),
            DataColumn(label: Text("Size")),
            DataColumn(label: Text("SKU")),
            DataColumn(label: Text("Stock")),
          ],
          rows: product.variants
              .map(
                (variant) => DataRow(
                  cells: [
                    DataCell(Text(variant.color)),
                    DataCell(Text(variant.size)),
                    DataCell(Text(variant.sku)),
                    DataCell(
                      Text(
                        variant.stock.toString(),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}