import 'package:flutter/material.dart';

class ProductSeoSection extends StatelessWidget {
  const ProductSeoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          children: [

            TextFormField(
              decoration:
                  const InputDecoration(
                labelText:
                    "Meta Title",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              maxLines: 3,
              decoration:
                  const InputDecoration(
                labelText:
                    "Meta Description",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              decoration:
                  const InputDecoration(
                labelText:
                    "Keywords",
                hintText:
                    "football, jersey, adidas",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              decoration:
                  const InputDecoration(
                labelText:
                    "Hashtags",
                hintText:
                    "#jersey #football",
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextFormField(
              decoration:
                  const InputDecoration(
                labelText: "Slug",
                hintText:
                    "manchester-united-home-jersey",
              ),
            ),

          ],
        ),
      ),
    );
  }
}