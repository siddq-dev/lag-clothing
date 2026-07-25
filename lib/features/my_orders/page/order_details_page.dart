import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../themes/app_spacing.dart';

import '../widgets/order_summary_card.dart';
import '../widgets/shipping_address_card.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/invoice_download_button.dart';
import '../widgets/reorder_button.dart';
import '../widgets/cancel_order_button.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            OrderSummaryCard(),

            SizedBox(height: AppSpacing.xxxl),

            ShippingAddressCard(),

            SizedBox(height: AppSpacing.xxxl),

            PaymentSummaryCard(),

            SizedBox(height: AppSpacing.xxxl),

            InvoiceDownloadButton(),

            SizedBox(height: 20),

            ReorderButton(),

            SizedBox(height: 20),

            CancelOrderButton(),
          ],
        ),
      ),
    );
  }
}
