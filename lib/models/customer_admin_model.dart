import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerAdminModel {
  final String uid;

  final String fullName;

  final String email;

  final String phone;

  final String photoUrl;

  final int totalOrders;

  final double totalSpent;

  final Timestamp? createdAt;

  final Timestamp? lastLogin;

  const CustomerAdminModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.totalOrders,
    required this.totalSpent,
    this.createdAt,
    this.lastLogin,
  });

  factory CustomerAdminModel.fromMap(
    String uid,
    Map<String, dynamic> map,
  ) {
    return CustomerAdminModel(
      uid: uid,
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
      totalOrders: map['totalOrders'] ?? 0,
      totalSpent:
          (map['totalSpent'] ?? 0).toDouble(),
      createdAt: map['createdAt'],
      lastLogin: map['lastLogin'],
    );
  }
}