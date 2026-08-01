import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../layout/website_layout.dart';
import '../../../../providers/checkout_provider.dart';
import '../../../../routes/app_routes.dart';

import '../widgets/checkout_header/checkout_header.dart';
import '../widgets/delivery_address/delivery_address_card.dart';
import '../widgets/shipping_method/shipping_method_card.dart';
import '../widgets/payment_method/payment_method_card.dart';
import '../widgets/order_summary/checkout_order_summary.dart';
import '../widgets/terms_checkbox/terms_checkbox.dart';
import '../widgets/place_order_button/place_order_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() =>
      _CheckoutPageState();
}

class _CheckoutPageState
    extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CheckoutProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<CheckoutProvider>();

    if (provider.isLoading) {
      return const WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.error != null) {
      return WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(
          child: Text(provider.error!),
        ),
      );
    }

    final checkout = provider.checkout;

    if (checkout == null) {
      return const WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(
          child: Text("Checkout unavailable"),
        ),
      );
    }

    return WebsiteLayout(
      currentRoute: AppRouter.checkout,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 40,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1300,
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: const [
                      CheckoutHeader(),

                      SizedBox(height: 24),

                      DeliveryAddressCard(),

                      SizedBox(height: 24),

                      ShippingMethodCard(),

                      SizedBox(height: 24),

                      PaymentMethodCard(),

                      SizedBox(height: 24),

                      TermsCheckbox(),

                      SizedBox(height: 30),

                      PlaceOrderButton(),
                    ],
                  ),
                ),

                const SizedBox(width: 35),

                const Expanded(
                  flex: 3,
                  child: CheckoutOrderSummary(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}