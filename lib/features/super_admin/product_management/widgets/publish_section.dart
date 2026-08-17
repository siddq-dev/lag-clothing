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

    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: isMobile
            ? _buildMobile(context, provider)
            : _buildDesktop(context, provider),
      ),
    );
  }

  // ================================================================
  // DESKTOP
  // ================================================================

  Widget _buildDesktop(
    BuildContext context,
    ProductManagementProvider provider,
  ) {
    return Row(
      children: [
        Expanded(
          child: SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "Product Active",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: const Text("Inactive products won't appear in the shop."),
            value: provider.form.status,
            onChanged: provider.updateStatus,
          ),
        ),

        const SizedBox(width: 20),

        _buildPublishButton(context, provider),
      ],
    );
  }

  // ================================================================
  // MOBILE
  // ================================================================

  Widget _buildMobile(
    BuildContext context,
    ProductManagementProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------------------------
        // ACTIVE SWITCH
        // ------------------------------------------------------------
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            "Product Active",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Text(
              "Inactive products won't appear in the shop.",
              style: TextStyle(fontSize: 13),
            ),
          ),
          value: provider.form.status,
          onChanged: provider.updateStatus,
        ),

        const SizedBox(height: 16),

        // ------------------------------------------------------------
        // PUBLISH BUTTON
        // ------------------------------------------------------------
        SizedBox(
          width: double.infinity,
          height: 50,
          child: _buildPublishButton(context, provider, expand: true),
        ),
      ],
    );
  }

  // ================================================================
  // PUBLISH / UPDATE BUTTON
  // ================================================================

  Widget _buildPublishButton(
    BuildContext context,
    ProductManagementProvider provider, {
    bool expand = false,
  }) {
    return FilledButton.icon(
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
          : Icon(
              provider.isEditing ? Icons.save_outlined : Icons.publish_outlined,
            ),
      label: Text(provider.isEditing ? "Update Product" : "Publish Product"),
      style: FilledButton.styleFrom(
        minimumSize: expand ? const Size(double.infinity, 50) : null,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
