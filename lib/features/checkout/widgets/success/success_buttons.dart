import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../routes/app_routes.dart';

class SuccessButtons extends StatelessWidget {
  const SuccessButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              context.go(AppRouter.myOrders);
            },
            child: const Text("My Orders"),
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.go(AppRouter.shop);
            },
            child: const Text("Continue Shopping"),
          ),
        ),
      ],
    );
  }
}
