import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/address_provider.dart';

import '../widgets/address_form.dart';
import '../widgets/billing_form.dart';
import '../widgets/save_address_button.dart';
import '../../../models/address_model.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({
    super.key,
    this.address,
    this.isEditing = false,
  });

  final AddressModel? address;
  final bool isEditing;

  @override
  State<AddAddressPage> createState() =>
      _AddAddressPageState();
}

class _AddAddressPageState
    extends State<AddAddressPage> {

  final shippingFormKey = GlobalKey<FormState>();
  final billingFormKey = GlobalKey<FormState>();

  bool billingSame = true;

  // Shipping Controllers

  final shippingName = TextEditingController();
  final shippingPhone = TextEditingController();
  final shippingAddress1 = TextEditingController();
  final shippingAddress2 = TextEditingController();
  final shippingLandmark = TextEditingController();
  final shippingCity = TextEditingController();
  final shippingState = TextEditingController();
  final shippingPincode = TextEditingController();
  final shippingCountry = TextEditingController();

  bool shippingDefault = true;

  // Billing Controllers

  final billingName = TextEditingController();
  final billingPhone = TextEditingController();
  final billingAddress1 = TextEditingController();
  final billingAddress2 = TextEditingController();
  final billingLandmark = TextEditingController();
  final billingCity = TextEditingController();
  final billingState = TextEditingController();
  final billingPincode = TextEditingController();
  final billingCountry = TextEditingController();

  bool billingDefault = false;

  @override
void initState() {
  super.initState();

  if (widget.isEditing && widget.address != null) {
    final address = widget.address!;

    shippingName.text = address.fullName;
    shippingPhone.text = address.phone;
    shippingAddress1.text = address.addressLine1;
    shippingAddress2.text = address.addressLine2;
    shippingLandmark.text = address.landmark;
    shippingCity.text = address.city;
    shippingState.text = address.state;
    shippingPincode.text = address.pincode;
    shippingCountry.text = address.country;

    shippingDefault = address.isDefault;
  }
}

  @override
  void dispose() {
    shippingName.dispose();
    shippingPhone.dispose();
    shippingAddress1.dispose();
    shippingAddress2.dispose();
    shippingLandmark.dispose();
    shippingCity.dispose();
    shippingState.dispose();
    shippingPincode.dispose();
    shippingCountry.dispose();

    billingName.dispose();
    billingPhone.dispose();
    billingAddress1.dispose();
    billingAddress2.dispose();
    billingLandmark.dispose();
    billingCity.dispose();
    billingState.dispose();
    billingPincode.dispose();
    billingCountry.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddressProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
  widget.isEditing
      ? "Edit Address"
      : "Add Address",
),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),

        child: Column(
          children: [
            const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Shipping Address",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 20),

AddressForm(
  formKey: shippingFormKey,

  fullNameController: shippingName,
  phoneController: shippingPhone,
  address1Controller: shippingAddress1,
  address2Controller: shippingAddress2,
  landmarkController: shippingLandmark,
  cityController: shippingCity,
  stateController: shippingState,
  pincodeController: shippingPincode,
  countryController: shippingCountry,

  isDefault: shippingDefault,
  onDefaultChanged: (value) {
    setState(() {
      shippingDefault = value ?? false;
    });
  },
),

const SizedBox(height: 35),
BillingForm(
  sameAsShipping: billingSame,

  onChanged: (value) {
    setState(() {
      billingSame = value ?? true;
    });
  },

  formKey: billingFormKey,

  fullNameController: billingName,
  phoneController: billingPhone,
  address1Controller: billingAddress1,
  address2Controller: billingAddress2,
  landmarkController: billingLandmark,
  cityController: billingCity,
  stateController: billingState,
  pincodeController: billingPincode,
  countryController: billingCountry,

  isDefault: billingDefault,
  onDefaultChanged: (value) {
    setState(() {
      billingDefault = value ?? false;
    });
  },
),

const SizedBox(height: 35),

SaveAddressButton(
  provider: provider,

  isEditing: widget.isEditing,
addressId: widget.address?.id,

  shippingFormKey: shippingFormKey,
  billingFormKey: billingFormKey,

  billingSame: billingSame,

  shippingName: shippingName,
  shippingPhone: shippingPhone,
  shippingAddress1: shippingAddress1,
  shippingAddress2: shippingAddress2,
  shippingLandmark: shippingLandmark,
  shippingCity: shippingCity,
  shippingState: shippingState,
  shippingPincode: shippingPincode,
  shippingCountry: shippingCountry,
  shippingDefault: shippingDefault,

  billingName: billingName,
  billingPhone: billingPhone,
  billingAddress1: billingAddress1,
  billingAddress2: billingAddress2,
  billingLandmark: billingLandmark,
  billingCity: billingCity,
  billingState: billingState,
  billingPincode: billingPincode,
  billingCountry: billingCountry,
  billingDefault: billingDefault,
),
          ],
        ),
      ),
    );
  }
}