import 'package:cloud_firestore/cloud_firestore.dart';

enum AddressType {
  home,
  work,
  other,
}

enum AddressPurpose {
  shipping,
  billing,
}

class AddressModel {
  final String id;
  final String userId;

  final String fullName;
  final String phone;

  final String addressLine1;
  final String addressLine2;

  final String landmark;

  final String city;
  final String state;
  final String pincode;
  final String country;

  final AddressType addressType;
  final AddressPurpose purpose;

  final bool isDefault;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const AddressModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    required this.addressLine2,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.country,
    required this.addressType,
    required this.purpose,
    required this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'phone': phone,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'landmark': landmark,
      'city': city,
      'state': state,
      'pincode': pincode,
      'country': country,
      'addressType': addressType.name,
      'purpose': purpose.name,
      'isDefault': isDefault,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AddressModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return AddressModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      fullName: map['fullName'] ?? '',
      phone: map['phone'] ?? '',
      addressLine1: map['addressLine1'] ?? '',
      addressLine2: map['addressLine2'] ?? '',
      landmark: map['landmark'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      pincode: map['pincode'] ?? '',
      country: map['country'] ?? '',
      addressType: AddressType.values.firstWhere(
        (e) => e.name == map['addressType'],
        orElse: () => AddressType.home,
      ),
      purpose: AddressPurpose.values.firstWhere(
        (e) => e.name == map['purpose'],
        orElse: () => AddressPurpose.shipping,
      ),
      isDefault: map['isDefault'] ?? false,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  AddressModel copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? landmark,
    String? city,
    String? state,
    String? pincode,
    String? country,
    AddressType? addressType,
    AddressPurpose? purpose,
    bool? isDefault,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      pincode: pincode ?? this.pincode,
      country: country ?? this.country,
      addressType: addressType ?? this.addressType,
      purpose: purpose ?? this.purpose,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}