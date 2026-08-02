import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/product_variant_model.dart';
import '/providers/product_management_provider.dart';

class VariantSection extends StatelessWidget {
  const VariantSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductManagementProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Product Variants",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                provider.addVariant(
                  ProductVariantModel(
                    id: DateTime.now()
                        .millisecondsSinceEpoch
                        .toString(),
                    size: "M",
                    color: "Black",
                    stock: 0,
                    sku: '',
                    available: true,
                    additionalPrice: 0,
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text("Add Variant"),
            ),

            const SizedBox(height: 25),

            if (provider.form.variants.isEmpty)
              const Text(
                "No variants added.",
              ),

            if (provider.form.variants.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount:
                    provider.form.variants.length,
                itemBuilder: (context, index) {
                  final variant =
                      provider.form.variants[index];

                  return Card(
                    margin:
                        const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(15),
                      child: Column(
                        children: [

                          Row(
                            children: [

                              Expanded(
                                child:
                                    DropdownButtonFormField<String>(
                                  value: variant.size,
                                  items: const [
                                    DropdownMenuItem(
                                      value: "S",
                                      child: Text("S"),
                                    ),
                                    DropdownMenuItem(
                                      value: "M",
                                      child: Text("M"),
                                    ),
                                    DropdownMenuItem(
                                      value: "L",
                                      child: Text("L"),
                                    ),
                                    DropdownMenuItem(
                                      value: "XL",
                                      child: Text("XL"),
                                    ),
                                    DropdownMenuItem(
                                      value: "XXL",
                                      child: Text("XXL"),
                                    ),
                                  ],
                                  onChanged: (value) {
  if (value != null) {
    provider.updateVariantSize(
      variant,
      value,
    );
  }
},
                                  decoration:
                                      const InputDecoration(
                                    labelText: "Size",
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: TextFormField(
  initialValue: variant.color,
  onChanged: (value) {
    provider.updateVariantColor(
      variant,
      value,
    );
  },
)
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [

                              Expanded(
                                child: TextFormField(
  initialValue: variant.stock.toString(),
  keyboardType: TextInputType.number,
  onChanged: (value) {
    provider.updateVariantStock(
      variant,
      value,
    );
  },
)
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: TextFormField(
  initialValue:
      variant.additionalPrice.toString(),
  keyboardType: TextInputType.number,
  onChanged: (value) {
    provider.updateVariantPrice(
      variant,
      value,
    );
  },
)
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          Align(
                            alignment:
                                Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                provider.removeVariant(
                                  variant,
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              label: const Text(
                                "Remove",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}