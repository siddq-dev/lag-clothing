import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:lag_clothing/providers/wishlist_provider.dart';

import '../widgets/empty_wishlist.dart';
import '../widgets/wishlist_item_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WishlistProvider>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Wishlist"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: provider.isEmpty
          ? const EmptyWishlist()
          : ListView.builder(
              itemCount: provider.items.length,
              itemBuilder: (context, index) {
                final item = provider.items[index];

                return WishlistItemCard(
                  item: item,
                  onRemove: () {
                    provider.removeItem(item.id);
                  },
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Cart"),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}