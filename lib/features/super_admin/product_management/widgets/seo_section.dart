import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_management_provider.dart';

class SeoSection extends StatefulWidget {
  const SeoSection({super.key});

  @override
  State<SeoSection> createState() => _SeoSectionState();
}

class _SeoSectionState extends State<SeoSection> {
  late final TextEditingController _seoTitleController;
  late final TextEditingController _metaDescriptionController;
  late final TextEditingController _slugController;

  @override
  void initState() {
    super.initState();

    final provider = context.read<ProductManagementProvider>();

    _seoTitleController = TextEditingController(
      text: provider.form.seo.seoTitle,
    );

    _metaDescriptionController = TextEditingController(
      text: provider.form.seo.metaDescription,
    );

    _slugController = TextEditingController(
      text: provider.form.seo.slug,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final provider = context.read<ProductManagementProvider>();

    _seoTitleController.text = provider.form.seo.seoTitle;
    _metaDescriptionController.text =
        provider.form.seo.metaDescription;
    _slugController.text = provider.form.seo.slug;
  }

  @override
  void dispose() {
    _seoTitleController.dispose();
    _metaDescriptionController.dispose();
    _slugController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final provider = context.watch<ProductManagementProvider>();

  if (_seoTitleController.text != provider.form.seo.seoTitle) {
    _seoTitleController.text = provider.form.seo.seoTitle;
  }

  if (_metaDescriptionController.text !=
      provider.form.seo.metaDescription) {
    _metaDescriptionController.text =
        provider.form.seo.metaDescription;
  }

  if (_slugController.text != provider.form.seo.slug) {
    _slugController.text = provider.form.seo.slug;
  }

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SEO Settings",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          TextFormField(
            controller: _seoTitleController,
            decoration: const InputDecoration(
              labelText: "SEO Title",
              border: OutlineInputBorder(),
            ),
            onChanged: provider.updateSeoTitle,
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _metaDescriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Meta Description",
              border: OutlineInputBorder(),
            ),
            onChanged: provider.updateMetaDescription,
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _slugController,
            decoration: const InputDecoration(
              labelText: "URL Slug",
              hintText: "football-jersey-2026",
              border: OutlineInputBorder(),
            ),
            onChanged: provider.updateSlug,
          ),

          const SizedBox(height: 25),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Google Preview",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Text(
                  provider.form.seo.seoTitle.isEmpty
                      ? "Product Title"
                      : provider.form.seo.seoTitle,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  "https://lagclothing.com/${provider.form.seo.slug}",
                  style: const TextStyle(color: Colors.green),
                ),

                const SizedBox(height: 8),

                Text(
                  provider.form.seo.metaDescription.isEmpty
                      ? "Meta description will appear here."
                      : provider.form.seo.metaDescription,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}