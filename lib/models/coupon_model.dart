import 'package:cloud_firestore/cloud_firestore.dart';

enum DiscountType {
  percentage,
  fixed,
}

class CouponModel {
  final String id;

  final String code;
  final String description;

  final DiscountType discountType;

  final double discountValue;

  final double minimumOrderAmount;

  final double maximumDiscount;

  final DateTime? startDate;
  final DateTime? endDate;

  final int usageLimit;
  final int usedCount;

  final bool active;

  final List<String> applicableCategories;
  final List<String> applicableProducts;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const CouponModel({
    required this.id,
    required this.code,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.minimumOrderAmount,
    required this.maximumDiscount,
    required this.startDate,
    required this.endDate,
    required this.usageLimit,
    required this.usedCount,
    required this.active,
    required this.applicableCategories,
    required this.applicableProducts,
    this.createdAt,
    this.updatedAt,
  });

  bool get isExpired {
    if (endDate == null) return false;
    return DateTime.now().isAfter(endDate!);
  }

  bool get isStarted {
    if (startDate == null) return true;
    return DateTime.now().isAfter(startDate!);
  }

  bool get isAvailable {
    return active &&
        isStarted &&
        !isExpired &&
        usedCount < usageLimit;
  }

  factory CouponModel.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return CouponModel(
      id: id,
      code: map['code'] ?? '',
      description: map['description'] ?? '',

      discountType:
          (map['discountType'] ?? 'percentage') == 'fixed'
              ? DiscountType.fixed
              : DiscountType.percentage,

      discountValue:
          (map['discountValue'] ?? 0).toDouble(),

      minimumOrderAmount:
          (map['minimumOrderAmount'] ?? 0).toDouble(),

      maximumDiscount:
          (map['maximumDiscount'] ?? 0).toDouble(),

      startDate:
          map['startDate'] != null
              ? (map['startDate'] as Timestamp).toDate()
              : null,

      endDate:
          map['endDate'] != null
              ? (map['endDate'] as Timestamp).toDate()
              : null,

      usageLimit: map['usageLimit'] ?? 0,

      usedCount: map['usedCount'] ?? 0,

      active: map['active'] ?? true,

      applicableCategories:
          List<String>.from(
            map['applicableCategories'] ?? [],
          ),

      applicableProducts:
          List<String>.from(
            map['applicableProducts'] ?? [],
          ),

      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'description': description,

      'discountType':
          discountType == DiscountType.fixed
              ? 'fixed'
              : 'percentage',

      'discountValue': discountValue,

      'minimumOrderAmount': minimumOrderAmount,

      'maximumDiscount': maximumDiscount,

      'startDate': startDate,

      'endDate': endDate,

      'usageLimit': usageLimit,

      'usedCount': usedCount,

      'active': active,

      'applicableCategories': applicableCategories,

      'applicableProducts': applicableProducts,

      'createdAt': createdAt,

      'updatedAt': updatedAt,
    };
  }

  CouponModel copyWith({
    String? id,
    String? code,
    String? description,
    DiscountType? discountType,
    double? discountValue,
    double? minimumOrderAmount,
    double? maximumDiscount,
    DateTime? startDate,
    DateTime? endDate,
    int? usageLimit,
    int? usedCount,
    bool? active,
    List<String>? applicableCategories,
    List<String>? applicableProducts,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return CouponModel(
      id: id ?? this.id,
      code: code ?? this.code,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      minimumOrderAmount:
          minimumOrderAmount ?? this.minimumOrderAmount,
      maximumDiscount:
          maximumDiscount ?? this.maximumDiscount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      usageLimit: usageLimit ?? this.usageLimit,
      usedCount: usedCount ?? this.usedCount,
      active: active ?? this.active,
      applicableCategories:
          applicableCategories ?? this.applicableCategories,
      applicableProducts:
          applicableProducts ?? this.applicableProducts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}