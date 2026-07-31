import 'package:flutter/material.dart';

import 'order_status_dropdown.dart';

class UpdateOrderStatusCard extends StatelessWidget {
  const UpdateOrderStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Update Order Status",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const OrderStatusDropdown(),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},

                child: const Text(
                  "Update Status",
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}