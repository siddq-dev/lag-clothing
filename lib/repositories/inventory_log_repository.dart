import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/inventory_log_model.dart';

class InventoryLogRepository {
  InventoryLogRepository._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>>
      get _logs =>
          _firestore.collection("inventory_logs");

  static Future<void> createLog(
    InventoryLogModel log,
  ) async {
    await _logs.doc(log.id).set(
          log.toMap(),
        );
  }
}