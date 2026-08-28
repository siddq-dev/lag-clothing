import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lag_clothing/models/checkout_model.dart';
import 'package:provider/provider.dart';

import '../../../../../models/address_model.dart';
import '../../../../../providers/checkout_provider.dart';
import '../../../../../themes/app_colors.dart';
import '../../../../../themes/app_spacing.dart';

enum CheckoutAddressPurpose { shipping, billing }

class CheckoutAddressForm extends StatefulWidget {
  const CheckoutAddressForm({super.key, required this.purpose});

  final CheckoutAddressPurpose purpose;

  @override
  State<CheckoutAddressForm> createState() => _CheckoutAddressFormState();
}

class _CheckoutAddressFormState extends State<CheckoutAddressForm> {
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

  bool _initialized = false;

  /// Controls whether the billing address reuses the shipping address.
  /// Defaults to true for billing ("Same as Shipping Address" vs "Other").
  bool _sameAsShipping = true;

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

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckoutProvider>();

    final checkout = provider.checkout;

    if (!_initialized) {
      _loadExistingCheckoutAddress(checkout);

      _initialized = true;
    }

    final isBilling = widget.purpose == CheckoutAddressPurpose.billing;

    final purposeText = widget.purpose == CheckoutAddressPurpose.shipping
        ? 'shipping'
        : 'billing';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 19, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Enter your $purposeText address for this order.',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),

            // ======================================================
            // BILLING-ONLY: MUTUALLY-EXCLUSIVE RADIO-STYLE CHECKBOXES
            // ======================================================
            if (isBilling) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 24,
                runSpacing: 10,
                children: [
                  // Option 1: Same as Shipping Address
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (!_sameAsShipping) {
                        setState(() {
                          _sameAsShipping = true;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _sameAsShipping,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              if (value == true || !_sameAsShipping) {
                                setState(() {
                                  _sameAsShipping = true;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Same as Shipping Address',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Option 2: Other (reveals manual fields)
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      if (_sameAsShipping) {
                        setState(() {
                          _sameAsShipping = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 4,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: !_sameAsShipping,
                            activeColor: AppColors.primary,
                            onChanged: (value) {
                              if (value == true || _sameAsShipping) {
                                setState(() {
                                  _sameAsShipping = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Other',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Summary preview of shipping address when "Same as Shipping" is selected
              if (_sameAsShipping && checkout?.shippingAddress != null) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkout!.shippingAddress!.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${checkout.shippingAddress!.addressLine1}, '
                        '${checkout.shippingAddress!.addressLine2.isNotEmpty ? '${checkout.shippingAddress!.addressLine2}, ' : ''}'
                        '${checkout.shippingAddress!.city}, ${checkout.shippingAddress!.state} - ${checkout.shippingAddress!.pincode}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Phone: ${checkout.shippingAddress!.phone}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],

            // ======================================================
            // ADDRESS INPUT FIELDS
            // Shown for shipping, or when billing selects "Other"
            // ======================================================
            if (!isBilling || !_sameAsShipping) ...[
              const SizedBox(height: 22),

              // ====================================================
              // NAME + PHONE
              // ====================================================
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _field(
                          controller: _fullNameController,
                          label: 'Full Name',
                          hint: 'Enter full name',
                          icon: Icons.person_outline,
                          validator: _required,
                        ),
                        const SizedBox(height: 18),
                        _field(
                          controller: _phoneController,
                          label: 'Phone Number',
                          hint: 'Enter phone number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: _field(
                          controller: _fullNameController,
                          label: 'Full Name',
                          hint: 'Enter full name',
                          icon: Icons.person_outline,
                          validator: _required,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _field(
                          controller: _phoneController,
                          label: 'Phone Number',
                          hint: 'Enter phone number',
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: _validatePhone,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 18),

              _field(
                controller: _addressLine1Controller,
                label: 'Address Line 1',
                hint: 'House / Flat / Building / Street',
                icon: Icons.home_outlined,
                validator: _required,
              ),

              const SizedBox(height: 18),

              _field(
                controller: _addressLine2Controller,
                label: 'Address Line 2',
                hint: 'Area / Locality',
                icon: Icons.location_on_outlined,
                validator: _required,
              ),

              const SizedBox(height: 18),

              _field(
                controller: _landmarkController,
                label: 'Landmark',
                hint: 'Nearby landmark',
                icon: Icons.place_outlined,
                validator: _required,
              ),

              const SizedBox(height: 18),

              // ====================================================
              // CITY + STATE
              // ====================================================
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _field(
                          controller: _cityController,
                          label: 'City',
                          hint: 'Enter city',
                          icon: Icons.location_city_outlined,
                          validator: _required,
                        ),
                        const SizedBox(height: 18),
                        _field(
                          controller: _stateController,
                          label: 'State',
                          hint: 'Enter state',
                          icon: Icons.map_outlined,
                          validator: _required,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: _field(
                          controller: _cityController,
                          label: 'City',
                          hint: 'Enter city',
                          icon: Icons.location_city_outlined,
                          validator: _required,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _field(
                          controller: _stateController,
                          label: 'State',
                          hint: 'Enter state',
                          icon: Icons.map_outlined,
                          validator: _required,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 18),

              // ====================================================
              // PINCODE + COUNTRY
              // ====================================================
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 600) {
                    return Column(
                      children: [
                        _field(
                          controller: _pincodeController,
                          label: 'Pincode',
                          hint: 'Enter pincode',
                          icon: Icons.pin_drop_outlined,
                          keyboardType: TextInputType.number,
                          validator: _validatePincode,
                        ),
                        const SizedBox(height: 18),
                        _field(
                          controller: _countryController,
                          label: 'Country',
                          hint: 'Enter country',
                          icon: Icons.public_outlined,
                          validator: _required,
                        ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: _field(
                          controller: _pincodeController,
                          label: 'Pincode',
                          hint: 'Enter pincode',
                          icon: Icons.pin_drop_outlined,
                          keyboardType: TextInputType.number,
                          validator: _validatePincode,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _field(
                          controller: _countryController,
                          label: 'Country',
                          hint: 'Enter country',
                          icon: Icons.public_outlined,
                          validator: _required,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],

            const SizedBox(height: 24),

            // ======================================================
            // CONFIRM
            // ======================================================
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: _validateAndSave,
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Confirm Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // FIELD
  // ==============================================================

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: '$label *',
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.border),
        ),
      ),
    );
  }

  // ==============================================================
  // VALIDATORS
  // ==============================================================

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phone = value.replaceAll(RegExp(r'\s+'), '');

    if (!RegExp(r'^[+]?[0-9]{10,15}$').hasMatch(phone)) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Pincode is required';
    }

    if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'Enter a valid 6-digit pincode';
    }

    return null;
  }

  // ==============================================================
  // LOAD EXISTING CHECKOUT ADDRESS
  // ==============================================================

  void _loadExistingCheckoutAddress(CheckoutModel? checkout) {
    if (checkout == null) {
      return;
    }

    final address = widget.purpose == CheckoutAddressPurpose.shipping
        ? checkout.shippingAddress
        : checkout.billingAddress;

    if (address == null) {
      return;
    }

    _fullNameController.text = address.fullName;

    _phoneController.text = address.phone;

    _addressLine1Controller.text = address.addressLine1;

    _addressLine2Controller.text = address.addressLine2;

    _landmarkController.text = address.landmark;

    _cityController.text = address.city;

    _stateController.text = address.state;

    _pincodeController.text = address.pincode;

    _countryController.text = address.country;
  }

  // ==============================================================
  // VALIDATE + SAVE
  // ==============================================================

  void _validateAndSave() {
    final provider = context.read<CheckoutProvider>();

    // ------------------------------------------------------------
    // BILLING: REUSE SHIPPING ADDRESS
    // ------------------------------------------------------------
    if (widget.purpose == CheckoutAddressPurpose.billing && _sameAsShipping) {
      final shippingAddress = provider.checkout?.shippingAddress;

      if (shippingAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please confirm your shipping address first.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final billingAddress = AddressModel(
        id: '',
        userId: shippingAddress.userId,
        fullName: shippingAddress.fullName,
        phone: shippingAddress.phone,
        addressLine1: shippingAddress.addressLine1,
        addressLine2: shippingAddress.addressLine2,
        landmark: shippingAddress.landmark,
        city: shippingAddress.city,
        state: shippingAddress.state,
        pincode: shippingAddress.pincode,
        country: shippingAddress.country,
        addressType: shippingAddress.addressType,
        purpose: AddressPurpose.billing,
        isDefault: false,
        createdAt: null,
        updatedAt: null,
      );

      provider.setBillingAddress(billingAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Billing address confirmed.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // ------------------------------------------------------------
    // STANDARD / MANUAL VALIDATE & SAVE
    // ------------------------------------------------------------
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required address fields.'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      return;
    }

    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in before continuing.')),
      );

      return;
    }

    final isShipping = widget.purpose == CheckoutAddressPurpose.shipping;

    final address = AddressModel(
      // Checkout-only address.
      id: '',
      userId: firebaseUser.uid,

      fullName: _fullNameController.text.trim(),

      phone: _phoneController.text.trim(),

      addressLine1: _addressLine1Controller.text.trim(),

      addressLine2: _addressLine2Controller.text.trim(),

      landmark: _landmarkController.text.trim(),

      city: _cityController.text.trim(),

      state: _stateController.text.trim(),

      pincode: _pincodeController.text.trim(),

      country: _countryController.text.trim(),

      addressType: AddressType.other,

      purpose: isShipping ? AddressPurpose.shipping : AddressPurpose.billing,

      isDefault: false,

      createdAt: null,
      updatedAt: null,
    );

    if (isShipping) {
      provider.setShippingAddress(address);
    } else {
      provider.setBillingAddress(address);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${isShipping ? 'Shipping' : 'Billing'} address confirmed.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
