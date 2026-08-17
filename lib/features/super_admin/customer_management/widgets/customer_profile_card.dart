import 'package:flutter/material.dart';

import '/models/customer_admin_model.dart';

class CustomerProfileCard extends StatelessWidget {
  const CustomerProfileCard({super.key, required this.customer});

  final CustomerAdminModel customer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: customer.photoUrl.isNotEmpty
                  ? NetworkImage(customer.photoUrl)
                  : null,
              child: customer.photoUrl.isEmpty
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),

            const SizedBox(width: 30),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customer.fullName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  _infoTile(Icons.email, "Email", customer.email),

                  _infoTile(Icons.phone, "Phone", customer.phone),

                  _infoTile(
                    Icons.calendar_today,
                    "Joined",
                    customer.createdAt?.toDate().toString().split(" ").first ??
                        "-",
                  ),

                  _infoTile(
                    Icons.shopping_bag,
                    "Total Orders",
                    customer.totalOrders.toString(),
                  ),

                  const SizedBox(height: 20),

                  Chip(
                    backgroundColor: Colors.blue,
                    label: Text(
                      "₹${customer.totalSpent.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon),

          const SizedBox(width: 12),

          SizedBox(
            width: 90,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
