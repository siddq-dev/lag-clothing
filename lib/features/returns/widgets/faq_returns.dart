import 'package:flutter/material.dart';

class FAQReturns extends StatelessWidget {
  const FAQReturns({super.key});

  Widget faq(
    String question,
    String answer,
  ) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [

        Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            0,
            20,
            20,
          ),
          child: Text(
            answer,
            style: const TextStyle(
              height: 1.6,
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            faq(
              "How long do refunds take?",
              "Refunds are usually processed within 5–7 business days after the returned item has been inspected.",
            ),

            faq(
              "Can I exchange for another size?",
              "Yes. Size exchanges are available within the return period, subject to stock availability.",
            ),

            faq(
              "Can customized jerseys be returned?",
              "Customized jerseys are only eligible for return if they are defective or damaged upon delivery.",
            ),

            faq(
              "Who pays the return shipping cost?",
              "If the return is due to our mistake or a damaged product, we cover the return shipping cost. Otherwise, the customer may be responsible for shipping charges.",
            ),

          ],
        ),
      ),
    );
  }
}