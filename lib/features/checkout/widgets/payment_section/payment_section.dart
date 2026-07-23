import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

enum PaymentMethodType {
  upi,
  creditCard,
  debitCard,
  cod,
}

class PaymentSection extends StatefulWidget {
  const PaymentSection({super.key});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  PaymentMethodType _selected = PaymentMethodType.upi;

  final List<String> banks = const [
    "State Bank of India",
    "HDFC Bank",
    "ICICI Bank",
    "Axis Bank",
    "Canara Bank",
    "Indian Bank",
    "Punjab National Bank",
    "Bank of Baroda",
    "Federal Bank",
    "IDFC First Bank",
    "Kotak Mahindra Bank",
    "IndusInd Bank",
    "Yes Bank",
    "Union Bank of India",
  ];

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
            "Payment Method",
            style: AppTextStyles.heading2,
          ),

          const SizedBox(height: 25),

          _paymentTile(
            "UPI",
            PaymentMethodType.upi,
          ),

          _paymentTile(
            "Credit Card",
            PaymentMethodType.creditCard,
          ),

          _paymentTile(
            "Debit Card",
            PaymentMethodType.debitCard,
          ),

          _paymentTile(
            "Cash on Delivery",
            PaymentMethodType.cod,
          ),

          const SizedBox(height: 25),

          if (_selected == PaymentMethodType.upi)
            const _UpiSection(),

          if (_selected == PaymentMethodType.creditCard ||
              _selected == PaymentMethodType.debitCard)
            _CardSection(
              banks: banks,
            ),

          if (_selected == PaymentMethodType.cod)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Pay when your order is delivered.",
              ),
            ),
        ],
      ),
    );
  }

  Widget _paymentTile(
    String title,
    PaymentMethodType value,
  ) {
    return RadioListTile<PaymentMethodType>(
      value: value,
      groupValue: _selected,
      activeColor: AppColors.primary,
      title: Text(title),
      onChanged: (value) {
        setState(() {
          _selected = value!;
        });
      },
    );
  }
}

class _UpiSection extends StatelessWidget {
  const _UpiSection();

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Enter UPI ID (example@okaxis)",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class _CardSection extends StatelessWidget {
  const _CardSection({
    required this.banks,
  });

  final List<String> banks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Autocomplete<String>(
          optionsBuilder: (TextEditingValue value) {
            if (value.text.isEmpty) {
              return banks;
            }

            return banks.where(
              (bank) => bank
                  .toLowerCase()
                  .contains(value.text.toLowerCase()),
            );
          },
          fieldViewBuilder: (
            context,
            controller,
            focusNode,
            onSubmit,
          ) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: "Bank Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Card Number",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: 120,
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 3,
            decoration: InputDecoration(
              hintText: "CVV",
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),

      ],
    );
  }
}