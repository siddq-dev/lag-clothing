import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/legal_bullet.dart';
import '../widgets/legal_header.dart';
import '../widgets/legal_section.dart';

class ShippingPolicyPage extends StatelessWidget {
  const ShippingPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.shippingPolicy,
      child: Column(
        children: [
          const LegalHeader(
            title: "Shipping Policy",
            subtitle:
                "Learn about our shipping process, delivery timelines, and order tracking.",
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LegalSection(
                  heading: "Processing Time",
                  body:
                      "Orders are processed within 24–48 hours after successful payment confirmation.",
                ),

                LegalSection(
                  heading: "Delivery Time",
                  body:
                      "Standard delivery usually takes between 3–7 business days across India.",
                ),

                LegalSection(
                  heading: "Shipping Charges",
                  body:
                      "Shipping charges are calculated during checkout based on your location and order value.",
                ),

                LegalSection(
                  heading: "Order Tracking",
                  body:
                      "Once your order has been shipped, a tracking ID will be shared via email and SMS.",
                ),

                LegalSection(heading: "Shipping Highlights", body: ""),

                LegalBullet(
                  text: "Orders are packed securely to prevent damage.",
                ),

                LegalBullet(text: "Delivery partners vary based on location."),

                LegalBullet(
                  text: "Tracking details become available after dispatch.",
                ),

                LegalBullet(
                  text: "Customers will receive delivery notifications.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
