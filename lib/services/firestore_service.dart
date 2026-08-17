import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customer_model.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> createCustomer(CustomerModel customer) async {
    await _db.collection('users').doc(customer.uid).set(customer.toMap());
  }

  static Future<CustomerModel?> getCustomer(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();

    if (!doc.exists) return null;

    return CustomerModel.fromMap(doc.data()!);
  }
}
