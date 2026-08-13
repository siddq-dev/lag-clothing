import 'package:flutter/material.dart';
import 'package:lag_clothing/models/order_item_model.dart';

import '../../../../../models/order_model.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.items});

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            if (items.isEmpty)
              const Text(
                'No product information available.',
                style: TextStyle(color: Colors.grey),
              )
            else
              ...items.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _OrderProductItem(item: item),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OrderProductItem extends StatelessWidget {
  const _OrderProductItem({required this.item});

  final OrderItemModel item;

  @override
  Widget build(BuildContext context) {
    final itemTotal = item.price * item.quantity;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================================================
          // PRODUCT IMAGE
          // =========================================================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.productImage.trim().isNotEmpty
                ? Image.network(
                    item.productImage,
                    width: 100,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _placeholder();
                    },
                  )
                : _placeholder(),
          ),

          const SizedBox(width: 16),

          // =========================================================
          // PRODUCT DETAILS
          // =========================================================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName.trim().isEmpty
                      ? 'Product'
                      : item.productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                _detailRow('Color', item.color),

                const SizedBox(height: 5),

                _detailRow('Size', item.size),

                const SizedBox(height: 5),

                _detailRow('Quantity', item.quantity.toString()),

                const SizedBox(height: 10),

                Text(
                  '₹${item.price.toStringAsFixed(2)} each',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),

                const SizedBox(height: 6),

                Text(
                  '₹${itemTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            '$label:',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value.trim().isEmpty ? '-' : value,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      width: 100,
      height: 110,
      color: Colors.grey.shade800,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
        size: 36,
      ),
    );
  }
}
