import 'package:flutter/material.dart';

import '/models/inventory_item_model.dart';

class InventoryDetailsPage extends StatelessWidget {
  const InventoryDetailsPage({
    super.key,
    required this.product,
  });

  final InventoryItemModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        title: const Text(
          "Inventory Details",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          color: const Color(0xFF1A1A1A),
          child: Padding(
            padding:
                const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "SKU : ${product.sku}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Category : ${product.category}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Price : ₹${product.price}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Stock : ${product.stock}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sold : ${product.soldCount}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Revenue : ₹${product.revenue}",
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                  ),
                  label: const Text(
                    "Update Stock",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}