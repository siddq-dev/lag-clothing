import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../layout/admin_layout.dart';
import '../../../../routes/app_routes.dart';

import '/providers/customer_management_provider.dart';
import '../widgets/customer_table.dart';

class CustomerManagementPage extends StatefulWidget {
  const CustomerManagementPage({super.key});

  @override
  State<CustomerManagementPage> createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CustomerManagementProvider>().listenCustomers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerManagementProvider>();

    final customers = provider.searchCustomers(_searchController.text);

    return AdminLayout(
      title: 'Customer Management',
      currentRoute: AppRouter.customerManagement,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Customer Management",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("Manage customer accounts and orders."),

            const SizedBox(height: 30),

            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search customer...",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 25),

            Expanded(
              child: provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomerTable(customers: customers),
            ),
          ],
        ),
      ),
    );
  }
}
