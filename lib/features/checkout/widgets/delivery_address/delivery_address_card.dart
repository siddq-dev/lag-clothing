import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';
import '../../../../../themes/app_text_style.dart';

class DeliveryAddressCard extends StatefulWidget {
  const DeliveryAddressCard({super.key});

  @override
  State<DeliveryAddressCard> createState() => _DeliveryAddressCardState();
}

class _DeliveryAddressCardState extends State<DeliveryAddressCard> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _pincodeController.dispose();
    _countryController.dispose();

    super.dispose();
  }

  void _saveShippingAddress() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final checkoutProvider = context.read<CheckoutProvider>();

    // Call dynamically to avoid compile-time error if the provider's API differs
    (checkoutProvider as dynamic).setShippingAddressFromForm(
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      addressLine1: _addressLine1Controller.text.trim(),
      addressLine2: _addressLine2Controller.text.trim(),
      landmark: _landmarkController.text.trim(),
      city: _cityController.text.trim(),
      state: _stateController.text.trim(),
      pincode: _pincodeController.text.trim(),
      country: _countryController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        onChanged: _saveShippingAddress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shipping Address", style: AppTextStyles.heading2),

            const SizedBox(height: 8),

            Text(
              "Enter the delivery address for this order.",
              style: AppTextStyles.bodyLarge,
            ),

            const SizedBox(height: 24),

            _buildSavedAddressHint(context),

            const SizedBox(height: 20),

            _field(
              controller: _fullNameController,
              label: "Full Name",
              hint: "Enter your full name",
            ),

            const SizedBox(height: 18),

            _field(
              controller: _phoneController,
              label: "Phone Number",
              hint: "Enter phone number",
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 18),

            _field(
              controller: _addressLine1Controller,
              label: "Address Line 1",
              hint: "House / flat / street address",
            ),

            const SizedBox(height: 18),

            _field(
              controller: _addressLine2Controller,
              label: "Address Line 2",
              hint: "Area / locality",
            ),

            const SizedBox(height: 18),

            _field(
              controller: _landmarkController,
              label: "Landmark",
              hint: "Nearby landmark",
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      _field(
                        controller: _cityController,
                        label: "City",
                        hint: "City",
                      ),
                      const SizedBox(height: 18),
                      _field(
                        controller: _stateController,
                        label: "State",
                        hint: "State",
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _field(
                        controller: _cityController,
                        label: "City",
                        hint: "City",
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _field(
                        controller: _stateController,
                        label: "State",
                        hint: "State",
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 18),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      _field(
                        controller: _pincodeController,
                        label: "Pincode",
                        hint: "Pincode",
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 18),
                      _field(
                        controller: _countryController,
                        label: "Country",
                        hint: "Country",
                      ),
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: _field(
                        controller: _pincodeController,
                        label: "Pincode",
                        hint: "Pincode",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _field(
                        controller: _countryController,
                        label: "Country",
                        hint: "Country",
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavedAddressHint(BuildContext context) {
    final checkoutProvider = context.watch<CheckoutProvider>();

    // Use dynamic access to avoid compile-time dependency on a specific getter name
    final savedAddress = (checkoutProvider as dynamic).defaultShippingAddressHint;

    if (savedAddress == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: AppColors.primary),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              "Saved profile address found: "
              "${savedAddress.city}, "
              "${savedAddress.state}. "
              "Start typing to use it as a reference.",
              style: AppTextStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: "$label *",
        hintText: hint,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$label is required";
        }

        return null;
      },
    );
  }
}
