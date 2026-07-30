import 'package:flutter/material.dart';

import '../../../../../models/product_seo_model.dart';

class ProductSeoPreview extends StatelessWidget {
  const ProductSeoPreview({
    super.key,
    required this.seo,
  });

  final ProductSeoModel seo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            Text(
              "SEO Information",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            _buildItem(
              "Slug",
              seo.slug.isEmpty
                  ? "-"
                  : seo.slug,
            ),

            const Divider(),

            _buildItem(
              "Meta Title",
              seo.seoTitle.isEmpty
                  ? "-"
                  : seo.seoTitle,
            ),

            const Divider(),

            _buildItem(
              "Meta Description",
              seo.metaDescription.isEmpty
                  ? "-"
                  : seo.metaDescription,
            ),

            const Divider(),

            _buildItem(
              "Keywords",
              seo.keywords.isEmpty
                  ? "-"
                  : seo.keywords.join(", "),
            ),

            _buildItem(
  "Hashtags",
  seo.hashtags.isEmpty
      ? "-"
      : seo.hashtags.join(", "),
),

const Divider(),

_buildItem(
  "Search Tags",
  seo.searchTags.isEmpty
      ? "-"
      : seo.searchTags.join(", "),
),

const Divider(),

_buildItem(
  "Open Graph Image",
  seo.openGraphImage.isEmpty
      ? "-"
      : seo.openGraphImage,
),

          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          SelectableText(value),

        ],
      ),
    );
  }
}