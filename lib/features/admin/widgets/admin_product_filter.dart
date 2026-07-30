import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/providers/admin_product_filter_provider.dart';

class AdminProductFilter extends StatefulWidget {
  const AdminProductFilter({
    super.key,
  });

  @override
  State<AdminProductFilter> createState() =>
      _AdminProductFilterState();
}

class _AdminProductFilterState
    extends State<AdminProductFilter> {


  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<AdminProductFilterProvider>();
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Filters",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [

                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<String>(
                    value: provider.category,
                    decoration: const InputDecoration(
                      labelText: "Category",
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Sports",
                        child: Text("Sports"),
                      ),
                      DropdownMenuItem(
                        value: "Casual",
                        child: Text("Casual"),
                      ),
                    ],
                  onChanged: (value) {
  provider.updateCategory(value);
},
                  ),
                ),

                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<String>(
                    value: provider.brand,
                    decoration: const InputDecoration(
                      labelText: "Brand",
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "Nike",
                        child: Text("Nike"),
                      ),
                      DropdownMenuItem(
                        value: "Puma",
                        child: Text("Puma"),
                      ),
                    ],
                   onChanged: (value) {
  provider.updateBrand(value);
},
                  ),
                ),

                SizedBox(
                  width: 220,
                  child: DropdownButtonFormField<String>(
                    value: provider.status,
                    decoration: const InputDecoration(
                      labelText: "Status",
                    ),
                    items: const [

                      DropdownMenuItem(
                        value: "active",
                        child: Text("Active"),
                      ),

                      DropdownMenuItem(
                        value: "inactive",
                        child: Text("Inactive"),
                      ),

                    ],
                  onChanged: (value) {
  provider.updateCategory(value);
},
                  ),
                ),

              ],
            ),

            const SizedBox(height: 25),

            Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [

                FilterChip(
                  label: const Text("Featured"),
                  selected: provider.featured,
                 onSelected: provider.toggleFeatured,
                ),

                FilterChip(
                  label: const Text("Best Seller"),
                  selected: provider.bestSeller,
                  onSelected: provider.toggleBestSeller,
                ),

                FilterChip(
                  label: const Text("New Arrival"),
                  selected: provider.newArrival,
                  onSelected: provider.toggleNewArrival,
                ),

                FilterChip(
                  label: const Text("Low Stock"),
                  selected: provider.lowStock,
                 onSelected: provider.toggleLowStock,
                ),

                FilterChip(
                  label: const Text("Out of Stock"),
                  selected: provider.outOfStock,
                  onSelected: provider.toggleOutOfStock,
                ),

              ],
            ),

            const SizedBox(height: 25),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: () {
  Navigator.pop(context);
},
                icon: const Icon(Icons.filter_alt),
                label: const Text("Apply Filters"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}