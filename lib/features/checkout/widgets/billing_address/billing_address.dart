import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class BillingAddress extends StatefulWidget {
  const BillingAddress({super.key});

  @override
  State<BillingAddress> createState() => _BillingAddressState();
}

class _BillingAddressState extends State<BillingAddress> {
  bool sameAsShipping = true;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "Billing Address",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 20),

          RadioListTile<bool>(
            value: true,
            groupValue: sameAsShipping,
            activeColor: AppColors.primary,
            title: const Text("Same as Shipping Address"),
            onChanged: (value) {
              setState(() {
                sameAsShipping = true;
              });
            },
          ),

          RadioListTile<bool>(
            value: false,
            groupValue: sameAsShipping,
            activeColor: AppColors.primary,
            title: const Text("Other Billing Address"),
            onChanged: (value) {
              setState(() {
                sameAsShipping = false;
              });
            },
          ),

          if (!sameAsShipping) ...[
            const SizedBox(height: 25),

            Row(
              children: const [

                Expanded(
                  child: _BillingTextField(
                    hint: "First Name",
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: _BillingTextField(
                    hint: "Last Name",
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            const _BillingTextField(
              hint: "Email Address",
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 20),

            const _BillingTextField(
              hint: "Phone Number",
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 20),

            const _BillingTextField(
              hint: "Street Address",
            ),

            const SizedBox(height: 20),

            Row(
              children: const [

                Expanded(
                  child: _BillingTextField(
                    hint: "City",
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: _BillingTextField(
                    hint: "State",
                  ),
                ),

              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: const [

                Expanded(
                  child: _BillingTextField(
                    hint: "Pincode",
                    keyboardType: TextInputType.number,
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: _BillingTextField(
                    hint: "Country",
                  ),
                ),

              ],
            ),
          ],

        ],
      ),
    );
  }
}

class _BillingTextField extends StatelessWidget {
  const _BillingTextField({
    required this.hint,
    this.keyboardType,
  });

  final String hint;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: AppColors.background,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
      ),
    );
  }
}