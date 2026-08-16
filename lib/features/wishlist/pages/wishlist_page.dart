import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/wishlist_provider.dart';
import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<WishlistProvider>().loadWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          'My Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: Consumer<WishlistProvider>(
        builder: (context, provider, child) {
          // ============================================================
          // LOADING
          // ============================================================

          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // ============================================================
          // ERROR
          // ============================================================

          if (provider.error != null && provider.items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: 55,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      provider.error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),

                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: provider.loadWishlist,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // ============================================================
          // EMPTY WISHLIST
          // ============================================================

          if (provider.isEmpty) {
            return const EmptyWishlist();
          }

          // ============================================================
          // WISHLIST ITEMS
          // ============================================================

          return RefreshIndicator(
            onRefresh: provider.refresh,

            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.symmetric(vertical: 8),

              itemCount: provider.items.length,

              itemBuilder: (context, index) {
                final item = provider.items[index];

                return WishlistItemCard(
                  item: item,

                  // ------------------------------------------------------
                  // REMOVE
                  // ------------------------------------------------------
                  onRemove: () async {
                    final success = await provider.removeItem(item.id);

                    if (!context.mounted) return;

                    if (!success && provider.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(provider.error!),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },

                  // ------------------------------------------------------
                  // INCREASE QUANTITY
                  // ------------------------------------------------------
                  onIncrease: () async {
                    final success = await provider.increaseQuantity(item.id);

                    if (!context.mounted) return;

                    if (!success && provider.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(provider.error!),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },

                  // ------------------------------------------------------
                  // DECREASE QUANTITY
                  // ------------------------------------------------------
                  onDecrease: () async {
                    final success = await provider.decreaseQuantity(item.id);

                    if (!context.mounted) return;

                    if (!success && provider.error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(provider.error!),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },

                  // ------------------------------------------------------
                  // ADD TO CART
                  // ------------------------------------------------------
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${item.name} (${item.size}) added to cart',
                        ),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    // TODO:
                    // Connect this to your CartProvider.
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
