import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/payment_method_model.dart';
import '../../../providers/payment_method_provider.dart';

import '../widgets/card_form.dart';
import '../widgets/save_payment_button.dart';

class AddPaymentMethodPage extends StatefulWidget {
  const AddPaymentMethodPage({
    super.key,
    this.paymentMethod,
    this.isEditing = false,
  });

  final PaymentMethodModel? paymentMethod;
  final bool isEditing;

  @override
  State<AddPaymentMethodPage> createState() => _AddPaymentMethodPageState();
}

class _AddPaymentMethodPageState extends State<AddPaymentMethodPage> {
  final formKey = GlobalKey<FormState>();

  final cardHolderController = TextEditingController();

  final cardNumberController = TextEditingController();

  final expiryMonthController = TextEditingController();

  final expiryYearController = TextEditingController();

  final cvvController = TextEditingController();

  bool isDefault = false;

  @override
  void initState() {
    super.initState();

    if (widget.isEditing && widget.paymentMethod != null) {
      final card = widget.paymentMethod!;

      cardHolderController.text = card.cardHolderName;

      cardNumberController.text = card.cardNumber;

      expiryMonthController.text = card.expiryMonth;

      expiryYearController.text = card.expiryYear;

      cvvController.text = card.cvv;

      isDefault = card.isDefault;
    }
  }

  @override
  void dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryMonthController.dispose();
    expiryYearController.dispose();
    cvvController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentMethodProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? "Edit Payment Method" : "Add Payment Method",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Card Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            CardForm(
              formKey: formKey,

              cardHolderController: cardHolderController,

              cardNumberController: cardNumberController,

              expiryMonthController: expiryMonthController,

              expiryYearController: expiryYearController,

              cvvController: cvvController,

              isDefault: isDefault,

              onDefaultChanged: (value) {
                setState(() {
                  isDefault = value ?? false;
                });
              },
            ),

            const SizedBox(height: 35),

            SavePaymentButton(
              provider: provider,

              formKey: formKey,

              cardHolderController: cardHolderController,

              cardNumberController: cardNumberController,

              expiryMonthController: expiryMonthController,

              expiryYearController: expiryYearController,

              cvvController: cvvController,

              isDefault: isDefault,

              isEditing: widget.isEditing,

              paymentId: widget.paymentMethod?.id,
            ),
          ],
        ),
      ),
    );
  }
}
