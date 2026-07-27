class CustomerModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final DateTime createdAt;

  CustomerModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}