class AdminPermissionModel {
  final bool dashboard;
  final bool products;
  final bool orders;
  final bool customers;
  final bool inventory;
  final bool coupons;
  final bool analytics;
  final bool admins;
  final bool settings;

  const AdminPermissionModel({
    this.dashboard = false,
    this.products = false,
    this.orders = false,
    this.customers = false,
    this.inventory = false,
    this.coupons = false,
    this.analytics = false,
    this.admins = false,
    this.settings = false,
  });

  factory AdminPermissionModel.superAdmin() {
    return const AdminPermissionModel(
      dashboard: true,
      products: true,
      orders: true,
      customers: true,
      inventory: true,
      coupons: true,
      analytics: true,
      admins: true,
      settings: true,
    );
  }

  factory AdminPermissionModel.defaultAdmin() {
    return const AdminPermissionModel(
      dashboard: true,
      products: true,
      orders: true,
      customers: true,
      inventory: true,
      coupons: false,
      analytics: false,
      admins: false,
      settings: false,
    );
  }

  factory AdminPermissionModel.fromMap(
    Map<String, dynamic>? map,
  ) {
    if (map == null) {
      return const AdminPermissionModel();
    }

    return AdminPermissionModel(
      dashboard: map['dashboard'] ?? false,
      products: map['products'] ?? false,
      orders: map['orders'] ?? false,
      customers: map['customers'] ?? false,
      inventory: map['inventory'] ?? false,
      coupons: map['coupons'] ?? false,
      analytics: map['analytics'] ?? false,
      admins: map['admins'] ?? false,
      settings: map['settings'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dashboard': dashboard,
      'products': products,
      'orders': orders,
      'customers': customers,
      'inventory': inventory,
      'coupons': coupons,
      'analytics': analytics,
      'admins': admins,
      'settings': settings,
    };
  }

  AdminPermissionModel copyWith({
    bool? dashboard,
    bool? products,
    bool? orders,
    bool? customers,
    bool? inventory,
    bool? coupons,
    bool? analytics,
    bool? admins,
    bool? settings,
  }) {
    return AdminPermissionModel(
      dashboard: dashboard ?? this.dashboard,
      products: products ?? this.products,
      orders: orders ?? this.orders,
      customers: customers ?? this.customers,
      inventory: inventory ?? this.inventory,
      coupons: coupons ?? this.coupons,
      analytics: analytics ?? this.analytics,
      admins: admins ?? this.admins,
      settings: settings ?? this.settings,
    );
  }
}