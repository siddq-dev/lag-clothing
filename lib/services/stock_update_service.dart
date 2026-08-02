import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/inventory_log_model.dart';
import '/repositories/inventory_log_repository.dart';

class StockUpdateService {
  StockUpdateService._();

  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ==========================================================
  // Stock OUT Log
  // ==========================================================

  static Future<void> logStockOut({
    required String productId,
    required String productName,
    required int quantity,
    required int previousStock,
    required int newStock,
    required String reference,
    required String performedBy,
  }) async {
    final log = InventoryLogModel(
      id: _firestore
          .collection("inventory_logs")
          .doc()
          .id,
      productId: productId,
      productName: productName,
      type: InventoryLogType.stockOut,
      quantity: quantity,
      previousStock: previousStock,
      newStock: newStock,
      reference: reference,
      performedBy: performedBy,
      createdAt: Timestamp.now(),
    );

    await InventoryLogRepository.createLog(log);
  }

  // ==========================================================
  // Stock IN Log
  // ==========================================================

  static Future<void> logStockIn({
    required String productId,
    required String productName,
    required int quantity,
    required int previousStock,
    required int newStock,
    required String reference,
    required String performedBy,
  }) async {
    final log = InventoryLogModel(
      id: _firestore
          .collection("inventory_logs")
          .doc()
          .id,
      productId: productId,
      productName: productName,
      type: InventoryLogType.stockIn,
      quantity: quantity,
      previousStock: previousStock,
      newStock: newStock,
      reference: reference,
      performedBy: performedBy,
      createdAt: Timestamp.now(),
    );

    await InventoryLogRepository.createLog(log);
  }
}