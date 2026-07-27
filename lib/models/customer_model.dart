import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String photoUrl;
  final String role;

  final List<dynamic> addresses;
  final List<dynamic> wishlist;
  final List<dynamic> orders;

  final DateTime createdAt;

  CustomerModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.role,
    required this.addresses,
    required this.wishlist,
    required this.orders,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'role': role,
      'addresses': addresses,
      'wishlist': wishlist,
      'orders': orders,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      role: map['role'] ?? 'customer',

      addresses: List<dynamic>.from(
        map['addresses'] ?? [],
      ),

      wishlist: List<dynamic>.from(
        map['wishlist'] ?? [],
      ),

      orders: List<dynamic>.from(
        map['orders'] ?? [],
      ),

      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  CustomerModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? photoUrl,
    String? role,
    List<dynamic>? addresses,
    List<dynamic>? wishlist,
    List<dynamic>? orders,
    DateTime? createdAt,
  }) {
    return CustomerModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      addresses: addresses ?? this.addresses,
      wishlist: wishlist ?? this.wishlist,
      orders: orders ?? this.orders,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}