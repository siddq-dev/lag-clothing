import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

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
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Makes Flutter web use real URL paths (e.g. /shop) instead of
  // hash-based routing (e.g. /#/shop). Without this, the router
  // never reads the actual browser path, so every direct URL
  // (typed or refreshed) falls back to the default/home route.
  usePathUrlStrategy();

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
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadHomeProducts(),
        ),
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
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // ========================================================
        // WISHLIST
        // Seeded with whatever UID is available at cold start
        // (may be empty if the app launches signed out). The
        // _AuthSync wrapper below keeps this in sync afterward,
        // whenever the user logs in or out later in the session.
        // ========================================================
        ChangeNotifierProvider(
          create: (_) =>
              WishlistProvider(customerId: customerId)..loadWishlist(),
        ),
      ],

      // ------------------------------------------------------------
      // _AuthSync listens to Firebase's live auth state and calls
      // WishlistProvider.setCustomerId(...) whenever the user logs
      // in or out. The cold-start UID above only covers the very
      // first frame the app renders — without this listener, a
      // login that happens after launch never reaches
      // WishlistProvider, which is why "Please login to view your
      // wishlist" kept showing even right after signing in.
      // ------------------------------------------------------------
      child: const _AuthSync(child: LagClothingApp()),
    ),
  );
}

class _AuthSync extends StatefulWidget {
  const _AuthSync({required this.child});

  final Widget child;

  @override
  State<_AuthSync> createState() => _AuthSyncState();
}

class _AuthSyncState extends State<_AuthSync> {
  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (!mounted) return;

      context.read<WishlistProvider>().setCustomerId(user?.uid ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}