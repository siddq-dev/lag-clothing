import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../layout/admin_layout.dart';
import '../../../../routes/app_routes.dart';

import '/models/customer_admin_model.dart';
import '/providers/customer_management_provider.dart';

import '../widgets/customer_profile_card.dart';
import '../widgets/customer_statistics_card.dart';
import '../widgets/current_order_card.dart';
import '../widgets/previous_orders_section.dart';

class CustomerDetailsPage extends StatefulWidget {
  const CustomerDetailsPage({
    super.key,
    required this.customer,
  });

  final CustomerAdminModel customer;

  @override
  State<CustomerDetailsPage> createState() =>
      _CustomerDetailsPageState();
}

class _CustomerDetailsPageState
    extends State<CustomerDetailsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<CustomerManagementProvider>()
          .loadCustomer(widget.customer);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<CustomerManagementProvider>();

    return AdminLayout(
      title: 'Customer Details',
      currentRoute: AppRouter.customerManagement,
      child: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.error != null
              ? Center(
                  child: Text(provider.error!),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(
                        maxWidth: 1400,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          //------------------------------------
                          // Header
                          //------------------------------------

                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                ),
                              ),

                              const SizedBox(width: 10),

                              const Text(
                                "Customer Details",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),

                          //------------------------------------
                          // Customer Profile
                          //------------------------------------

                          CustomerProfileCard(
                            customer:
                                provider.selectedCustomer!,
                          ),

                          const SizedBox(height: 30),

                          //------------------------------------
                          // Statistics
                          //------------------------------------

                          CustomerStatisticsCard(
                            totalOrders:
                                provider.orders.length,
                            totalSpend:
                                provider.totalSpend,
                            averageOrder:
                                provider.averageOrderValue,
                            lastOrder:
                                provider.lastOrder,
                          ),

                          const SizedBox(height: 30),

                          //------------------------------------
                          // Current Order
                          //------------------------------------

                          if (provider.currentOrder != null)
                            CurrentOrderCard(
                              order:
                                  provider.currentOrder!,
                            ),

                          const SizedBox(height: 30),

                          //------------------------------------
                          // Previous Orders
                          //------------------------------------

                          PreviousOrdersSection(
                            orders: provider.orders,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}