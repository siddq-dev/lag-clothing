import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/inventory_provider.dart';

import '../widgets/inventory_header.dart';
import '../widgets/inventory_summary_cards.dart';
import '../widgets/inventory_search_bar.dart';
import '../widgets/inventory_filter_bar.dart';
import '../widgets/inventory_table.dart';

class InventoryDashboardPage extends StatefulWidget {
  const InventoryDashboardPage({super.key});

  @override
  State<InventoryDashboardPage> createState() => _InventoryDashboardPageState();
}

class _InventoryDashboardPageState extends State<InventoryDashboardPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<InventoryProvider>().loadInventory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<InventoryProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const InventoryHeader(),

                  const SizedBox(height: 30),

                  InventorySummaryCards(provider: provider),

                  const SizedBox(height: 30),

                  InventorySearchBar(controller: _searchController),

                  const SizedBox(height: 20),

                  const InventoryFilterBar(),

                  const SizedBox(height: 30),

                  InventoryTable(
                    products: provider.search(_searchController.text),
                  ),
                ],
              ),
            ),
    );
  }
}
