import 'package:flutter/material.dart';
import 'themes/app_themes.dart';
import 'package:lag_clothing/features/home/pages/home_pages.dart';
import 'package:lag_clothing/features/contact/pages/contact_pages.dart';
import 'package:lag_clothing/features/about/pages/about_page.dart';
import 'package:lag_clothing/features/shop/page/shop_page.dart';
import 'package:lag_clothing/features/auth/pages/login_page.dart';
import 'package:lag_clothing/features/auth/pages/register_page.dart';
import 'package:lag_clothing/features/auth/pages/forgot_password_page.dart';
import 'package:lag_clothing/features/wishlist/pages/wishlist_page.dart';
import 'package:lag_clothing/features/cart/pages/cart_page.dart';
import 'package:lag_clothing/features/checkout/pages/checkout_page.dart';
import 'package:lag_clothing/features/order_confirmation/page/order_confirmation_page.dart';
import 'package:lag_clothing/features/profiles/page/profile_page.dart';
import 'package:lag_clothing/features/personal_information/page/personal_information_page.dart';


class LagClothingApp extends StatelessWidget {
  const LagClothingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Lag Clothing',
  theme: AppTheme.darkTheme,
  home:  const PersonalInformationPage(), // Set the initial page to ProfilePage
);
  }
}