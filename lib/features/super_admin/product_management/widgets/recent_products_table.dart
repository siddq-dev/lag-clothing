import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/product_model.dart';
import '../../../../routes/app_routes.dart';

import 'product_table_row.dart';

class RecentProductsTable extends StatelessWidget {
  const RecentProductsTable({
    super.key,
    required this.products,
    required this.onDelete,
  });

  final List<ProductModel> products;
  final Future<void> Function(String productId) onDelete;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Text(
              "No products available.",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
        headingRowHeight: 55,
  dataRowMinHeight: 70,
  dataRowMaxHeight: 70,
          columns: const [
            DataColumn(label: Text("Image")),
            DataColumn(label: Text("Product")),
            DataColumn(label: Text("Brand")),
            DataColumn(label: Text("Category")),
            DataColumn(label: Text("Price")),
            DataColumn(label: Text("Stock")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: products.map((product) {
            return ProductTableRow(
  product: product,
  onView: () {
    context.go(
      "/admin/product/${product.id}",
    );
  },
             

          onEdit: () {
  context.push(
    "/editproduct/${product.id}",
  );
},

              onDelete: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("Delete Product"),
                      content: Text(
                        "Delete '${product.name}'?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, false),
                          child: const Text("Cancel"),
                        ),
                        FilledButton(
                          onPressed: () =>
                              Navigator.pop(context, true),
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  },
                );

                if (confirmed == true) {
                  await onDelete(product.id);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}