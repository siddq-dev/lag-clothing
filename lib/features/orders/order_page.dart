import 'package:flutter/material.dart';

import '../../../../layout/website_layout.dart';
import '../../../../routes/app_routes.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WebsiteLayout(
      currentRoute: AppRouter.orders,
      child: Center(
        child: Text(
          "Orders Page",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
