import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/payment_method_model.dart';

class PaymentMethodRepository {
  PaymentMethodRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get _uid => _auth.currentUser!.uid;

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('users').doc(_uid).collection('payment_methods');

  // ==========================================
  // Get All Cards
  // ==========================================

  static Future<List<PaymentMethodModel>> getPaymentMethods() async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => PaymentMethodModel.fromMap(doc.data()))
        .toList();
  }

  // ==========================================
  // Stream Cards
  // ==========================================

  static Stream<List<PaymentMethodModel>> streamPaymentMethods() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PaymentMethodModel.fromMap(doc.data()))
              .toList(),
        );
  }

  // ==========================================
  // Add Card
  // ==========================================

  static Future<void> addPaymentMethod(PaymentMethodModel card) async {
    final doc = _collection.doc();

    await doc.set(
      card
          .copyWith(
            id: doc.id,
            userId: _uid,
            createdAt: Timestamp.now(),
            updatedAt: Timestamp.now(),
          )
          .toMap(),
    );
  }

  // ==========================================
  // Update Card
  // ==========================================

  static Future<void> updatePaymentMethod(PaymentMethodModel card) async {
    await _collection.doc(card.id).update({
      ...card.toMap(),
      'updatedAt': Timestamp.now(),
    });
  }

  // ==========================================
  // Delete Card
  // ==========================================

  static Future<void> deletePaymentMethod(String id) async {
    await _collection.doc(id).delete();
  }

  // ==========================================
  // Default Card
  // ==========================================

  static Future<PaymentMethodModel?> getDefaultPaymentMethod() async {
    final snapshot = await _collection
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return PaymentMethodModel.fromMap(snapshot.docs.first.data());
  }

  // ==========================================
  // Set Default Card
  // ==========================================

  static Future<void> setDefaultPaymentMethod(String id) async {
    final batch = _firestore.batch();

    final cards = await _collection.get();

    for (final doc in cards.docs) {
      batch.update(doc.reference, {'isDefault': false});
    }

    batch.update(_collection.doc(id), {
      'isDefault': true,
      'updatedAt': Timestamp.now(),
    });

    await batch.commit();
  }
}
