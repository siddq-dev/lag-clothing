import 'package:flutter/material.dart';
import 'dart:typed_data';

import '../../../../models/product_form_model.dart';

import '../widgets/product_basic_information.dart';
import '../widgets/product_category.dart';
import '../widgets/product_pricing.dart';
import '../widgets/product_inventory.dart';
import '../widgets/product_status_section.dart';
import '../widgets/save_product_button.dart';
import '../widgets/product_image_upload.dart';
import '../widgets/product_variant_builder.dart';
import '../widgets/product_seo_section.dart';


class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key, String? productId});

  @override
  State<AddProductPage> createState() =>
      _AddProductPageState();
}

class _AddProductPageState
    extends State<AddProductPage> {

  final ProductFormModel form =
      ProductFormModel();
      final List<Uint8List> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
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

            ProductStatusSection(
              form: form,
            ),

            const SizedBox(height: 40),
            
           ProductImageUpload(
  onImagesSelected: (images) {
    selectedImages.clear();
    selectedImages.addAll(images);
  },
),

const SizedBox(height: 30),

const ProductVariantBuilder(),

const SizedBox(height: 30),

const ProductSeoSection(),

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