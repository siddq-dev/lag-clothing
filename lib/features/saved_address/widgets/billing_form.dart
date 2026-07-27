import 'package:flutter/material.dart';

import 'address_form.dart';

class BillingForm extends StatelessWidget {
  const BillingForm({
    super.key,
    required this.sameAsShipping,
    required this.onChanged,

    required this.formKey,

    required this.fullNameController,
    required this.phoneController,
    required this.address1Controller,
    required this.address2Controller,
    required this.landmarkController,
    required this.cityController,
    required this.stateController,
    required this.pincodeController,
    required this.countryController,

    required this.isDefault,
    required this.onDefaultChanged,
  });

  final bool sameAsShipping;
  final ValueChanged<bool?> onChanged;

  final GlobalKey<FormState> formKey;

  final TextEditingController fullNameController;
  final TextEditingController phoneController;
  final TextEditingController address1Controller;
  final TextEditingController address2Controller;
  final TextEditingController landmarkController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController pincodeController;
  final TextEditingController countryController;

  final bool isDefault;
  final ValueChanged<bool?> onDefaultChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CheckboxListTile(
          value: sameAsShipping,
          onChanged: onChanged,
          contentPadding: EdgeInsets.zero,
          title: const Text(
            "Billing Address same as Shipping",
          ),
        ),

        if (!sameAsShipping) ...[
          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Billing Address",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          AddressForm(
            formKey: formKey,

            fullNameController: fullNameController,
            phoneController: phoneController,
            address1Controller: address1Controller,
            address2Controller: address2Controller,
            landmarkController: landmarkController,
            cityController: cityController,
            stateController: stateController,
            pincodeController: pincodeController,
            countryController: countryController,

            isDefault: isDefault,
            onDefaultChanged: onDefaultChanged,
          ),
        ],
      ],
    );
  }
}