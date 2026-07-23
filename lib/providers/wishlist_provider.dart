import 'package:flutter/material.dart';
import '../models/wishlist_items.dart';

class WishlistProvider extends ChangeNotifier {
  final List<WishlistItem> _items = [];

  List<WishlistItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  void addItem(WishlistItem item) {
    if (_items.any((element) => element.id == item.id)) return;

    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  bool contains(String id) {
    return _items.any((item) => item.id == id);
  }

  void clearWishlist() {
    _items.clear();
    notifyListeners();
  }
}