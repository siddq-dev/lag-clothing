import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/product_model.dart';

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
      return Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: const Padding(
          padding: EdgeInsets.all(40),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),

                SizedBox(height: 12),

                Text(
                  'No products available.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),

                SizedBox(height: 5),

                Text(
                  'Add a product to see it here.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final tableWidth = constraints.maxWidth < 950
                ? 950.0
                : constraints.maxWidth;

            return Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: tableWidth,
                  child: DataTable(
                    headingRowHeight: 56,
                    dataRowMinHeight: 70,
                    dataRowMaxHeight: 80,
                    horizontalMargin: 16,
                    columnSpacing: 28,

                    headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),

                    columns: const [
                      DataColumn(label: Text('Image')),
                      DataColumn(label: Text('Product')),
                      DataColumn(label: Text('Brand')),
                      DataColumn(label: Text('Category')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('Stock')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],

                    rows: products.map((product) {
                      return ProductTableRow(
                        product: product,

                        // ------------------------------------------------
                        // VIEW
                        // ------------------------------------------------
                        onView: () {
                          context.go('/admin/product/${product.id}');
                        },

                        // ------------------------------------------------
                        // EDIT
                        // ------------------------------------------------
                        onEdit: () {
                          context.push('/editproduct/${product.id}');
                        },

                        // ------------------------------------------------
                        // DELETE
                        // ------------------------------------------------
                        onDelete: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                title: const Text('Delete Product'),

                                content: Text(
                                  "Are you sure you want to delete '${product.name}'?",
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),

                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop(true);
                                    },
                                    child: const Text('Delete'),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
