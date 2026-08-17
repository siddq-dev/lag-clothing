import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/customer_model.dart';

class CustomerRepository {
  CustomerRepository._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static const String _collection = 'users';

  /// -------------------------------
  /// Current User
  /// -------------------------------

  static User? get currentUser => _auth.currentUser;

  static String? get currentUid => _auth.currentUser?.uid;

  /// -------------------------------
  /// Get Current Customer
  /// -------------------------------

  static Future<CustomerModel?> getCurrentCustomer() async {
    final user = _auth.currentUser;

    if (user == null) return null;

    final snapshot = await _firestore
        .collection(_collection)
        .doc(user.uid)
        .get();

    if (!snapshot.exists) return null;

    return CustomerModel.fromMap(snapshot.data()!);
  }

  /// -------------------------------
  /// Stream Current Customer
  /// -------------------------------

  static Stream<CustomerModel?> streamCurrentCustomer() {
    final user = _auth.currentUser;

    if (user == null) {
      return Stream.value(null);
    }

    return _firestore.collection(_collection).doc(user.uid).snapshots().map((
      snapshot,
    ) {
      if (!snapshot.exists) {
        return null;
      }

      return CustomerModel.fromMap(snapshot.data()!);
    });
  }

  /// -------------------------------
  /// Update Basic Profile
  /// -------------------------------

  static Future<void> updateProfile({
    required String fullName,
    required String phone,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _firestore.collection(_collection).doc(user.uid).update({
      'fullName': fullName.trim(),
      'phone': phone.trim(),
    });
  }

  /// -------------------------------
  /// Update Profile Photo
  /// -------------------------------

  static Future<void> updatePhotoUrl(String photoUrl) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _firestore.collection(_collection).doc(user.uid).update({
      'photoUrl': photoUrl,
    });
  }

  /// -------------------------------
  /// Update Address List
  /// -------------------------------

  static Future<void> updateAddresses(List<dynamic> addresses) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    await _firestore.collection(_collection).doc(user.uid).update({
      'addresses': addresses,
    });
  }

  /// -------------------------------
  /// Refresh Customer
  /// -------------------------------

  static Future<CustomerModel?> refreshCustomer() async {
    return getCurrentCustomer();
  }
}
