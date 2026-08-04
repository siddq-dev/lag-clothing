import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_management_provider.dart';
import 'category_filter.dart';

class BasicInformationSection extends StatefulWidget {
  const BasicInformationSection({super.key});

  @override
  State<BasicInformationSection> createState() =>
      _BasicInformationSectionState();
}

class _BasicInformationSectionState
    extends State<BasicInformationSection> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _brandController;
  late final TextEditingController _subCategoryController;

  @override
  void initState() {
    super.initState();

    final provider =
        context.read<ProductManagementProvider>();

    _nameController = TextEditingController(
      text: provider.form.name,
    );

    _descriptionController =
        TextEditingController(
      text: provider.form.description,
    );

    _brandController = TextEditingController(
      text: provider.form.brand,
    );

    _subCategoryController =
        TextEditingController(
      text: provider.form.subCategory,
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   final provider =
  //       context.read<ProductManagementProvider>();

  //   _nameController.text = provider.form.name;
  //   _descriptionController.text =
  //       provider.form.description;
  //   _brandController.text = provider.form.brand;
  //   _subCategoryController.text =
  //       provider.form.subCategory;
  // }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _subCategoryController.dispose();

    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  final provider = context.watch<ProductManagementProvider>();

  // Sync controllers after loadProduct()
  if (_nameController.text != provider.form.name) {
    _nameController.value = TextEditingValue(
      text: provider.form.name,
      selection: TextSelection.collapsed(
        offset: provider.form.name.length,
      ),
    );
  }

  if (_descriptionController.text != provider.form.description) {
    _descriptionController.value = TextEditingValue(
      text: provider.form.description,
      selection: TextSelection.collapsed(
        offset: provider.form.description.length,
      ),
    );
  }

  if (_brandController.text != provider.form.brand) {
    _brandController.value = TextEditingValue(
      text: provider.form.brand,
      selection: TextSelection.collapsed(
        offset: provider.form.brand.length,
      ),
    );
  }

  if (_subCategoryController.text != provider.form.subCategory) {
    _subCategoryController.value = TextEditingValue(
      text: provider.form.subCategory,
      selection: TextSelection.collapsed(
        offset: provider.form.subCategory.length,
      ),
    );
  }

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Basic Information",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          TextFormField(
            controller: _nameController,
            onChanged: provider.updateName,
            decoration: const InputDecoration(
              labelText: "Product Name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _descriptionController,
            maxLines: 5,
            onChanged: provider.updateDescription,
            decoration: const InputDecoration(
              labelText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _brandController,
            onChanged: provider.updateBrand,
            decoration: const InputDecoration(
              labelText: "Brand",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          CategoryFilter(
            value: provider.form.category,
            onChanged: (value) {
              if (value != null) {
                provider.updateCategory(value);
              }
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: _subCategoryController,
            onChanged: provider.updateSubCategory,
            decoration: const InputDecoration(
              labelText: "Sub Category",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Visibility",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          SwitchListTile(
            title: const Text("Featured"),
            value: provider.form.featured,
            onChanged: provider.updateFeatured,
          ),

          SwitchListTile(
            title: const Text("Best Seller"),
            value: provider.form.bestSeller,
            onChanged: provider.updateBestSeller,
          ),

          SwitchListTile(
            title: const Text("New Arrival"),
            value: provider.form.newArrival,
            onChanged: provider.updateNewArrival,
          ),

          SwitchListTile(
            title: const Text("Product Active"),
            value: provider.form.status,
            onChanged: provider.updateStatus,
          ),
        ],
      ),
    ),
  );
}
}