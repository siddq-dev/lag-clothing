import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/add_payment_button.dart';
import '../widgets/empty_payment.dart';
import '../widgets/payment_card.dart';
import '../widgets/payment_header.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {

    /// Temporary Data
    /// Empty List = Empty Screen
    /// Add PaymentCard objects later from Firebase

    final List<Map<String, dynamic>> cards = [];

    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const PaymentHeader(),

            const SizedBox(
              height: AppSpacing.xxxl,
            ),

            if (cards.isEmpty)

              const EmptyPayment()

            else

              Expanded(
                child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {

                    final card = cards[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: PaymentCard(
                        brand: card["brand"],
                        last4: card["last4"],
                        expiry: card["expiry"],
                        defaultCard: card["default"],
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(
              height: AppSpacing.xxl,
            ),

            AddPaymentButton(
              onPressed: () {
                // Navigate to Add Payment Method
              },
            ),

          ],
        ),
      ),
    );
  }
}