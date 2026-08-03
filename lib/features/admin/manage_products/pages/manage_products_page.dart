import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';
import '../../../../routes/app_routes.dart';
import '../../widgets/admin_product_filter.dart';
import '../../widgets/admin_product_search_bar.dart';
import '../../widgets/admin_product_sort.dart';
import '/providers/admin_product_filter_provider.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() =>
      _ManageProductsPageState();
}

class _ManageProductsPageState
    extends State<ManageProductsPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadProducts();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final productProvider =
    context.watch<ProductProvider>();

final filterProvider =
    context.watch<AdminProductFilterProvider>();

final products =
    filterProvider.apply(productProvider.products);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppRouter.addProduct);
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Product"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            Row(
              children: [

                Expanded(
                  child: AdminProductSearchBar(
                    controller: searchController,
                    onChanged: (value) {
                      context
                          .read<
                              AdminProductFilterProvider>()
                          .updateSearch(value);
                    },
                    onClear: () {
                      context
                          .read<
                              AdminProductFilterProvider>()
                          .clearSearch();
                    },
                  ),
                ),

                const SizedBox(width: 16),

                const AdminProductSort(),

                const SizedBox(width: 16),

                FilledButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return const Dialog(
                          child: Padding(
                            padding:
                                EdgeInsets.all(20),
                            child:
                                AdminProductFilter(),
                          ),
                        );
                      },
                    );
                  },
                  icon:
                      const Icon(Icons.filter_alt),
                  label: const Text("Filters"),
                ),

              ],
            ),

            const SizedBox(height: 30),

            Expanded(
              child: Card(
                elevation: 2,
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal,
                  child: DataTable(
                    headingRowHeight: 60,
                    dataRowMinHeight: 72,

                    columns: const [

                      DataColumn(
                        label: Text("Image"),
                      ),

                      DataColumn(
                        label: Text("Name"),
                      ),

                      DataColumn(
                        label: Text("Brand"),
                      ),

                      DataColumn(
                        label: Text("Category"),
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

                    rows: products.map((product) {

                      return DataRow(

                        onSelectChanged: (_) {
                          context.push(
                            AppRouter.productDetails,
                            extra: product,
                          );
                        },

                        cells: [

                          DataCell(
                            product.images.isEmpty
                                ? const Icon(
                                    Icons.image,
                                  )
                                : Image.network(
                                    product
                                        .images
                                        .first
                                        .imageUrl,
                                    width: 60,
                                    height: 60,
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
                            Text(product.category),
                          ),

                          DataCell(
                            Text(
                              "₹${product.price}",
                            ),
                          ),

                          DataCell(
                            Text(
                              product.stock
                                  .toString(),
                            ),
                          ),

                          DataCell(
                            Chip(
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
                                  icon:
                                      const Icon(
                                    Icons.visibility,
                                  ),
                                  onPressed: () {
                                    context.push(
                                      AppRouter
                                          .productDetails,
                                      extra: product,
                                    );
                                  },
                                ),

                                IconButton(
                                  icon:
                                      const Icon(
                                    Icons.edit,
                                  ),
                                  onPressed: () {
                                    context.push(
                                      AppRouter
                                          .editProduct,
                                      extra: product,
                                    );
                                  },
                                ),

                              ],
                            ),
                          ),

                        ],

                      );

                    }).toList(),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}