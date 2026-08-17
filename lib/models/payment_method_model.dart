import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentMethodModel {
  final String id;
  final String userId;

  final String cardHolderName;
  final String cardNumber;
  final String last4Digits;

  final String expiryMonth;
  final String expiryYear;

  final String cvv;

  final String cardBrand;

  final bool isDefault;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const PaymentMethodModel({
    required this.id,
    required this.userId,
    required this.cardHolderName,
    required this.cardNumber,
    required this.last4Digits,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.cardBrand,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'cardHolderName': cardHolderName,
      'cardNumber': cardNumber,
      'last4Digits': last4Digits,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'cardBrand': cardBrand,
      'isDefault': isDefault,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory PaymentMethodModel.fromMap(Map<String, dynamic> map) {
    return PaymentMethodModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      cardHolderName: map['cardHolderName'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      last4Digits: map['last4Digits'] ?? '',
      expiryMonth: map['expiryMonth'] ?? '',
      expiryYear: map['expiryYear'] ?? '',
      cvv: map['cvv'] ?? '',
      cardBrand: map['cardBrand'] ?? '',
      isDefault: map['isDefault'] ?? false,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  PaymentMethodModel copyWith({
    String? id,
    String? userId,
    String? cardHolderName,
    String? cardNumber,
    String? last4Digits,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardBrand,
    bool? isDefault,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return PaymentMethodModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      last4Digits: last4Digits ?? this.last4Digits,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvv: cvv ?? this.cvv,
      cardBrand: cardBrand ?? this.cardBrand,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
