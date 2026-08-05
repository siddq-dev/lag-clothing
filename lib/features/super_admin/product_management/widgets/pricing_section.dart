import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/product_management_provider.dart';

class PricingSection extends StatefulWidget {
  const PricingSection({super.key});

  @override
  State<PricingSection> createState() =>
      _PricingSectionState();
}

class _PricingSectionState
    extends State<PricingSection> {
  late final TextEditingController _priceController;
  late final TextEditingController _salePriceController;

  @override
  void initState() {
    super.initState();

    final provider =
        context.read<ProductManagementProvider>();

    _priceController = TextEditingController(
      text: provider.form.price == 0
          ? ""
          : provider.form.price.toString(),
    );

    _salePriceController =
        TextEditingController(
      text: provider.form.salePrice == 0
          ? ""
          : provider.form.salePrice.toString(),
    );
  }

 

  @override
  void dispose() {
    _priceController.dispose();
    _salePriceController.dispose();

    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final provider = context.watch<ProductManagementProvider>();

  if (_priceController.text !=
      (provider.form.price == 0
          ? ""
          : provider.form.price.toString())) {
    _priceController.text =
        provider.form.price == 0
            ? ""
            : provider.form.price.toString();
  }

  if (_salePriceController.text !=
      (provider.form.salePrice == 0
          ? ""
          : provider.form.salePrice.toString())) {
    _salePriceController.text =
        provider.form.salePrice == 0
            ? ""
            : provider.form.salePrice.toString();
  }

  final price = provider.form.price;
  final salePrice = provider.form.salePrice;

  double discount = 0;

  if (price > 0 && salePrice > 0) {
    discount = ((price - salePrice) / price) * 100;
  }

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pricing",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    prefixText: "₹ ",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: provider.updatePrice,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: TextFormField(
                  controller: _salePriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Sale Price",
                    prefixText: "₹ ",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: provider.updateSalePrice,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1B1B1B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.local_offer,
                  color: Colors.green,
                ),
                const SizedBox(width: 12),
                Text(
                  "Discount : ${discount.toStringAsFixed(1)} %",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          if (salePrice > price && price != 0)
            const Text(
              "Sale price cannot be greater than Price.",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
        ],
      ),
    ),
  );
}
}