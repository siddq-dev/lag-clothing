import 'package:flutter/material.dart';

import '../../../models/payment_method_model.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.paymentMethod,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  final PaymentMethodModel paymentMethod;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  paymentMethod.cardBrand,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                if (paymentMethod.isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "DEFAULT",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              "**** **** **** ${paymentMethod.last4Digits}",
              style: const TextStyle(
                fontSize: 22,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              paymentMethod.cardHolderName,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 6),

            Text(
              "Expires ${paymentMethod.expiryMonth}/${paymentMethod.expiryYear}",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit"),
                ),

                const SizedBox(width: 12),

                OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                ),

                const Spacer(),

                if (!paymentMethod.isDefault)
                  FilledButton(
                    onPressed: onSetDefault,
                    child: const Text("Set Default"),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
