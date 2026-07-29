import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../../../../models/product_model.dart';

import '../../../../models/product_form_model.dart';

import '../widgets/product_basic_information.dart';
import '../widgets/product_category.dart';
import '../widgets/product_pricing.dart';
import '../widgets/product_inventory.dart';
import '../widgets/product_status_section.dart';
import '../widgets/product_image_upload.dart';
import '../widgets/product_variant_builder.dart';
import '../widgets/product_seo_section.dart';
import '../widgets/save_product_button.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  State<EditProductPage> createState() =>
      _EditProductPageState();
}

class _EditProductPageState
    extends State<EditProductPage> {

  late ProductFormModel form;
  final List<Uint8List> selectedImages = [];

  @override
  void initState() {
    super.initState();

    form = ProductFormModel()
      ..name = widget.product.name
      ..description = widget.product.description
      ..brand = widget.product.brand
      ..category = widget.product.category
      ..subCategory = widget.product.subCategory
      ..price = widget.product.price
      ..salePrice = widget.product.salePrice
      ..stock = widget.product.stock
      ..featured = widget.product.featured
      ..bestSeller = widget.product.bestSeller
      ..newArrival = widget.product.newArrival
      ..status = widget.product.status
      ..images = widget.product.images
      ..variants = widget.product.variants
      ..seo = widget.product.seo;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Edit Product",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(30),

        child: Column(

          children: [

            ProductBasicInformation(
              form: form,
            ),

            const SizedBox(height: 30),

            ProductCategory(
              form: form,
            ),

            const SizedBox(height: 30),

            ProductPricing(
              form: form,
            ),

            const SizedBox(height: 30),

            ProductInventory(
              form: form,
            ),

            const SizedBox(height: 30),

          ProductImageUpload(
  onImagesSelected: (images) {
    selectedImages
      ..clear()
      ..addAll(images);
  },
),

            const SizedBox(height: 30),

            ProductVariantBuilder(),

            const SizedBox(height: 30),

            ProductSeoSection(),

            const SizedBox(height: 30),

            ProductStatusSection(
              form: form,
            ),

            const SizedBox(height: 40),

            SaveProductButton(
              form: form,
              images: selectedImages,
              
            ),

          ],

        ),

      ),

    );

  }
}