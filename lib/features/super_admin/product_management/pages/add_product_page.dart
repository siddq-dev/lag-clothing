import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';

import '/providers/product_management_provider.dart';

import '../widgets/basic_information_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/inventory_section.dart';
import '../widgets/image_upload_section.dart';
import '../widgets/variant_section.dart';
import '../widgets/seo_section.dart';
import '../widgets/publish_section.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key, this.productId});

  final String? productId;

  // ============================================================
  // BACK TO PRODUCT MANAGEMENT
  // ============================================================

  void _goBackToProducts(BuildContext context) {
    context.go(AppRouter.manageProducts);
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final isEditing = productId != null;

    return ChangeNotifierProvider(
      create: (_) {
        final provider = ProductManagementProvider();

        if (productId != null) {
          Future.microtask(() {
            provider.loadProduct(productId!);
          });
        }

        return provider;
      },

      child: Scaffold(
        backgroundColor: Colors.black,

        // ========================================================
        // APP BAR
        // ========================================================
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,

          leading: IconButton(
            tooltip: 'Back to Products',

            onPressed: () {
              _goBackToProducts(context);
            },

            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),

          title: Text(
            isEditing
                ? 'LAG Clothing • Edit Product'
                : 'LAG Clothing • Add Product',

            maxLines: 1,
            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          actions: const [],
        ),

        // ========================================================
        // BODY
        // ========================================================
        body: SafeArea(
          child: Theme(
            data: Theme.of(context).copyWith(
              scaffoldBackgroundColor: Colors.black,
              canvasColor: Colors.black,

              cardColor: const Color(0xFF1A1A1A),

              colorScheme: Theme.of(context).colorScheme.copyWith(
                surface: const Color(0xFF1A1A1A),
                onSurface: Colors.white,
              ),

              inputDecorationTheme: const InputDecorationTheme(
                filled: true,

                fillColor: Color(0xFF1A1A1A),

                labelStyle: TextStyle(color: Colors.white70),

                hintStyle: TextStyle(color: Colors.white54),

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),

              textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
            ),

            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.all(20),

              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // ==================================================
                      // BASIC INFORMATION
                      // ==================================================
                      const BasicInformationSection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // PRICING
                      // ==================================================
                      const PricingSection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // INVENTORY
                      // ==================================================
                      const InventorySection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // IMAGES
                      // ==================================================
                      const ImageUploadSection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // VARIANTS
                      // ==================================================
                      const VariantSection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // SEO
                      // ==================================================
                      const SeoSection(),

                      const SizedBox(height: 30),

                      // ==================================================
                      // PUBLISH
                      // ==================================================
                      const PublishSection(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
