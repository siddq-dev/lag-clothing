import 'package:flutter/material.dart';

class OrderItemsTable extends StatelessWidget {
  const OrderItemsTable({super.key});

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
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DataTable(
              columns: const [

                DataColumn(
                  label: Text("Product"),
                ),

                DataColumn(
                  label: Text("Size"),
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

              rows: const [

                DataRow(
                  cells: [

                    DataCell(
                      Text("Home Jersey"),
                    ),

                    DataCell(
                      Text("L"),
                    ),

                    DataCell(
                      Text("2"),
                    ),

                    DataCell(
                      Text("₹1200"),
                    ),

                    DataCell(
                      Text("₹2400"),
                    ),

                  ],
                ),

                DataRow(
                  cells: [

                    DataCell(
                      Text("Training Shorts"),
                    ),

                    DataCell(
                      Text("M"),
                    ),

                    DataCell(
                      Text("1"),
                    ),

                    DataCell(
                      Text("₹800"),
                    ),

                    DataCell(
                      Text("₹800"),
                    ),

                  ],
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}