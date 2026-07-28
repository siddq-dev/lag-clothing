import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app.dart';
import 'providers/wishlist_provider.dart';
import 'providers/customer_provider.dart';
import 'providers/address_provider.dart';
import 'providers/payment_method_provider.dart';
import 'providers/notification_provider.dart';
import 'providers/account_settings_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WishlistProvider(), ),
        ChangeNotifierProvider(create: (_) => CustomerProvider(), ),
        ChangeNotifierProvider(create: (_) => AddressProvider(), ),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider(), ),
        ChangeNotifierProvider(create: (_) => NotificationProvider(), ),
        ChangeNotifierProvider(create: (_) => AccountSettingsProvider(), ),

      ],
      child: const LagClothingApp(),
    ),
  );
}