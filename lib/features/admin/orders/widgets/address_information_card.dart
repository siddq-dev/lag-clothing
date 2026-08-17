import 'package:flutter/material.dart';

import '../../../../../models/address_model.dart';

class AddressInformationCard extends StatelessWidget {
  const AddressInformationCard({
    super.key,
    required this.shippingAddress,
    required this.billingAddress,
  });

  final AddressModel shippingAddress;
  final AddressModel billingAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _addressCard(
            title: "Shipping Address",
            address: shippingAddress,
            icon: Icons.local_shipping,
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: _addressCard(
            title: "Billing Address",
            address: billingAddress,
            icon: Icons.receipt_long,
          ),
        ),
      ],
    );
  }

  Widget _addressCard({
    required String title,
    required AddressModel address,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),

                const SizedBox(width: 10),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Divider(height: 30),

            Text(
              address.fullName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 8),

            Text(address.phone),

            const SizedBox(height: 12),

            Text(address.addressLine1),

            if (address.addressLine2.isNotEmpty) Text(address.addressLine2),

            Text("${address.city}, ${address.state}"),

            Text("${address.country} - ${address.pincode}"),
          ],
        ),
      ),
    );
  }
}
