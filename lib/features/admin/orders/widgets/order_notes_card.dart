import 'package:flutter/material.dart';

class OrderNotesCard extends StatelessWidget {
  const OrderNotesCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Admin Notes",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              maxLines: 5,

              decoration: InputDecoration(
                hintText:
                    "Write internal notes...",
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: () {},

              child: const Text(
                "Save Notes",
              ),
            ),

          ],
        ),
      ),
    );
  }
}