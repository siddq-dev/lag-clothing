import 'package:flutter/material.dart';

import '../widgets/product_table_row.dart';
import '../../../../models/product_model.dart';

class ProductTable extends StatelessWidget {
  const ProductTable({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text("Image")),
            DataColumn(label: Text("Product")),
            DataColumn(label: Text("Category")),
            DataColumn(label: Text("Price")),
            DataColumn(label: Text("Stock")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: products
              .map(
                (product) => ProductTableRow(
                  product: product,
                  onView: () {},
                  onEdit: () {},
                  onDelete: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}