import 'package:flutter/material.dart';

import '../../../models/wishlist_items.dart';

class WishlistItemCard extends StatelessWidget {
  final WishlistItem item;

  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onAddToCart;

  const WishlistItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1A1A1A),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // IMAGE
            // =====================================================
            Container(
              width: 110,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: item.imageUrl.isNotEmpty
                    ? Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_outlined,
                            color: Colors.white54,
                            size: 40,
                          );
                        },
                      )
                    : const Icon(
                        Icons.image_outlined,
                        color: Colors.white54,
                        size: 40,
                      ),
              ),
            ),

            const SizedBox(width: 15),

            // =====================================================
            // DETAILS
            // =====================================================
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    item.category,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 8),

                  // SIZE
                  Text(
                    'Size: ${item.size.isNotEmpty ? item.size : '-'}',
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 4),

                  // COLOR
                  if (item.color.isNotEmpty)
                    Text(
                      'Color: ${item.color}',
                      style: const TextStyle(color: Colors.white70),
                    ),

                  const SizedBox(height: 8),

                  // PRICE
                  Text(
                    '₹${item.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // QUANTITY
                  // =================================================
                  Row(
                    children: [
                      const Text(
                        'Qty:',
                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: item.quantity > 1 ? onDecrease : null,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),

                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            IconButton(
                              onPressed: onIncrease,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: onAddToCart,
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ),

            // =====================================================
            // REMOVE
            // =====================================================
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
