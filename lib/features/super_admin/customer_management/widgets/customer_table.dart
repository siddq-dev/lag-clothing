import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

import '/models/customer_admin_model.dart';

class CustomerTable extends StatelessWidget {
  const CustomerTable({
    super.key,
    required this.customers,
  });

  final List<CustomerAdminModel> customers;

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      return const Center(
        child: Text(
          "No Customers Found",
        ),
      );
    }

    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Orders")),
            DataColumn(label: Text("Total Spend")),
          ],
          rows: customers.map((customer) {
            return DataRow(
              onSelectChanged: (_) {
                context.go(
                  AppRouter.customerDetails,
                  extra: customer,
                );
              },
              cells: [
                DataCell(
                  Text(customer.fullName),
                ),
                DataCell(
                  Text(customer.email),
                ),
                DataCell(
                  Text(customer.phone),
                ),
                DataCell(
                  Text(
                    customer.totalOrders.toString(),
                  ),
                ),
                DataCell(
                  Text(
                    "₹${customer.totalSpent.toStringAsFixed(0)}",
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