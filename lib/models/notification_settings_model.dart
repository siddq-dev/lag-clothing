import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationSettingsModel {
  final bool orderUpdates;
  final bool promotions;
  final bool newArrivals;
  final bool backInStock;
  final bool pushNotifications;
  final bool emailNotifications;
  final bool smsNotifications;

  final Timestamp? createdAt;
  final Timestamp? updatedAt;

  const NotificationSettingsModel({
    required this.orderUpdates,
    required this.promotions,
    required this.newArrivals,
    required this.backInStock,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.smsNotifications,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderUpdates': orderUpdates,
      'promotions': promotions,
      'newArrivals': newArrivals,
      'backInStock': backInStock,
      'pushNotifications': pushNotifications,
      'emailNotifications': emailNotifications,
      'smsNotifications': smsNotifications,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory NotificationSettingsModel.fromMap(Map<String, dynamic> map) {
    return NotificationSettingsModel(
      orderUpdates: map['orderUpdates'] ?? true,
      promotions: map['promotions'] ?? true,
      newArrivals: map['newArrivals'] ?? true,
      backInStock: map['backInStock'] ?? true,
      pushNotifications: map['pushNotifications'] ?? true,
      emailNotifications: map['emailNotifications'] ?? true,
      smsNotifications: map['smsNotifications'] ?? false,
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  NotificationSettingsModel copyWith({
    bool? orderUpdates,
    bool? promotions,
    bool? newArrivals,
    bool? backInStock,
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return NotificationSettingsModel(
      orderUpdates: orderUpdates ?? this.orderUpdates,
      promotions: promotions ?? this.promotions,
      newArrivals: newArrivals ?? this.newArrivals,
      backInStock: backInStock ?? this.backInStock,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
