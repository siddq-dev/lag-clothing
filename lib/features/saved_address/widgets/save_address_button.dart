import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../models/address_model.dart';
import '../../../../providers/address_provider.dart';

class SaveAddressButton extends StatefulWidget {
  const SaveAddressButton({
    super.key,
    required this.provider,

    required this.shippingFormKey,
    required this.billingFormKey,

    required this.billingSame,

    required this.shippingName,
    required this.shippingPhone,
    required this.shippingAddress1,
    required this.shippingAddress2,
    required this.shippingLandmark,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingPincode,
    required this.shippingCountry,
    required this.shippingDefault,

    required this.billingName,
    required this.billingPhone,
    required this.billingAddress1,
    required this.billingAddress2,
    required this.billingLandmark,
    required this.billingCity,
    required this.billingState,
    required this.billingPincode,
    required this.billingCountry,
    required this.billingDefault,
  });

  final AddressProvider provider;

  final GlobalKey<FormState> shippingFormKey;
  final GlobalKey<FormState> billingFormKey;

  final bool billingSame;

  final TextEditingController shippingName;
  final TextEditingController shippingPhone;
  final TextEditingController shippingAddress1;
  final TextEditingController shippingAddress2;
  final TextEditingController shippingLandmark;
  final TextEditingController shippingCity;
  final TextEditingController shippingState;
  final TextEditingController shippingPincode;
  final TextEditingController shippingCountry;
  final bool shippingDefault;

  final TextEditingController billingName;
  final TextEditingController billingPhone;
  final TextEditingController billingAddress1;
  final TextEditingController billingAddress2;
  final TextEditingController billingLandmark;
  final TextEditingController billingCity;
  final TextEditingController billingState;
  final TextEditingController billingPincode;
  final TextEditingController billingCountry;
  final bool billingDefault;

  @override
  State<SaveAddressButton> createState() =>
      _SaveAddressButtonState();
}

class _SaveAddressButtonState extends State<SaveAddressButton> {
  bool loading = false;

  Future<void> saveAddress() async {
    if (!widget.shippingFormKey.currentState!.validate()) {
      return;
    }

    if (!widget.billingSame &&
        !widget.billingFormKey.currentState!.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      setState(() {
        loading = true;
      });

      final shippingAddress = AddressModel(
        id: '',
        userId: user.uid,
        fullName: widget.shippingName.text.trim(),
        phone: widget.shippingPhone.text.trim(),
        addressLine1: widget.shippingAddress1.text.trim(),
        addressLine2: widget.shippingAddress2.text.trim(),
        landmark: widget.shippingLandmark.text.trim(),
        city: widget.shippingCity.text.trim(),
        state: widget.shippingState.text.trim(),
        pincode: widget.shippingPincode.text.trim(),
        country: widget.shippingCountry.text.trim(),
        addressType: AddressType.home,
        purpose: AddressPurpose.shipping,
        isDefault: widget.shippingDefault,
        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      await widget.provider.addAddress(shippingAddress);

      if (widget.billingSame) {
        final billingAddress = shippingAddress.copyWith(
          addressType: shippingAddress.addressType,
          purpose: AddressPurpose.billing,
        );

        await widget.provider.addAddress(billingAddress);
      } else {
        final billingAddress = AddressModel(
          id: '',
          userId: user.uid,
          fullName: widget.billingName.text.trim(),
          phone: widget.billingPhone.text.trim(),
          addressLine1: widget.billingAddress1.text.trim(),
          addressLine2: widget.billingAddress2.text.trim(),
          landmark: widget.billingLandmark.text.trim(),
          city: widget.billingCity.text.trim(),
          state: widget.billingState.text.trim(),
          pincode: widget.billingPincode.text.trim(),
          country: widget.billingCountry.text.trim(),
          addressType: AddressType.home,
          purpose: AddressPurpose.billing,
          isDefault: widget.billingDefault,
          createdAt: Timestamp.now(),
          updatedAt: Timestamp.now(),
        );

        await widget.provider.addAddress(billingAddress);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Address saved successfully",
          ),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: loading ? null : saveAddress,
        child: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : const Text(
                "SAVE ADDRESS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}