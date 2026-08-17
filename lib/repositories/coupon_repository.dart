import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/coupon_model.dart';

class CouponRepository {
  CouponRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  final String _collection = 'coupon_codes';

  //==========================================================
  // Get Coupon by Code
  //==========================================================

  Future<CouponModel?> getCouponByCode(String code) async {
    final query = await _firestore
        .collection(_collection)
        .where('code', isEqualTo: code.toUpperCase())
        .limit(1)
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    final doc = query.docs.first;

    return CouponModel.fromMap(doc.id, doc.data());
  }

  //==========================================================
  // Validate Coupon
  //==========================================================

  Future<CouponModel> validateCoupon({
    required String code,
    required double subtotal,

    required List<String> productIds,
  }) async {
    final coupon = await getCouponByCode(code);

    if (coupon == null) {
      throw Exception("Invalid coupon code.");
    }

    if (!coupon.active) {
      throw Exception("Coupon is inactive.");
    }

    if (!coupon.isStarted) {
      throw Exception("Coupon is not active yet.");
    }

    if (coupon.isExpired) {
      throw Exception("Coupon has expired.");
    }

    if (coupon.usedCount >= coupon.usageLimit) {
      throw Exception("Coupon usage limit reached.");
    }

    if (subtotal < coupon.minimumOrderAmount) {
      throw Exception(
        "Minimum order amount is ₹${coupon.minimumOrderAmount.toStringAsFixed(0)}",
      );
    }

    //----------------------------------------------------------
    // Product Validation
    //----------------------------------------------------------

    if (coupon.applicableProducts.isNotEmpty) {
      final valid = productIds.any(
        (id) => coupon.applicableProducts.contains(id),
      );

      if (!valid) {
        throw Exception("Coupon is not valid for selected products.");
      }
    }

    return coupon;
  }

  //==========================================================
  // Calculate Discount
  //==========================================================

  double calculateDiscount({
    required CouponModel coupon,
    required double subtotal,
  }) {
    double discount = 0;

    if (coupon.discountType == DiscountType.percentage) {
      discount = subtotal * (coupon.discountValue / 100);

      if (discount > coupon.maximumDiscount) {
        discount = coupon.maximumDiscount;
      }
    } else {
      discount = coupon.discountValue;
    }

    return discount;
  }

  //==========================================================
  // Increment Coupon Usage
  //==========================================================

  Future<void> incrementUsage(String couponId) async {
    await _firestore.collection(_collection).doc(couponId).update({
      'usedCount': FieldValue.increment(1),
      'updatedAt': Timestamp.now(),
    });
  }

  //==========================================================
  // Stream All Coupons (Admin)
  //==========================================================

  Stream<List<CouponModel>> streamCoupons() {
    return _firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CouponModel.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }
}
