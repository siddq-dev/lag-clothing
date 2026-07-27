import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/address_provider.dart';

import '../widgets/address_form.dart';
import '../widgets/billing_form.dart';
import '../widgets/save_address_button.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

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
        title: const Text("Add Address"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),

        child: Column(
          children: [