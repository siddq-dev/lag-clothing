import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';
import 'order_item_model.dart';

enum OrderStatus {
  placed,
  confirmed,
  packed,
  shipped,
  outForDelivery,
  delivered,
  cancelled,
  refundRequested,
  exchangeRequested,
  returned,
}

enum PaymentStatus { pending, paid, failed, refunded }

class OrderModel {
  final String id;
  final String userId;

  final String orderNumber;

  final List<OrderItemModel> items;

  final double subtotal;
  final double shippingCharge;
  final double discount;
  final double tax;
  final double total;

  final String paymentMethod;
  final PaymentStatus paymentStatus;

  final OrderStatus orderStatus;

  final String trackingId;

  final AddressModel shippingAddress;
  final AddressModel billingAddress;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  final String adminNotes;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.items,
    required this.subtotal,
    required this.shippingCharge,
    required this.discount,
    required this.tax,
    required this.total,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.trackingId,
    required this.shippingAddress,
    required this.billingAddress,
    this.createdAt,
    this.updatedAt,
    required this.adminNotes,
  });

  // ============================================================
  // TO MAP
  // ============================================================

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'orderNumber': orderNumber,

      'items': items.map((e) => e.toMap()).toList(),

      'subtotal': subtotal,
      'shippingCharge': shippingCharge,
      'discount': discount,
      'tax': tax,

      // Current application field
      'total': total,

      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus.name,
      'orderStatus': orderStatus.name,
      'trackingId': trackingId,

      'shippingAddress': shippingAddress.toMap(),
      'billingAddress': billingAddress.toMap(),

      'createdAt': createdAt,
      'updatedAt': updatedAt,

      'adminNotes': adminNotes,
    };
  }

  // ============================================================
  // FROM MAP
  // ============================================================

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    // ----------------------------------------------------------
    // TOTAL
    //
    // Existing Firestore orders use:
    // grandTotal
    //
    // Newer orders may use:
    // total
    //
    // Support both without changing existing Firestore data.
    // ----------------------------------------------------------

    final dynamic totalValue = map['total'] ?? map['grandTotal'] ?? 0;

    // ----------------------------------------------------------
    // TAX
    //
    // Firestore currently stores:
    //
    // tax: 19.950000000000003
    //
    // Read it directly.
    // ----------------------------------------------------------

    final dynamic taxValue = map['tax'] ?? 0;

    // ----------------------------------------------------------
    // SHIPPING
    //
    // Existing Firestore order may not contain shippingCharge.
    // Default to zero.
    // ----------------------------------------------------------

    final dynamic shippingValue = map['shippingCharge'] ?? map['shipping'] ?? 0;

    // ----------------------------------------------------------
    // ORDER STATUS
    //
    // Existing Firestore:
    // "pending"
    //
    // Model:
    // OrderStatus.placed
    //
    // Admin-updated statuses such as:
    // confirmed
    // packed
    // shipped
    // outForDelivery
    // delivered
    // cancelled
    // refundRequested
    // exchangeRequested
    // returned
    //
    // are preserved.
    // ----------------------------------------------------------

    final OrderStatus parsedOrderStatus = _parseOrderStatus(map['orderStatus']);

    // ----------------------------------------------------------
    // PAYMENT STATUS
    // ----------------------------------------------------------

    final PaymentStatus parsedPaymentStatus = _parsePaymentStatus(
      map['paymentStatus'],
    );

    return OrderModel(
      id: map['id']?.toString() ?? '',

      userId: map['userId']?.toString() ?? '',

      orderNumber: map['orderNumber']?.toString() ?? '',

      items: (map['items'] as List<dynamic>? ?? [])
          .map((e) => OrderItemModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),

      subtotal: _toDouble(map['subtotal']),

      shippingCharge: _toDouble(shippingValue),

      discount: _toDouble(map['discount']),

      tax: _toDouble(taxValue),

      total: _toDouble(totalValue),

      paymentMethod: map['paymentMethod']?.toString() ?? '',

      paymentStatus: parsedPaymentStatus,

      orderStatus: parsedOrderStatus,

      trackingId: map['trackingId']?.toString() ?? '',

      shippingAddress: AddressModel.fromMap(
        Map<String, dynamic>.from(map['shippingAddress'] ?? {}),
      ),

      billingAddress: AddressModel.fromMap(
        Map<String, dynamic>.from(map['billingAddress'] ?? {}),
      ),

      createdAt: _parseTimestamp(map['createdAt']),

      updatedAt: _parseTimestamp(map['updatedAt']),

      adminNotes: map['adminNotes']?.toString() ?? '',
    );
  }

  // ============================================================
  // DOUBLE CONVERSION
  // ============================================================

  static double _toDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString()) ?? 0.0;
  }

  // ============================================================
  // ORDER STATUS PARSER
  // ============================================================

  static OrderStatus _parseOrderStatus(dynamic value) {
    final String status = value?.toString().trim() ?? '';

    // Existing orders in Firestore may use
    // "pending" instead of "placed".
    if (status == 'pending') {
      return OrderStatus.confirmed;
    }

    return OrderStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => OrderStatus.placed,
    );
  }

  // ============================================================
  // PAYMENT STATUS PARSER
  // ============================================================

  static PaymentStatus _parsePaymentStatus(dynamic value) {
    final String status = value?.toString().trim() ?? '';

    return PaymentStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => PaymentStatus.pending,
    );
  }

  // ============================================================
  // TIMESTAMP PARSER
  // ============================================================

  static Timestamp? _parseTimestamp(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is Timestamp) {
      return value;
    }

    if (value is DateTime) {
      return Timestamp.fromDate(value);
    }

    return null;
  }

  // ============================================================
  // COPY WITH
  // ============================================================

  OrderModel copyWith({
    String? id,
    String? userId,
    String? orderNumber,
    List<OrderItemModel>? items,
    double? subtotal,
    double? shippingCharge,
    double? discount,
    double? tax,
    double? total,
    String? paymentMethod,
    PaymentStatus? paymentStatus,
    OrderStatus? orderStatus,
    String? trackingId,
    AddressModel? shippingAddress,
    AddressModel? billingAddress,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? adminNotes,
  }) {
    return OrderModel(
      id: id ?? this.id,

      userId: userId ?? this.userId,

      orderNumber: orderNumber ?? this.orderNumber,

      items: items ?? this.items,

      subtotal: subtotal ?? this.subtotal,

      shippingCharge: shippingCharge ?? this.shippingCharge,

      discount: discount ?? this.discount,

      tax: tax ?? this.tax,

      total: total ?? this.total,

      paymentMethod: paymentMethod ?? this.paymentMethod,

      paymentStatus: paymentStatus ?? this.paymentStatus,

      orderStatus: orderStatus ?? this.orderStatus,

      trackingId: trackingId ?? this.trackingId,

      shippingAddress: shippingAddress ?? this.shippingAddress,

      billingAddress: billingAddress ?? this.billingAddress,

      createdAt: createdAt ?? this.createdAt,

      updatedAt: updatedAt ?? this.updatedAt,

      adminNotes: adminNotes ?? this.adminNotes,
    );
  }
}
