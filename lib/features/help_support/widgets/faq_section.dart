import 'package:flutter/material.dart';

import '../../../themes/app_text_style.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        "question": "How do I track my order?",
        "answer":
            "Go to My Orders from your profile to view your order status and tracking details.",
      },
      {
        "question": "How can I return a jersey?",
        "answer":
            "Returns can be requested within 7 days after delivery if the product is unused.",
      },
      {
        "question": "What payment methods are accepted?",
        "answer": "We accept UPI, Debit/Credit Cards, Net Banking and Wallets.",
      },
      {
        "question": "How do I change my delivery address?",
        "answer":
            "Open Saved Addresses in your profile and edit or add a new address.",
      },
      {
        "question": "How long does delivery take?",
        "answer":
            "Most orders are delivered within 3–7 business days depending on your location.",
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Frequently Asked Questions", style: AppTextStyles.heading3),

        const SizedBox(height: 20),

        ...faqs.map(
          (faq) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Text(faq["question"]!),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(faq["answer"]!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
