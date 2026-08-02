import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/models/inventory_item_model.dart';
import '../widgets/stock_status_chip.dart';

class InventoryTable extends StatelessWidget {
  const InventoryTable({
    super.key,
    required this.products,
  });

  final List<InventoryItemModel> products;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              MaterialStateProperty.all(
            Colors.black26,
          ),
          columns: const [
            DataColumn(
              label: Text(
                "Product",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "SKU",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Category",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Price",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Stock",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Status",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            DataColumn(
              label: Text(
                "Action",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
          rows: products.map((product) {
            return DataRow(
              cells: [
                DataCell(
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    product.sku,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    product.category,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    "₹${product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataCell(
                  Text(
                    product.stock.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                DataCell(
                  StockStatusChip(
                    stock: product.stock,
                    reorderLevel:
                        product.reorderLevel,
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.push(
                        "/admin/inventory/details",
                        extra: product,
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}