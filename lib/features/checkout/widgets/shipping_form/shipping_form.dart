import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class ShippingForm extends StatelessWidget {
  const ShippingForm({super.key});

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
            "Shipping Information",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: AppSpacing.xl),

          Row(
            children: const [

              Expanded(
                child: _CheckoutTextField(
                  hint: "First Name",
                ),
              ),

              SizedBox(width: 20),

              Expanded(
                child: _CheckoutTextField(
                  hint: "Last Name",
                ),
              ),

            ],
          ),

          const SizedBox(height: 20),

          const _CheckoutTextField(
            hint: "Email Address",
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 20),

          const _CheckoutTextField(
            hint: "Phone Number",
            keyboardType: TextInputType.phone,
          ),

          const SizedBox(height: 20),

          const _CheckoutTextField(
            hint: "Street Address",
          ),

          const SizedBox(height: 20),

          const _CheckoutTextField(
            hint: "Apartment / Landmark (Optional)",
          ),

          const SizedBox(height: 20),

          Row(
            children: const [

              Expanded(
                child: _CheckoutTextField(
                  hint: "City",
                ),
              ),

              SizedBox(width: 20),

              Expanded(
                child: _CheckoutTextField(
                  hint: "State",
                ),
              ),

            ],
          ),

          const SizedBox(height: 20),

          Row(
            children: const [

              Expanded(
                child: _CheckoutTextField(
                  hint: "Pincode",
                  keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(width: 20),

              Expanded(
                child: _CheckoutTextField(
                  hint: "Country",
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

class _CheckoutTextField extends StatelessWidget {
  const _CheckoutTextField({
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