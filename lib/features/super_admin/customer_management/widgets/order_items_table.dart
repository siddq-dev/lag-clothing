import 'package:flutter/material.dart';

import '../../../../models/order_item_model.dart';

class OrderItemsTable extends StatelessWidget {
  const OrderItemsTable({
    super.key,
    required this.items,
  });

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [

        DataColumn(
          label: Text("Product"),
        ),

        DataColumn(
          label: Text("Qty"),
        ),

        DataColumn(
          label: Text("Price"),
        ),

        DataColumn(
          label: Text("Total"),
        ),
      ],

      rows: items
          .map(
            (item) => DataRow(
              cells: [

                DataCell(
                  Text(item.productName),
                ),

                DataCell(
                  Text(item.quantity.toString()),
                ),

                DataCell(
                  Text("₹${item.price}"),
                ),

                DataCell(
                  Text(
                    "₹${item.total.toStringAsFixed(2)}",
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}