import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/basic_information_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/inventory_section.dart';
import '../widgets/image_upload_section.dart';
import '../widgets/variant_section.dart';
import '../widgets/seo_section.dart';
import '../widgets/publish_section.dart';

import '/providers/product_management_provider.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({
     super.key,
    this.productId,
  });

  final String? productId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductManagementProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Product"),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicInformationSection(),

              SizedBox(height: 30),

              PricingSection(),

              SizedBox(height: 30),

              InventorySection(),

              SizedBox(height: 30),

              ImageUploadSection(),

              SizedBox(height: 30),

              VariantSection(),

              SizedBox(height: 30),

              SeoSection(),

              SizedBox(height: 30),

              PublishSection(),
            ],
          ),
        ),
      ),
    );
  }
}