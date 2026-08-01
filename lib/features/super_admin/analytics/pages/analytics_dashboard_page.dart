import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/analytics_provider.dart';

import '../widgets/analytics_header.dart';
import '../widgets/summary_cards.dart';
import '../widgets/sales_chart.dart';
import '../widgets/page_analytics_table.dart';
import '../widgets/customer_region_card.dart';
import '../widgets/device_analytics_card.dart';
import '../widgets/traffic_source_chart.dart';
import '../widgets/inventory_summary_card.dart';
import '../widgets/website_traffic_card.dart';
import '../widgets/best_selling_products.dart';
import '../widgets/low_stock_alerts.dart';





class AnalyticsDashboardPage extends StatefulWidget {
  const AnalyticsDashboardPage({super.key});

  @override
  State<AnalyticsDashboardPage> createState() =>
      _AnalyticsDashboardPageState();
}

class _AnalyticsDashboardPageState
    extends State<AnalyticsDashboardPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<AnalyticsProvider>()
          .loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<AnalyticsProvider>();

    if (provider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.error != null) {
      return Center(
        child: Text(provider.error!),
      );
    }

    return Scaffold(
  backgroundColor: const Color(0xFF0F0F0F),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const AnalyticsHeader(),

          const SizedBox(height: 30),

          SummaryCards(
            provider: provider,
          ),

          const SizedBox(height: 30),

       SalesChart(
  data: provider.salesChart,
),

const SizedBox(height: 30),

WebsiteTrafficCard(
  todayVisitors:
      provider.summary?.todayVisitors ?? 0,
  totalVisitors:
      provider.summary?.totalVisitors ?? 0,
),

const SizedBox(height: 30),

PageAnalyticsTable(
  pages: provider.pages,
),

const SizedBox(height: 30),

CustomerRegionCard(
  regions: provider.regions,
),

const SizedBox(height: 30),

DeviceAnalyticsCard(
  devices: provider.devices,
),

const SizedBox(height: 30),

TrafficSourceChart(
  sources: provider.sources,
),

const SizedBox(height: 30),

if (provider.inventory != null)
  InventorySummaryCard(
    inventory: provider.inventory!,
  ),

  const SizedBox(height: 30),

BestSellingProducts(
  products:  provider.bestSellingProducts,
),

const SizedBox(height: 30),

LowStockAlerts(
  products: provider.lowStockProducts,
),
        ],
      ),
    )
    );
  }
}