import 'package:flutter/foundation.dart';

import '../models/wishlist_items.dart';
import '../repositories/wishlist_repository.dart';

class WishlistProvider extends ChangeNotifier {
  WishlistProvider({required this.customerId, WishlistRepository? repository})
    : _repository = repository ?? WishlistRepository();

  final String customerId;
  final WishlistRepository _repository;

  final List<WishlistItem> _items = [];

  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  List<WishlistItem> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  bool get isLoading => _isLoading;

  bool get isSaving => _isSaving;

  String? get error => _error;

  bool get hasCustomer => customerId.trim().isNotEmpty;

  Future<void> loadWishlist() async {
    if (!hasCustomer) {
      _items.clear();
      _error = 'Please login to view your wishlist.';
      _isLoading = false;

      debugPrint('WISHLIST: Customer ID is empty.');

      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      debugPrint('WISHLIST: Loading for customer $customerId');

      final data = await _repository.getWishlist(customerId);

      final loadedItems = <WishlistItem>[];

      for (final item in data) {
        try {
          loadedItems.add(
            WishlistItem.fromMap(Map<String, dynamic>.from(item)),
          );
        } catch (e) {
          debugPrint('WISHLIST: Invalid item: $e');
        }
      }

      _items
        ..clear()
        ..addAll(loadedItems);

      debugPrint('WISHLIST: Loaded ${_items.length} items.');
    } catch (e, stackTrace) {
      debugPrint('WISHLIST LOAD ERROR: $e');
      debugPrint('$stackTrace');

      _error = 'Failed to load wishlist.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addItem(WishlistItem item) async {
    if (!hasCustomer) {
      _error = 'Please login before adding items to your wishlist.';

      debugPrint('WISHLIST ADD: Customer ID is empty.');

      notifyListeners();
      return false;
    }

    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final existingIndex = _items.indexWhere(
        (element) =>
            element.productId == item.productId &&
            element.size == item.size &&
            element.color == item.color,
      );

      if (existingIndex >= 0) {
        _items[existingIndex] = item;
      } else {
        _items.add(item);
      }

      notifyListeners();

      await _repository.addItem(customerId: customerId, item: item.toMap());

      debugPrint('WISHLIST: Item saved successfully.');

      return true;
    } catch (e, stackTrace) {
      debugPrint('WISHLIST ADD ERROR: $e');
      debugPrint('$stackTrace');

      _error = 'Failed to add item to wishlist.';

      await loadWishlist();

      return false;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  Future<bool> removeItem(String itemId) async {
    if (!hasCustomer) {
      _error = 'Please login first.';
      notifyListeners();
      return false;
    }

    final index = _items.indexWhere((item) => item.id == itemId);

    if (index == -1) {
      return false;
    }

    final removedItem = _items[index];

    _items.removeAt(index);
    notifyListeners();

    try {
      await _repository.removeItem(customerId: customerId, itemId: itemId);

      return true;
    } catch (e, stackTrace) {
      debugPrint('WISHLIST REMOVE ERROR: $e');
      debugPrint('$stackTrace');

      _items.insert(index, removedItem);

      _error = 'Failed to remove wishlist item.';

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    if (quantity <= 0) {
      return removeItem(itemId);
    }

    if (!hasCustomer) {
      _error = 'Please login first.';
      notifyListeners();
      return false;
    }

    final index = _items.indexWhere((item) => item.id == itemId);

    if (index == -1) {
      return false;
    }

    final oldItem = _items[index];

    _items[index] = oldItem.copyWith(quantity: quantity);

    notifyListeners();

    try {
      await _repository.updateQuantity(
        customerId: customerId,
        itemId: itemId,
        quantity: quantity,
      );

      return true;
    } catch (e, stackTrace) {
      debugPrint('WISHLIST UPDATE ERROR: $e');
      debugPrint('$stackTrace');

      _items[index] = oldItem;

      _error = 'Failed to update wishlist quantity.';

      notifyListeners();

      return false;
    }
  }

  Future<bool> increaseQuantity(String itemId) {
    final item = getItem(itemId);

    if (item == null) {
      return Future.value(false);
    }

    return updateQuantity(itemId: itemId, quantity: item.quantity + 1);
  }

  Future<bool> decreaseQuantity(String itemId) {
    final item = getItem(itemId);

    if (item == null) {
      return Future.value(false);
    }

    if (item.quantity <= 1) {
      return removeItem(itemId);
    }

    return updateQuantity(itemId: itemId, quantity: item.quantity - 1);
  }

  WishlistItem? getItem(String itemId) {
    for (final item in _items) {
      if (item.id == itemId) {
        return item;
      }
    }

    return null;
  }

  bool contains(String itemId) {
    return _items.any((item) => item.id == itemId);
  }

  bool containsVariant({
    required String productId,
    required String size,
    required String color,
  }) {
    return _items.any(
      (item) =>
          item.productId == productId &&
          item.size == size &&
          item.color == color,
    );
  }

  Future<bool> clearWishlist() async {
    if (!hasCustomer) {
      _error = 'Please login first.';
      notifyListeners();
      return false;
    }

    final oldItems = List<WishlistItem>.from(_items);

    _items.clear();
    notifyListeners();

    try {
      await _repository.clearWishlist(customerId);

      return true;
    } catch (e, stackTrace) {
      debugPrint('WISHLIST CLEAR ERROR: $e');
      debugPrint('$stackTrace');

      _items.addAll(oldItems);

      _error = 'Failed to clear wishlist.';

      notifyListeners();

      return false;
    }
  }

  Future<void> refresh() async {
    await loadWishlist();
  }

  void clearError() {
    if (_error == null) {
      return;
    }

    _error = null;
    notifyListeners();
  }
}
