import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductActionMenu extends StatelessWidget {
  const ProductActionMenu({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case "view":
            break;

          case "edit":
            break;

          case "delete":
            break;
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: "view",
          child: Text("View"),
        ),
        PopupMenuItem(
          value: "edit",
          child: Text("Edit"),
        ),
        PopupMenuItem(
          value: "delete",
          child: Text("Delete"),
        ),
      ],
    );
  }
}