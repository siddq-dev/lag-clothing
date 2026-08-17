import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../providers/payment_method_provider.dart';
import '../../../routes/app_routes.dart';

import '../widgets/payment_header.dart';
import '../widgets/add_payment_button.dart';
import '../widgets/payment_card.dart';
import '../widgets/empty_payment.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentMethodProvider>().listenPaymentMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentMethodProvider>();

    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  const PaymentHeader(),

                  const SizedBox(height: 30),

                  /// Add Card Button
                  AddPaymentButton(
                    onPressed: () {
                      context.push(AppRouter.addPaymentMethod);
                    },
                  ),

                  const SizedBox(height: 35),

                  if (provider.isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (provider.paymentMethods.isEmpty)
                    EmptyPayment(
                      onAddCard: () {
                        context.push(AppRouter.addPaymentMethod);
                      },
                    )
                  else
                    ...provider.paymentMethods.map(
                      (card) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: PaymentCard(
                          paymentMethod: card,

                          onEdit: () {
                            context.push(
                              AppRouter.editPaymentMethod,
                              extra: card,
                            );
                          },

                          onDelete: () async {
                            await provider.deletePaymentMethod(card.id);
                          },

                          onSetDefault: () async {
                            await provider.setDefaultPaymentMethod(card.id);
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
