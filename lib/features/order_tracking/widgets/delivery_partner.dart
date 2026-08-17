import 'package:flutter/material.dart';

class DeliveryPartner extends StatelessWidget {
  const DeliveryPartner({
    super.key,
    required this.partnerName,
    required this.trackingId,
    required this.contactNumber,
  });

  final String partnerName;
  final String trackingId;
  final String contactNumber;

  Widget buildRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          CircleAvatar(radius: 22, child: Icon(icon)),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Partner",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            buildRow(Icons.local_shipping, "Courier", partnerName),

            buildRow(Icons.confirmation_number, "Tracking ID", trackingId),

            buildRow(Icons.phone, "Support", contactNumber),
          ],
        ),
      ),
    );
  }
}
