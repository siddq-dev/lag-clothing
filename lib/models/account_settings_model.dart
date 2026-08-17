import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSettingsModel {
  final bool privateAccount;
  final bool personalizedAds;
  final bool biometricLogin;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const AccountSettingsModel({
    required this.privateAccount,
    required this.personalizedAds,
    required this.biometricLogin,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'privateAccount': privateAccount,
      'personalizedAds': personalizedAds,
      'biometricLogin': biometricLogin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AccountSettingsModel.fromMap(Map<String, dynamic> map) {
    return AccountSettingsModel(
      privateAccount: map['privateAccount'] ?? false,

      personalizedAds: map['personalizedAds'] ?? true,

      biometricLogin: map['biometricLogin'] ?? false,

      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  AccountSettingsModel copyWith({
    bool? privateAccount,
    bool? personalizedAds,
    bool? biometricLogin,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return AccountSettingsModel(
      privateAccount: privateAccount ?? this.privateAccount,

      personalizedAds: personalizedAds ?? this.personalizedAds,

      biometricLogin: biometricLogin ?? this.biometricLogin,

      createdAt: createdAt ?? this.createdAt,

      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
