import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';
import '../widgets/legal_header.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.faq,
      child: Column(
        children: [
          const LegalHeader(
            title: "Frequently Asked Questions",
            subtitle:
                "Find answers to the most commonly asked questions about ordering, shipping, returns, and payments.",
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 80,
              vertical: 60,
            ),
            child: Column(
              children: const [

                ExpansionTile(
                  title: Text("How long does shipping take?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Orders are usually delivered within 3–7 business days depending on your location.",
                      ),
                    ),
                  ],
                ),

                Divider(),

                ExpansionTile(
                  title: Text("Can I cancel my order?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Orders can be cancelled before they are shipped.",
                      ),
                    ),
                  ],
                ),

                Divider(),

                ExpansionTile(
                  title: Text("Do you offer Cash on Delivery?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Yes. Cash on Delivery is available for eligible locations.",
                      ),
                    ),
                  ],
                ),

                Divider(),

                ExpansionTile(
                  title: Text("How do I return a product?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Visit the Returns page in your profile and submit a return request.",
                      ),
                    ),
                  ],
                ),

                Divider(),

                ExpansionTile(
                  title: Text("How do I track my order?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Go to My Orders → Track Order to view the latest delivery status.",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}