import 'package:flutter/material.dart';

import '../../../themes/app_spacing.dart';
import '../../../themes/app_text_style.dart';
import 'address_type_selector.dart';
import 'saved_address_button.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({
    super.key,
    this.isEditing = false,
  });

  final bool isEditing;

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final pincodeController = TextEditingController();

  String selectedState = "Tamil Nadu";
  String selectedCountry = "India";
  String selectedType = "Home";

  bool isDefault = false;

  final List<String> states = [
    "Tamil Nadu",
    "Kerala",
    "Karnataka",
    "Andhra Pradesh",
    "Telangana",
    "Maharashtra",
    "Delhi",
    "Gujarat",
    "West Bengal",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          _buildField(
            controller: fullNameController,
            label: "Full Name",
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildField(
            controller: phoneController,
            label: "Mobile Number",
            keyboard: TextInputType.phone,
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildField(
            controller: address1Controller,
            label: "Address Line 1",
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildField(
            controller: address2Controller,
            label: "Address Line 2",
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildField(
            controller: cityController,
            label: "City",
          ),

          const SizedBox(height: AppSpacing.lg),

          DropdownButtonFormField<String>(
            value: selectedState,
            decoration: const InputDecoration(
              labelText: "State",
              border: OutlineInputBorder(),
            ),
            items: states
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedState = value!;
              });
            },
          ),

          const SizedBox(height: AppSpacing.lg),

          _buildField(
            controller: pincodeController,
            label: "Pincode",
            keyboard: TextInputType.number,
          ),

          const SizedBox(height: AppSpacing.lg),

          DropdownButtonFormField<String>(
            value: selectedCountry,
            decoration: const InputDecoration(
              labelText: "Country",
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: "India",
                child: Text("India"),
              ),
            ],
            onChanged: (value) {
              setState(() {
                selectedCountry = value!;
              });
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          AddressTypeSelector(
            selectedType: selectedType,
            onChanged: (value) {
              setState(() {
                selectedType = value;
              });
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          CheckboxListTile(
            value: isDefault,
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Set as Default Address",
              style: AppTextStyles.bodyLarge,
            ),
            onChanged: (value) {
              setState(() {
                isDefault = value!;
              });
            },
          ),

          const SizedBox(height: AppSpacing.xl),

          SaveAddressButton(
            isEditing: widget.isEditing,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save later
              }
            },
          ),

        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Required";
        }
        return null;
      },
    );
  }
}