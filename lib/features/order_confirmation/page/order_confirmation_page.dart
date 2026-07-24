import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/confirmation_header/confirmation_header.dart';
import '../widgets/confirmation_details/confirmation_details.dart';
import '../widgets/shipping_address/shipping_address.dart';
import '../widgets/support_section/support_section.dart';
import '../widgets/confirmation_actions/confirmation_actions.dart';

class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
  currentRoute: AppRouter.checkout,
  child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 50,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 900,
            ),
            child: Column(
              children: const [

                ConfirmationHeader(),

                SizedBox(height: 30),

                ConfirmationDetails(),

                SizedBox(height: 30),

                ShippingAddress(),

                SizedBox(height: 30),

                SupportSection(),

                SizedBox(height: 40),

                ConfirmationActions(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}