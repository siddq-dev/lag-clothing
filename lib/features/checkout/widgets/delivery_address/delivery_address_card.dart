import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';
import '../../../../../themes/app_colors.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final checkout =
        context.watch<CheckoutProvider>().checkout;

    final address = checkout?.selectedAddress;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Delivery Address",
            style: AppTextStyles.heading3,
          ),

          const SizedBox(height: 20),

          if (address == null)
            const Text(
              "No Address Selected",
            )
          else
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  address.fullName,
                  style: AppTextStyles.heading3,
                ),

                const SizedBox(height: 8),

                Text(address.phone),

                const SizedBox(height: 8),

                Text(
                  "${address.addressLine1}, ${address.addressLine2}",
                ),

                const SizedBox(height: 4),

                Text(
                  "${address.city}, ${address.state}",
                ),

                Text(address.pincode),
              ],
            ),

          const SizedBox(height: 20),

          OutlinedButton(
            onPressed: () {
              // TODO
              // Navigate to Saved Addresses
            },
            child: const Text(
              "Change Address",
            ),
          ),
        ],
      ),
    );
  }
}