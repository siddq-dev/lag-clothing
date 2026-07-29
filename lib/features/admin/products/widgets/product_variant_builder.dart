import 'package:flutter/material.dart';

class ProductVariantBuilder extends StatefulWidget {
  const ProductVariantBuilder({
    super.key,
  });

  @override
  State<ProductVariantBuilder> createState() =>
      _ProductVariantBuilderState();
}

class _ProductVariantBuilderState
    extends State<ProductVariantBuilder> {

  final List<Map<String, dynamic>>
      variants = [];

  void addVariant() {

    setState(() {

      variants.add({
        "size": "",
        "color": "",
        "sku": "",
        "stock": 0,
      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Card(

      child: Padding(

        padding: const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(

              children: [

                const Expanded(

                  child: Text(
                    "Variants",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),

                ElevatedButton(

                  onPressed: addVariant,

                  child: const Text(
                    "Add Variant",
                  ),

                ),

              ],

            ),

            const SizedBox(height: 20),

            ...variants.asMap().entries.map(

              (entry) {

                final index = entry.key;

                return Card(

                  margin:
                      const EdgeInsets.only(
                    bottom: 20,
                  ),

                  child: Padding(

                    padding:
                        const EdgeInsets.all(
                      16,
                    ),

                    child: Column(

                      children: [

                        TextFormField(
                          decoration:
                              const InputDecoration(
                            labelText:
                                "Size",
                          ),
                          onChanged: (value) {
                            variants[index]
                                    ["size"] =
                                value;
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration:
                              const InputDecoration(
                            labelText:
                                "Color",
                          ),
                          onChanged: (value) {
                            variants[index]
                                    ["color"] =
                                value;
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          decoration:
                              const InputDecoration(
                            labelText:
                                "SKU",
                          ),
                          onChanged: (value) {
                            variants[index]
                                    ["sku"] =
                                value;
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          keyboardType:
                              TextInputType.number,
                          decoration:
                              const InputDecoration(
                            labelText:
                                "Stock",
                          ),
                          onChanged: (value) {

                            variants[index]
                                    ["stock"] =
                                int.tryParse(
                                      value,
                                    ) ??
                                    0;

                          },
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