import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_permission_model.dart';

enum UserRole {
  customer,
  admin,
  superAdmin,
}

class UserModel {
  final String uid;

  final String name;

  final String email;

  final String phone;

  final UserRole role;

  final bool status;

  final AdminPermissionModel permissions;

  final Timestamp? createdAt;

  final Timestamp? lastLogin;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    this.permissions = const AdminPermissionModel(),
    this.createdAt,
    this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "role": role.name,
      "status": status,
      'permissions': permissions.toMap(),
      "createdAt": createdAt,
      "lastLogin": lastLogin,
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserModel(
      uid: map["uid"] ?? "",
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      phone: map["phone"] ?? "",
      role: _parseRole(
        map["role"],
      ),
      status: map["status"] ?? true,
      permissions: AdminPermissionModel.fromMap(
  map['permissions'],
),
      createdAt: map["createdAt"],
      lastLogin: map["lastLogin"],
    );
  }

  static UserRole _parseRole(
    String? role,
  ) {
    switch (role) {
      case "admin":
        return UserRole.admin;

     case "superAdmin":
    case "super_admin":
      return UserRole.superAdmin;

      default:
        return UserRole.customer;
    }
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    bool? status,
    AdminPermissionModel? permissions,
    Timestamp? createdAt,
    Timestamp? lastLogin,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      permissions: permissions ?? this.permissions,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}