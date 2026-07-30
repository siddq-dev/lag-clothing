import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../models/product_model.dart';
import '/providers/admin_product_provider.dart';
import '../../../../../routes/app_routes.dart';

class ProductActionButtons extends StatelessWidget {
  const ProductActionButtons({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<AdminProductProvider>();

    return Row(
      children: [

        Expanded(
          child: FilledButton.icon(
            icon: const Icon(Icons.edit),
            label: const Text("Edit Product"),
            onPressed: () {
              context.push(
                AppRouter.editProduct,
                extra: product,
              );
            },
          ),
        ),

        const SizedBox(width: 20),

        Expanded(
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            icon: const Icon(Icons.delete),
            label: const Text("Delete Product"),
            onPressed: provider.loading
                ? null
                : () async {

                    final confirm =
                        await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(
                            "Delete Product",
                          ),
                          content: const Text(
                            "Are you sure you want to delete this product?",
                          ),
                          actions: [

                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  false,
                                );
                              },
                              child: const Text(
                                "Cancel",
                              ),
                            ),

                            FilledButton(
                              style:
                                  FilledButton.styleFrom(
                                backgroundColor:
                                    Colors.red,
                              ),
                              onPressed: () {
                                Navigator.pop(
                                  context,
                                  true,
                                );
                              },
                              child: const Text(
                                "Delete",
                              ),
                            ),

                          ],
                        );
                      },
                    );

                    if (confirm != true) {
                      return;
                    }

                    await provider.deleteProduct(
                      product,
                    );

                    if (context.mounted) {
                      context.pop();
                    }
                  },
          ),
        ),

      ],
    );
  }
}