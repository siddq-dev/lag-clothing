import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/payment_method_model.dart';
import '../../../providers/payment_method_provider.dart';

class SavePaymentButton extends StatefulWidget {
  const SavePaymentButton({
    super.key,
    required this.provider,
    required this.formKey,

    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryMonthController,
    required this.expiryYearController,
    required this.cvvController,

    required this.isDefault,

    this.isEditing = false,
    this.paymentId,
  });

  final PaymentMethodProvider provider;

  final GlobalKey<FormState> formKey;

  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryMonthController;
  final TextEditingController expiryYearController;
  final TextEditingController cvvController;

  final bool isDefault;

  final bool isEditing;
  final String? paymentId;

  @override
  State<SavePaymentButton> createState() =>
      _SavePaymentButtonState();
}

class _SavePaymentButtonState
    extends State<SavePaymentButton> {
  bool loading = false;

  Future<void> saveCard() async {
    if (!widget.formKey.currentState!.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    try {
      setState(() {
        loading = true;
      });

      final number = widget.cardNumberController.text
          .replaceAll(" ", "");

      final card = PaymentMethodModel(
        id: '',
        userId: user.uid,

        cardHolderName:
            widget.cardHolderController.text.trim(),

        cardNumber: number,

        last4Digits:
            number.substring(number.length - 4),

        expiryMonth:
            widget.expiryMonthController.text.trim(),

        expiryYear:
            widget.expiryYearController.text.trim(),

        cvv:
            widget.cvvController.text.trim(),

        cardBrand: _detectCardBrand(number),

        isDefault: widget.isDefault,

        createdAt: Timestamp.now(),
        updatedAt: Timestamp.now(),
      );

      if (widget.isEditing) {
        await widget.provider.updatePaymentMethod(
          card.copyWith(
            id: widget.paymentId!,
          ),
        );
      } else {
        await widget.provider.addPaymentMethod(card);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? "Payment method updated"
                : "Payment method added",
          ),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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

  String _detectCardBrand(String number) {
    if (number.startsWith('4')) {
      return 'Visa';
    }

    if (number.startsWith('5')) {
      return 'MasterCard';
    }

    if (number.startsWith('34') ||
        number.startsWith('37')) {
      return 'American Express';
    }

    if (number.startsWith('6')) {
      return 'Discover';
    }

    return 'Card';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: loading ? null : saveCard,
        child: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : Text(
                widget.isEditing
                    ? "UPDATE CARD"
                    : "SAVE CARD",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}