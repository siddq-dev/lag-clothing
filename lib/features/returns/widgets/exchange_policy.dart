import 'package:flutter/material.dart';

class ExchangePolicy extends StatelessWidget {
  const ExchangePolicy({super.key});

  Widget item(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(subtitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Exchange Policy",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 15),

            item(
              Icons.straighten,
              "Wrong Size?",
              "Exchange your jersey within 7 days if the size doesn't fit.",
            ),

            item(
              Icons.palette,
              "Wrong Color?",
              "Exchange is available if the requested color is in stock.",
            ),

            item(
              Icons.inventory,
              "Product Availability",
              "Exchanges depend on stock availability.",
            ),

            item(
              Icons.local_shipping,
              "Fast Processing",
              "Exchange requests are processed within 2 business days.",
            ),
          ],
        ),
      ),
    );
  }
}
