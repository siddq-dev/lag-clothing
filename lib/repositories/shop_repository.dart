import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product_model.dart';

class ShopRepository {
  ShopRepository();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  //==================================================
  // STREAM ALL ACTIVE PRODUCTS
  //==================================================

  Stream<List<ProductModel>> streamProducts() {
    return _products.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      print('======================================');
      print('SHOP FIRESTORE UPDATE');
      print('Documents: ${snapshot.docs.length}');
      print('======================================');

      final products = <ProductModel>[];

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();

          print('Product ID: ${doc.id}');
          print('Product name: ${data['name']}');
          print('Status: ${data['status']}');

          final product = ProductModel.fromMap(data, documentId: doc.id);

          // Customer shop should only display active products.
          if (product.status) {
            products.add(product);
          }
        } catch (e, stackTrace) {
          print('ERROR PARSING PRODUCT ${doc.id}: $e');

          print(stackTrace);
        }
      }

      print('Active products returned: ${products.length}');

      return products;
    });
  }

  //==================================================
  // GET PRODUCTS - ONE TIME
  //==================================================

  Future<List<ProductModel>> getProducts({
    int limit = 50,
    DocumentSnapshot<Map<String, dynamic>>? lastDocument,
  }) async {
    Query<Map<String, dynamic>> query = _products
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final snapshot = await query.get();

    print('======================================');
    print('SHOP GET PRODUCTS');
    print('Documents: ${snapshot.docs.length}');
    print('======================================');

    final products = <ProductModel>[];

    for (final doc in snapshot.docs) {
      try {
        final product = ProductModel.fromMap(doc.data(), documentId: doc.id);

        if (product.status) {
          products.add(product);
        }
      } catch (e, stackTrace) {
        print('ERROR PARSING PRODUCT ${doc.id}: $e');

        print(stackTrace);
      }
    }

    return products;
  }

  //==================================================
  // FEATURED
  //==================================================

  Future<List<ProductModel>> getFeaturedProducts() async {
    final products = await getProducts();

    return products.where((product) => product.featured).toList();
  }

  //==================================================
  // BEST SELLER
  //==================================================

  Future<List<ProductModel>> getBestSellerProducts() async {
    final products = await getProducts();

    return products.where((product) => product.bestSeller).toList();
  }

  //==================================================
  // NEW ARRIVAL
  //==================================================

  Future<List<ProductModel>> getNewArrivalProducts() async {
    final products = await getProducts();

    return products.where((product) => product.newArrival).toList();
  }

  //==================================================
  // CATEGORY
  //==================================================

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final products = await getProducts();

    return products.where((product) => product.category == category).toList();
  }

  //==================================================
  // SEARCH
  //==================================================

  Future<List<ProductModel>> searchProducts(String keyword) async {
    final products = await getProducts();

    final search = keyword.toLowerCase().trim();

    if (search.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.name.toLowerCase().contains(search) ||
          product.brand.toLowerCase().contains(search) ||
          product.category.toLowerCase().contains(search);
    }).toList();
  }

  //==================================================
  // SINGLE PRODUCT
  //==================================================

  Future<ProductModel?> getProduct(String id) async {
    final snapshot = await _products.doc(id).get();

    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();

    if (data == null) {
      return null;
    }

    return ProductModel.fromMap(data, documentId: snapshot.id);
  }

  //==================================================
  // SINGLE PRODUCT STREAM
  //==================================================

  Stream<ProductModel?> streamProduct(String id) {
    return _products.doc(id).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      final product = ProductModel.fromMap(data, documentId: snapshot.id);

      if (!product.status) {
        return null;
      }

      return product;
    });
  }
}
