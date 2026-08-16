import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../layout/website_layout.dart';
import '../../../../providers/checkout_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

import '../widgets/checkout_header/checkout_header.dart';
import '../widgets/checkout_product_list/checkout_product_list.dart';
import '../widgets/checkout_address_form/checkout_address_form.dart';
import '../widgets/payment_method/payment_method_card.dart';
import '../widgets/order_summary/checkout_order_summary.dart';
import '../widgets/place_order_button/place_order_button.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<CheckoutProvider>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CheckoutProvider>();

    if (provider.isLoading && provider.checkout == null) {
      return const WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.error != null && provider.checkout == null) {
      return WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 20),
                Text(provider.error!, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: provider.initialize,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final checkout = provider.checkout;

    if (checkout == null) {
      return const WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(child: Text('Checkout unavailable')),
      );
    }

    if (checkout.cartItems.isEmpty) {
      return const WebsiteLayout(
        currentRoute: AppRouter.checkout,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Text('Your cart is empty.', style: TextStyle(fontSize: 20)),
          ),
        ),
      );
    }

    return WebsiteLayout(
      currentRoute: AppRouter.checkout,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CheckoutHeader(),

                const SizedBox(height: AppSpacing.xl),

                const CheckoutSectionTitle(
                  title: 'Products',
                  icon: Icons.shopping_bag_outlined,
                ),

                const SizedBox(height: AppSpacing.md),

                const CheckoutProductList(),

                const SizedBox(height: 30),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CheckoutSectionTitle(
                            title: 'Shipping Address',
                            icon: Icons.local_shipping_outlined,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          const CheckoutAddressForm(
                            purpose: CheckoutAddressPurpose.shipping,
                          ),

                          const SizedBox(height: 30),

                          const CheckoutSectionTitle(
                            title: 'Billing Address',
                            icon: Icons.receipt_long_outlined,
                          ),

                          const SizedBox(height: AppSpacing.md),

                          const CheckoutAddressForm(
                            purpose: CheckoutAddressPurpose.billing,
                          ),

                          const SizedBox(height: 30),

                          const PaymentMethodCard(),

                          const SizedBox(height: 30),

                          const PlaceOrderButton(),
                        ],
                      ),
                    ),

                    const SizedBox(width: 35),

                    const Expanded(flex: 3, child: CheckoutOrderSummary()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// SECTION TITLE
// ================================================================

class CheckoutSectionTitle extends StatelessWidget {
  const CheckoutSectionTitle({
    super.key,
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(title, style: AppTextStyles.heading3),
      ],
    );
  }
}
