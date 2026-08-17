import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({
    super.key,
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

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required bool requiredField,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (requiredField && (value == null || value.trim().isEmpty)) {
            return "$label is required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: requiredField ? "$label *" : "$label (Optional)",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildField(
            label: "Full Name",
            controller: fullNameController,
            requiredField: true,
          ),

          buildField(
            label: "Phone Number",
            controller: phoneController,
            requiredField: true,
            keyboardType: TextInputType.phone,
          ),

          buildField(
            label: "Address Line 1",
            controller: address1Controller,
            requiredField: true,
            maxLines: 2,
          ),

          buildField(
            label: "Address Line 2",
            controller: address2Controller,
            requiredField: false,
            maxLines: 2,
          ),

          buildField(
            label: "Landmark",
            controller: landmarkController,
            requiredField: false,
          ),

          Row(
            children: [
              Expanded(
                child: buildField(
                  label: "City",
                  controller: cityController,
                  requiredField: true,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildField(
                  label: "State",
                  controller: stateController,
                  requiredField: true,
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: buildField(
                  label: "Pincode",
                  controller: pincodeController,
                  requiredField: true,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildField(
                  label: "Country",
                  controller: countryController,
                  requiredField: true,
                ),
              ),
            ],
          ),

          CheckboxListTile(
            value: isDefault,
            onChanged: onDefaultChanged,
            title: const Text("Set as Default Address"),
            contentPadding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
