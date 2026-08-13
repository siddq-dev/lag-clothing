import 'package:flutter/material.dart';

import '../../../../models/order_model.dart';
import '../order_status_chip.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});

  final OrderModel order;
  final VoidCallback onTap;

  String _formatStatus(String value) {
    if (value.trim().isEmpty) {
      return 'Pending';
    }

    final words = value
        .replaceAll('_', ' ')
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .toList();

    return words.join(' ');
  }

  String _formatDate() {
    if (order.createdAt == null) {
      return '-';
    }

    final date = order.createdAt!.toDate();

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final hasItems = order.items.isNotEmpty;

    final firstItem = hasItems ? order.items.first : null;

    final remainingItems = order.items.length > 1 ? order.items.length - 1 : 0;

    return Card(
      color: Colors.grey.shade900,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =====================================================
              // ORDER HEADER
              // =====================================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '#${order.orderNumber}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          _formatDate(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  OrderStatusChip(
                    status: _formatStatus(order.orderStatus.name),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const Divider(color: Colors.white12),

              const SizedBox(height: 16),

              // =====================================================
              // PRODUCT PREVIEW
              // =====================================================
              if (firstItem != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -------------------------------------------------
                    // PRODUCT IMAGE
                    // -------------------------------------------------
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: firstItem.productImage.trim().isNotEmpty
                          ? Image.network(
                              firstItem.productImage,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _imagePlaceholder();
                              },
                            )
                          : _imagePlaceholder(),
                    ),

                    const SizedBox(width: 14),

                    // -------------------------------------------------
                    // PRODUCT INFORMATION
                    // -------------------------------------------------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            firstItem.productName.trim().isEmpty
                                ? 'Product'
                                : firstItem.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Size: ${firstItem.size}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Color: ${firstItem.color}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Qty: ${firstItem.quantity}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            '₹${firstItem.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'No product information available.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),

              // =====================================================
              // MORE ITEMS
              // =====================================================
              if (remainingItems > 0) ...[
                const SizedBox(height: 12),

                Text(
                  '+ $remainingItems more '
                  '${remainingItems == 1 ? 'item' : 'items'}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              const SizedBox(height: 16),

              const Divider(color: Colors.white12),

              const SizedBox(height: 12),

              // =====================================================
              // TOTAL + PAYMENT
              // =====================================================
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          order.paymentMethod.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        '₹${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // =====================================================
              // VIEW DETAILS
              // =====================================================
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: onTap,
                  child: const Text('View Order Details'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 90,
      height: 90,
      color: Colors.grey.shade800,
      child: const Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey,
        size: 32,
      ),
    );
  }
}
