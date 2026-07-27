import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app.dart';
import 'providers/wishlist_provider.dart';
import 'providers/customer_provider.dart';

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

      ],
      child: const LagClothingApp(),
    ),
  );
}