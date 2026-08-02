import 'package:flutter/material.dart';

import '../../../../models/product_model.dart';

class ProductTableRow extends DataRow {
  ProductTableRow({
    required ProductModel product,
    required VoidCallback onView,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) : super(
          cells: [
            DataCell(
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Icon(Icons.image);
                        },
                      )
                    : const Icon(Icons.image),
              ),
            ),

            DataCell(
              SizedBox(
                width: 220,
                child: Text(
                  product.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            DataCell(
              Text(product.brand),
            ),

            DataCell(
              Text(product.category),
            ),

            DataCell(
              Text(
                "₹${product.price.toStringAsFixed(0)}",
              ),
            ),

            DataCell(
              Text(
                product.stock.toString(),
              ),
            ),

            DataCell(
              Chip(
                backgroundColor: product.status
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                label: Text(
                  product.status
                      ? "Active"
                      : "Inactive",
                ),
              ),
            ),

            DataCell(
              Row(
                children: [
                  IconButton(
                    onPressed: onView,
                    icon: const Icon(Icons.visibility),
                  ),

                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit),
                  ),

                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
}