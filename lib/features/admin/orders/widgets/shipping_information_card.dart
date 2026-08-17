import 'package:flutter/material.dart';

import '../../../../../models/order_model.dart';

class ShippingInformationCard extends StatelessWidget {
  const ShippingInformationCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final address = order.shippingAddress;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Shipping Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _infoRow(Icons.person, "Recipient", address.fullName),

            const Divider(),

            _infoRow(Icons.phone, "Phone", address.phone),

            const Divider(),

            _infoRow(Icons.location_on, "Address", address.addressLine1),

            if (address.addressLine2.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 40, top: 6),
                child: Text(address.addressLine2),
              ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("${address.city}, ${address.state}"),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text("${address.country} - ${address.pincode}"),
            ),

            const SizedBox(height: 20),

            const Divider(),

            _infoRow(
              Icons.local_shipping,
              "Tracking ID",
              order.trackingId.isEmpty ? "-" : order.trackingId,
            ),

            const Divider(),

            _infoRow(
              Icons.inventory_2,
              "Order Status",
              order.orderStatus.name.toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}
