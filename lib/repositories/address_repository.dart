import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/address_model.dart';

class AddressRepository {
  AddressRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String get _uid {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in.");
    }

    return user.uid;
  }

  static CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('users').doc(_uid).collection('addresses');

  // ==========================================================
  // Get All Addresses
  // ==========================================================

  static Future<List<AddressModel>> getAddresses() async {
    final snapshot = await _collection
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => AddressModel.fromMap(doc.data()))
        .toList();
  }

  // ==========================================================
  // Stream Addresses
  // ==========================================================

  static Stream<List<AddressModel>> streamAddresses() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AddressModel.fromMap(doc.data()))
              .toList(),
        );
  }

  // ==========================================================
  // Add Address
  // ==========================================================

  static Future<void> addAddress(AddressModel address) async {
    final doc = _collection.doc();

    final model = address.copyWith(
      id: doc.id,
      userId: _uid,
      createdAt: Timestamp.now(),
      updatedAt: Timestamp.now(),
    );

    await doc.set(model.toMap());
  }

  // ==========================================================
  // Update Address
  // ==========================================================

  static Future<void> updateAddress(AddressModel address) async {
    final model = address.copyWith(updatedAt: Timestamp.now());

    await _collection.doc(address.id).update(model.toMap());
  }

  // ==========================================================
  // Delete Address
  // ==========================================================

  static Future<void> deleteAddress(String id) async {
    await _collection.doc(id).delete();
  }

  // ==========================================================
  // Get Default Shipping Address
  // ==========================================================

  static Future<AddressModel?> getDefaultShippingAddress() async {
    final snapshot = await _collection
        .where('purpose', isEqualTo: AddressPurpose.shipping.name)
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return AddressModel.fromMap(snapshot.docs.first.data());
  }

  // ==========================================================
  // Get Default Billing Address
  // ==========================================================

  static Future<AddressModel?> getDefaultBillingAddress() async {
    final snapshot = await _collection
        .where('purpose', isEqualTo: AddressPurpose.billing.name)
        .where('isDefault', isEqualTo: true)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return AddressModel.fromMap(snapshot.docs.first.data());
  }

  // ==========================================================
  // Set Default Address
  // ==========================================================

  static Future<void> setDefaultAddress(
    String id,
    AddressPurpose purpose,
  ) async {
    final batch = _firestore.batch();

    final addresses = await _collection
        .where('purpose', isEqualTo: purpose.name)
        .get();

    for (final doc in addresses.docs) {
      batch.update(doc.reference, {
        'isDefault': false,
        'updatedAt': Timestamp.now(),
      });
    }

    batch.update(_collection.doc(id), {
      'isDefault': true,
      'updatedAt': Timestamp.now(),
    });

    await batch.commit();
  }
}
