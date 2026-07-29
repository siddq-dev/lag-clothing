import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../routes/app_routes.dart';

import '../../../../../providers/admin_product_provider.dart';

class ProductListTable extends StatefulWidget {
  const ProductListTable({super.key});

  @override
  State<ProductListTable> createState() =>
      _ProductListTableState();
}

class _ProductListTableState
    extends State<ProductListTable> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<AdminProductProvider>()
          .loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider =
        context.watch<AdminProductProvider>();

    if (provider.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (provider.products.isEmpty) {
      return const Center(
        child: Text(
          "No Products Available",
        ),
      );
    }

    return SingleChildScrollView(
      child: DataTable(

        columns: const [

          DataColumn(
            label: Text("Image"),
          ),

          DataColumn(
            label: Text("Product"),
          ),

          DataColumn(
            label: Text("Brand"),
          ),

          DataColumn(
            label: Text("Price"),
          ),

          DataColumn(
            label: Text("Stock"),
          ),

          DataColumn(
            label: Text("Status"),
          ),

          DataColumn(
            label: Text("Actions"),
          ),

        ],

        rows: provider.products.map((product) {

          final image =
              product.images.isNotEmpty
                  ? product.images.first.imageUrl
                  : "";

          return DataRow(

            cells: [

              DataCell(

                image.isEmpty

                    ? const Icon(Icons.image)

                    : Image.network(
                        image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),

              ),

              DataCell(
                Text(product.name),
              ),

              DataCell(
                Text(product.brand),
              ),

              DataCell(
                Text(
                  "₹${product.salePrice}",
                ),
              ),

              DataCell(
                Text(
                  product.stock.toString(),
                ),
              ),

              DataCell(
  Switch(
    value: product.status,
    onChanged: (value) async {
      // TODO
      // Toggle Product Status
    },
  ),
),

              DataCell(
  Row(
    children: [

      /// Preview
      IconButton(
        onPressed: () {
          context.push(
            AppRouter.productPreview,
            extra: product,
          );
        },
        icon: const Icon(Icons.visibility),
      ),

      /// Edit
      IconButton(
        onPressed: () {
          context.push(
            AppRouter.editProduct,
            extra: product,
          );
        },
        icon: const Icon(Icons.edit),
      ),

      /// Delete
    IconButton(
  icon: const Icon(
    Icons.delete,
    color: Colors.red,
  ),
  onPressed: () async {

    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Delete Product",
          ),

          content: const Text(
            "Are you sure you want to delete this product?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text("Delete"),
            ),

          ],

        );

      },
    );

    if (confirm == true) {

      await context
          .read<AdminProductProvider>()
          .deleteProduct(product);

      if (context.mounted) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              "Product Deleted Successfully",
            ),
          ),
        );

      }

    }

  },
),

    ],
  ),
),

            ],

          );

        }).toList(),

      ),
    );
  }
}