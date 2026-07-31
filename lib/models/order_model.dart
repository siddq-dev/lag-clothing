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
  returned,
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

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

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      orderNumber: map['orderNumber'] ?? '',
      items: (map['items'] as List<dynamic>? ?? [])
          .map(
            (e) => OrderItemModel.fromMap(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList(),
      subtotal: (map['subtotal'] ?? 0).toDouble(),
      shippingCharge: (map['shippingCharge'] ?? 0).toDouble(),
      discount: (map['discount'] ?? 0).toDouble(),
      tax: (map['tax'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
      paymentMethod: map['paymentMethod'] ?? '',
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.name == map['paymentStatus'],
        orElse: () => PaymentStatus.pending,
      ),
      orderStatus: OrderStatus.values.firstWhere(
        (e) => e.name == map['orderStatus'],
        orElse: () => OrderStatus.placed,
      ),
      trackingId: map['trackingId'] ?? '',
      shippingAddress: AddressModel.fromMap(
        Map<String, dynamic>.from(
          map['shippingAddress'] ?? {},
        ),
      ),
      billingAddress: AddressModel.fromMap(
        Map<String, dynamic>.from(
          map['billingAddress'] ?? {},
        ),
      ),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      adminNotes: map['adminNotes'] ?? '',
    );
  }

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
      shippingAddress:
          shippingAddress ?? this.shippingAddress,
      billingAddress:
          billingAddress ?? this.billingAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      adminNotes: adminNotes ?? this.adminNotes,
    );
  }
}