import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/inventory_item_model.dart';

class InventoryRepository {
  InventoryRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection("products");

  //----------------------------------------------------------
  // Get Products
  //----------------------------------------------------------

  static Future<List<InventoryItemModel>> getProducts() async {
    final snapshot = await _products.orderBy("name").get();

    return snapshot.docs
        .map((doc) => InventoryItemModel.fromMap(doc.id, doc.data()))
        .toList();
  }

  //----------------------------------------------------------
  // Stream Products
  //----------------------------------------------------------

  static Stream<List<InventoryItemModel>> streamProducts() {
    return _products
        .orderBy("name")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => InventoryItemModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  //----------------------------------------------------------
  // Update Stock
  //----------------------------------------------------------

  static Future<void> updateStock({
    required String productId,
    required int stock,
  }) async {
    await _products.doc(productId).update({
      "stock": stock,
      "updatedAt": Timestamp.now(),
    });
  }

  //----------------------------------------------------------
  // Increase Stock
  //----------------------------------------------------------

  static Future<void> increaseStock({
    required String productId,
    required int quantity,
  }) async {
    await _products.doc(productId).update({
      "stock": FieldValue.increment(quantity),
      "updatedAt": Timestamp.now(),
    });
  }
  //----------------------------------------------------------
  // Decrease Stock
  //----------------------------------------------------------

  static Future<void> decreaseStock({
    required String productId,
    required int quantity,
  }) async {
    await _products.doc(productId).update({
      "stock": FieldValue.increment(-quantity),
      "updatedAt": Timestamp.now(),
    });
  }
}
