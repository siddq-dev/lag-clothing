import 'package:flutter/material.dart';

class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  Widget policyTile(
    IconData icon,
    String title,
    String description,
  ) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Return Policy",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            policyTile(
              Icons.calendar_today,
              "7-Day Return",
              "Returns are accepted within 7 days of delivery.",
            ),

            policyTile(
              Icons.check_circle_outline,
              "Unused Products",
              "Products must be unused with original tags and packaging.",
            ),

            policyTile(
              Icons.cancel_outlined,
              "Non-Returnable",
              "Customized jerseys cannot be returned unless damaged.",
            ),

          ],
        ),
      ),
    );
  }
}