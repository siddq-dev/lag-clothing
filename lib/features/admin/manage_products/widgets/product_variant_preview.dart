import 'package:flutter/material.dart';

import '../../../../../models/product_variant_model.dart';

class ProductVariantPreview extends StatelessWidget {
  const ProductVariantPreview({
    super.key,
    required this.variants,
  });

  final List<ProductVariantModel> variants;

  @override
  Widget build(BuildContext context) {
    if (variants.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text(
              "No Variants Available",
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Product Variants",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(

                columns: const [

                  DataColumn(
                    label: Text("Image"),
                  ),

                  DataColumn(
                    label: Text("Color"),
                  ),

                  DataColumn(
                    label: Text("Size"),
                  ),

                  DataColumn(
                    label: Text("SKU"),
                  ),

                  DataColumn(
                    label: Text("Stock"),
                  ),

                  DataColumn(
                    label: Text("Price"),
                  ),

                ],

                rows: variants.map((variant) {

                  return DataRow(

                    cells: [

                      DataCell(Text(variant.color)),
DataCell(Text(variant.size)),
DataCell(Text(variant.sku)),
DataCell(Text(variant.stock.toString())),
DataCell(
  Icon(
    variant.available
        ? Icons.check_circle
        : Icons.cancel,
    color: variant.available
        ? Colors.green
        : Colors.red,
  ),
),

                    ],

                  );

                }).toList(),

              ),
            ),

          ],
        ),
      ),
    );
  }
}