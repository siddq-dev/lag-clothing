import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';

import '/providers/product_management_provider.dart';

class PublishSection extends StatelessWidget {
  const PublishSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: SwitchListTile(
                title: const Text("Product Active"),
                subtitle: const Text(
                  "Inactive products won't appear in the shop.",
                ),
                value: provider.form.status,
                onChanged: provider.updateStatus,
              ),
            ),

            const SizedBox(width: 20),

            FilledButton.icon(
              onPressed: provider.isLoading
                  ? null
                  : () async {
                      await provider.publishProduct();

                      if (!context.mounted) return;

                      if (provider.error == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              provider.isEditing
                                  ? "Product updated successfully."
                                  : "Product published successfully.",
                            ),
                          ),
                        );

                        context.go(AppRouter.manageProducts);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(provider.error!),
                          ),
                        );
                      }
                    },
              icon: provider.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Icon(provider.isEditing ? Icons.save : Icons.publish),
              label: Text(
                provider.isEditing ? "Update Product" : "Publish Product",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
