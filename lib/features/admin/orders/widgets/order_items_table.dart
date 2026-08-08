import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class OrderItemsTable extends StatelessWidget {
  const OrderItemsTable({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ordered Items",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowHeight: 55,
                dataRowMinHeight: 80,
                dataRowMaxHeight: 90,

                columns: const [
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("Product")),
                  DataColumn(label: Text("Size")),
                  DataColumn(label: Text("Color")),
                  DataColumn(label: Text("Qty")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Total")),
                ],

                rows: order.items.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.productImage,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                      ),

                      DataCell(
                        SizedBox(
                          width: 220,
                          child: Text(
                            item.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      DataCell(Text(item.size)),

                      DataCell(Text(item.color)),

                      DataCell(Text(item.quantity.toString())),

                      DataCell(Text("₹${item.price.toStringAsFixed(2)}")),

                      DataCell(
                        Text(
                          "₹${item.total.toStringAsFixed(2)}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
