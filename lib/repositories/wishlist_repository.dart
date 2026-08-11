import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistRepository {
  WishlistRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> _wishlistCollection(
    String customerId,
  ) {
    return _firestore
        .collection('customers')
        .doc(customerId)
        .collection('wishlist');
  }

  Future<List<Map<String, dynamic>>> getWishlist(String customerId) async {
    if (customerId.trim().isEmpty) {
      throw Exception('customerId is empty');
    }

    final snapshot = await _wishlistCollection(customerId).get();

    return snapshot.docs.map((doc) {
      return {...doc.data(), 'id': doc.id};
    }).toList();
  }

  Future<String> addItem({
    required String customerId,
    required Map<String, dynamic> item,
  }) async {
    if (customerId.trim().isEmpty) {
      throw Exception('customerId is empty');
    }

    final productId = item['productId']?.toString() ?? '';
    final size = item['size']?.toString() ?? '';
    final color = item['color']?.toString() ?? '';

    if (productId.isEmpty) {
      throw Exception('productId is empty');
    }

    /*
     * Use product + size + color as a stable wishlist identity.
     */
    final existing = await _wishlistCollection(customerId)
        .where('productId', isEqualTo: productId)
        .where('size', isEqualTo: size)
        .where('color', isEqualTo: color)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;

      await doc.reference.set({
        ...item,
        'id': doc.id,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return doc.id;
    }

    final doc = await _wishlistCollection(customerId).add({
      ...item,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    await doc.update({'id': doc.id});

    return doc.id;
  }

  Future<void> removeItem({
    required String customerId,
    required String itemId,
  }) async {
    if (customerId.trim().isEmpty) {
      throw Exception('customerId is empty');
    }

    if (itemId.trim().isEmpty) {
      throw Exception('itemId is empty');
    }

    await _wishlistCollection(customerId).doc(itemId).delete();
  }

  Future<void> updateQuantity({
    required String customerId,
    required String itemId,
    required int quantity,
  }) async {
    if (customerId.trim().isEmpty) {
      throw Exception('customerId is empty');
    }

    if (itemId.trim().isEmpty) {
      throw Exception('itemId is empty');
    }

    await _wishlistCollection(customerId).doc(itemId).update({
      'quantity': quantity,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> clearWishlist(String customerId) async {
    if (customerId.trim().isEmpty) {
      throw Exception('customerId is empty');
    }

    final snapshot = await _wishlistCollection(customerId).get();

    if (snapshot.docs.isEmpty) {
      return;
    }

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }
}
