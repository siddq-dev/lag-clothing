import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.brand,
    required this.last4,
    required this.expiry,
    required this.defaultCard,
  });

  final String brand;
  final String last4;
  final String expiry;
  final bool defaultCard;

  @override
  Widget build(BuildContext context) {

    return Card(
      child: ListTile(

        leading: const Icon(
          Icons.credit_card,
        ),

        title: Text(
          brand,
        ),

        subtitle: Text(
          "**** **** **** $last4\nExpiry $expiry",
        ),

        trailing: defaultCard
            ? const Chip(
                label: Text("Default"),
              )
            : null,

      ),
    );
  }
}