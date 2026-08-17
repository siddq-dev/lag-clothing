import 'package:flutter/material.dart';

class CardForm extends StatelessWidget {
  const CardForm({
    super.key,
    required this.formKey,
    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryMonthController,
    required this.expiryYearController,
    required this.cvvController,
    required this.isDefault,
    required this.onDefaultChanged,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryMonthController;
  final TextEditingController expiryYearController;
  final TextEditingController cvvController;

  final bool isDefault;
  final ValueChanged<bool?> onDefaultChanged;

  InputDecoration decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: cardHolderController,
            decoration: decoration("Card Holder Name *"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Card holder name is required";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: cardNumberController,
            keyboardType: TextInputType.number,
            decoration: decoration("Card Number *"),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Card number is required";
              }

              final number = value.replaceAll(" ", "");

              if (number.length != 16) {
                return "Enter a valid 16-digit card number";
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: expiryMonthController,
                  keyboardType: TextInputType.number,
                  decoration: decoration("Month"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    final month = int.tryParse(value);

                    if (month == null || month < 1 || month > 12) {
                      return "Invalid";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: TextFormField(
                  controller: expiryYearController,
                  keyboardType: TextInputType.number,
                  decoration: decoration("Year"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: TextFormField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: decoration("CVV"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }

                    if (value.length != 3) {
                      return "Invalid";
                    }

                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          CheckboxListTile(
            value: isDefault,
            onChanged: onDefaultChanged,
            contentPadding: EdgeInsets.zero,
            title: const Text("Set as Default Payment Method"),
          ),
        ],
      ),
    );
  }
}
