import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/order_provider.dart';
import 'package:lag_clothing/providers/admin_order_filter_provider.dart';
import '../../../../models/order_model.dart';

import '../../../../routes/app_routes.dart';
import '../widgets/admin_order_filter.dart';
import '../widgets/admin_order_search_bar.dart';
import '../widgets/admin_order_sort.dart';
import '../widgets/order_status_chip.dart';

class AdminManageOrdersPage extends StatefulWidget {
  const AdminManageOrdersPage({super.key});

  @override
  State<AdminManageOrdersPage> createState() => _ManageOrdersPageState();
}

class _ManageOrdersPageState extends State<AdminManageOrdersPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderProvider>().fetchAllOrders();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();

    final filterProvider = context.watch<AdminOrderFilterProvider>();

    final orders = filterProvider.apply(orderProvider.orders);
    // Statistics
    final totalOrders = orders.length;

    final pendingOrders = orders
        .where((e) => e.orderStatus == OrderStatus.placed)
        .length;

    final shippedOrders = orders
        .where(
          (e) =>
              e.orderStatus == OrderStatus.shipped ||
              e.orderStatus == OrderStatus.outForDelivery,
        )
        .length;

    final deliveredOrders = orders
        .where((e) => e.orderStatus == OrderStatus.delivered)
        .length;

    final revenue = orders
        .where((e) => e.paymentStatus == PaymentStatus.paid)
        .fold<double>(0, (sum, order) => sum + order.total);

    return Scaffold(
      appBar: AppBar(title: const Text("Manage Orders")),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            //----------------------------------------------------
            // Search + Sort + Filter
            //----------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: AdminOrderSearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      context.read<AdminOrderFilterProvider>().updateSearch(
                        value,
                      );
                    },
                    onClear: () {
                      context.read<AdminOrderFilterProvider>().clearSearch();
                    },
                  ),
                ),

                const SizedBox(width: 16),

                AdminOrderSort(
                  value: filterProvider.sortBy,
                  onChanged: (value) {
                    if (value != null) {
                      context.read<AdminOrderFilterProvider>().updateSort(
                        value,
                      );
                    }
                  },
                ),

                const SizedBox(width: 16),

                FilledButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => const Dialog(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: AdminOrderFilter(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.filter_alt),
                  label: const Text("Filters"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            //----------------------------------------------------
            // Statistics
            //----------------------------------------------------
            Row(
              children: [
                _statCard("Orders", totalOrders.toString(), Colors.blue),

                const SizedBox(width: 15),

                _statCard("Pending", pendingOrders.toString(), Colors.orange),

                const SizedBox(width: 15),

                _statCard("Shipped", shippedOrders.toString(), Colors.indigo),

                const SizedBox(width: 15),

                _statCard(
                  "Delivered",
                  deliveredOrders.toString(),
                  Colors.green,
                ),

                const SizedBox(width: 15),

                _statCard(
                  "Revenue",
                  "₹${revenue.toStringAsFixed(0)}",
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 30),

            //----------------------------------------------------
            // Orders Table
            //----------------------------------------------------
            Expanded(
              child: Builder(
                builder: (context) {
                  if (orderProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (orderProvider.error != null) {
                    return Center(child: Text(orderProvider.error!));
                  }

                  if (orders.isEmpty) {
                    return const Center(child: Text("No Orders Found"));
                  }

                  return Card(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowHeight: 60,
                        dataRowHeight: 72,

                        columns: const [
                          DataColumn(label: Text("Order ID")),
                          DataColumn(label: Text("Customer")),
                          DataColumn(label: Text("Date")),
                          DataColumn(label: Text("Total")),
                          DataColumn(label: Text("Payment")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("Actions")),
                        ],

                        rows: orders.map((order) {
                          return DataRow(
                            cells: [
                              DataCell(Text(order.orderNumber)),

                              DataCell(Text(order.shippingAddress.fullName)),

                              DataCell(
                                Text(
                                  order.createdAt == null
                                      ? "-"
                                      : order.createdAt!
                                            .toDate()
                                            .toString()
                                            .split(" ")
                                            .first,
                                ),
                              ),

                              DataCell(
                                Text("₹${order.total.toStringAsFixed(2)}"),
                              ),

                              DataCell(Text(order.paymentMethod)),

                              DataCell(
                                OrderStatusChip(status: order.orderStatus.name),
                              ),

                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.visibility),
                                      onPressed: () {
                                        context.push(
                                          AppRouter.orderDetails,
                                          extra: order,
                                        );
                                      },
                                    ),

                                    IconButton(
                                      icon: const Icon(Icons.local_shipping),
                                      onPressed: () async {
                                        await orderProvider.updateOrderStatus(
                                          order.id,
                                          OrderStatus.shipped,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //--------------------------------------------------------
  // Statistics Card
  //--------------------------------------------------------

  Widget _statCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
