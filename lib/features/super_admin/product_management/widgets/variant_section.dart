import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_management_provider.dart';
import '../../../../models/product_color_variant_model.dart';

class VariantSection extends StatelessWidget {
  const VariantSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Variants",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: FilledButton.icon(
                onPressed: provider.addColorVariant,
                icon: const Icon(Icons.add),
                label: const Text("Add Color"),
              ),
            ),

            const SizedBox(height: 25),

            if (provider.colorVariants.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    "No Color Variants Added",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ),

            ...provider.colorVariants.map(
              (color) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _ColorCard(color: color),
              ),
            ),

            if (provider.colorVariants.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Total Stock : ${provider.totalStock}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ColorCard extends StatelessWidget {
  final ProductColorVariantModel color;

  const _ColorCard({required this.color});

  String? _getSkuError(String? providerError, String sku) {
    if (providerError == null) return null;
    final trimmedSku = sku.trim();

    // 1. Blank SKU error on save attempt
    if (trimmedSku.isEmpty && providerError.contains("SKU is required")) {
      return "SKU is required";
    }

    // 2. Duplicate SKU error
    if (trimmedSku.isNotEmpty &&
        providerError.contains("Duplicate SKU") &&
        providerError.contains(trimmedSku)) {
      return "Duplicate SKU found";
    }

    // 3. SKU already exists in database
    if (trimmedSku.isNotEmpty &&
        providerError.contains("already exists") &&
        providerError.contains(trimmedSku)) {
      return "SKU already exists";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductManagementProvider>();

    return Card(
      elevation: 0,
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: color.color.isEmpty ? null : color.color,
              decoration: const InputDecoration(
                labelText: "Select Color",
                border: OutlineInputBorder(),
              ),
              items:
                  const [
                    "Black",
                    "White",
                    "Blue",
                    "Red",
                    "Green",
                    "Yellow",
                    "Grey",
                    "Brown",
                    "Orange",
                    "Purple",
                  ].map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  provider.updateColorName(color, value);
                }
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Select Sizes",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: provider.availableSizes.map((size) {
                final selected = color.variants.any((v) => v.size == size);

                return FilterChip(
                  selectedColor: Colors.red,
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selected ? Colors.white : Colors.white70,
                  ),
                  selected: selected,
                  label: Text(size),
                  onSelected: (_) {
                    provider.toggleSizeForColor(color, size);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            const Divider(),

            const SizedBox(height: 15),

            if (color.variants.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "No sizes selected.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

            ...color.variants.map((variant) {
              final skuError = _getSkuError(provider.error, variant.sku);

              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 45,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          variant.size,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        initialValue: variant.sku,
                        decoration: InputDecoration(
                          labelText: "SKU",
                          errorText: skuError,
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        onChanged: (value) {
                          provider.updateSkuForColorSize(color, variant, value);
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: TextFormField(
                        initialValue: variant.stock == 0
                            ? ""
                            : variant.stock.toString(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Stock",
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        onChanged: (value) {
                          provider.updateStockForColorSize(
                            color,
                            variant,
                            value,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  provider.removeColorVariant(color);
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text("Remove Color"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
