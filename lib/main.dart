import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:lag_clothing/providers/auth_provider.dart';
import 'package:lag_clothing/providers/inventory_provider.dart';
import 'package:lag_clothing/providers/shop_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;

import 'firebase_options.dart';
import 'app.dart';
import 'providers/wishlist_provider.dart';
import 'providers/customer_provider.dart';
import 'providers/address_provider.dart';
import 'providers/payment_method_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/account_settings_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/admin_management_provider.dart';
import 'providers/admin_product_provider.dart';
import 'providers/admin_order_filter_provider.dart';
import 'providers/coupon_provider.dart';
import 'providers/customer_management_provider.dart';
import 'providers/analytics_provider.dart';
import '/services/analytics_lifecycle_service.dart';
import 'providers/product_management_provider.dart';
import 'providers/checkout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsBinding.instance.addObserver(AnalyticsLifecycleService());

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // ============================================================
  // CURRENT USER
  // ============================================================

  final User? currentUser = FirebaseAuth.instance.currentUser;
  final String customerId = currentUser?.uid ?? '';

  debugPrint('MAIN: Firebase customer ID = $customerId');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => AccountSettingsProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => AdminManagementProvider()),
        ChangeNotifierProvider(create: (_) => AdminProductProvider()),
        ChangeNotifierProvider(create: (_) => AdminOrderFilterProvider()),
        ChangeNotifierProvider(create: (_) => CouponProvider()),
        ChangeNotifierProvider(create: (_) => CustomerManagementProvider()),
        ChangeNotifierProvider(create: (_) => AnalyticsProvider()),
        ChangeNotifierProvider(create: (_) => InventoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductManagementProvider()),
        ChangeNotifierProvider(create: (_) => ShopProvider()),
        ChangeNotifierProvider(create: (_) => CheckoutProvider()),

        // ========================================================
        // WISHLIST
        // Seeded with the real signed-in user's UID, and kept in
        // sync automatically whenever auth state changes (login/
        // logout), so the wishlist never gets stuck showing the
        // wrong (or empty) customer's data.
        // ========================================================
        ChangeNotifierProvider(
          create: (_) =>
              WishlistProvider(customerId: customerId)..loadWishlist(),
        ),
      ],
      child: const LagClothingApp(),
    ),
  );
}
