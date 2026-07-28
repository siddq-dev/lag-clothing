
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lag_clothing/features/saved_address/page/add_address_page.dart';

import '../features/about/pages/about_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/cart/pages/cart_page.dart';
import '../features/checkout/pages/checkout_page.dart';
import '../features/contact/pages/contact_pages.dart';
import '../features/home/pages/home_pages.dart';
import '../features/profiles/page/profile_page.dart';
import '../features/shop/page/shop_page.dart';
import '../features/wishlist/pages/wishlist_page.dart';
import '../features/order_confirmation/page/order_confirmation_page.dart';
import '../features/personal_information/page/personal_information_page.dart';
import '../features/saved_address/page/saved_address_page.dart';
import '../features/address_form/page/address_form_page.dart';
import '../features/payment_methods/page/payment_methods_page.dart';
import '../features/change_password/page/change_password_page.dart';
import '../features/notifications/page/notifications_page.dart';
import '../features/help_support/page/help_support_page.dart';
import '../features/account_settings/page/account_settings_page.dart';
import '../features/my_orders/page/my_orders_page.dart';
import '../features/order_details/page/order_detail_page.dart';
import '../features/order_tracking/page/order_tracking_page.dart';
import '../features/reviews/page/reviews_page.dart';
import '../features/size_guide/page/size_guide_page.dart';
import '../features/returns/page/returns_page.dart';
import '../features/coupons/page/coupons_page.dart';
import '../features/legal/privacy_policy_page.dart';
import '../features/legal/terms_conditions_page.dart';
import '../features/legal/page/careers_page.dart';
import '../features/legal/page/faq_page.dart';
import '../features/legal/page/exchange_policy_page.dart';
import '../features/legal/page/shipping_policy_page.dart';
import '../features/legal/page/cookie_policy_page.dart';
import '../features/profiles/page/edit_profile_page.dart';
import '../models/address_model.dart';


class AppRouter {
  AppRouter._();

  // ==========================
// Public
// ==========================

static const String home = '/';
static const String shop = '/shop';
static const String collections = '/collections';
static const String product = '/product';
static const String about = '/about';
static const String contact = '/contact';

// ==========================
// Authentication
// ==========================

static const String login = '/login';
static const String register = '/register';
static const String forgotPassword = '/forgot-password';

// ==========================
// Shopping
// ==========================

static const String cart = '/cart';
static const String checkout = '/checkout';
static const String wishlist = '/wishlist';
static const String coupons = '/coupons';

// ==========================
// Orders
// ==========================

static const String myOrders = '/my-orders';
static const String orderDetails = '/order-details';
static const String orderTracking = '/order-tracking';
static const String orderConfirmation = '/order-confirmation';

// ==========================
// Profile
// ==========================


static const String editProfile = '/edit-profile';
static const String profile = '/profile';
static const String personalInformation =
    '/profile/personal-information';

static const String savedAddresses =
    '/profile/saved-addresses';

static const String addressForm =
    '/profile/address-form';
    static const String addAddress =
    '/profile/add-address';

static const String editAddress =
    '/profile/edit-address';

static const String paymentMethods =
    '/profile/payment-methods';

static const String changePassword =
    '/profile/change-password';

static const String notifications =
    '/profile/notifications';

static const String accountSettings =
    '/profile/account-settings';

static const String helpSupport =
    '/profile/help-support';
    

// ==========================
// Product
// ==========================

static const String reviews = '/reviews';
static const String sizeGuide = '/size-guide';
static const String returns = '/returns';

// ==========================
// Legal
// ==========================

static const String privacyPolicy =
    '/privacy-policy';

static const String termsConditions =
    '/terms-conditions';

    static const String faq = '/faq';

static const String shippingPolicy = '/shipping-policy';

static const String exchangePolicy = '/exchange-policy';

static const String careers = '/careers';

static const String cookiePolicy = '/cookie-policy';

// ==========================
// Admin
// ==========================

static const String admin = '/admin';
static const String adminDashboard =
    '/admin/dashboard';

static const String adminProducts =
    '/admin/products';

static const String adminOrders =
    '/admin/orders';

static const String adminCustomers =
    '/admin/customers';


  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [

      GoRoute(
        path: home,
        builder: (context, state) => const HomePage(),
      ),

      GoRoute(
        path: shop,
        builder: (context, state) => const ShopPage(),
      ),

      GoRoute(
        path: about,
        builder: (context, state) => const AboutPage(),
      ),

      GoRoute(
        path: contact,
        builder: (context, state) => const ContactPage(),
      ),

      GoRoute(
        path: cart,
        builder: (context, state) => const CartPage(),
      ),

      GoRoute(
        path: checkout,
        builder: (context, state) => const CheckoutPage(),
      ),

    

      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),

      GoRoute(
        path: forgotPassword,
        builder: (context, state) =>
            const ForgotPasswordPage(),
      ),

      // ==========================
// Wishlist
// ==========================

GoRoute(
  path: wishlist,
  builder: (context, state) => const WishlistPage(),
),

// ==========================
// Order Confirmation
// ==========================

GoRoute(
  path: orderConfirmation,
  builder: (context, state) =>
      const OrderConfirmationPage(),
),

// ==========================
// Profile
// ==========================

GoRoute(
  path: AppRouter.editProfile,
  builder: (context, state) => const EditProfilePage(),
),

GoRoute(
  path: profile,
  builder: (context, state) =>
      const ProfilePage(),
),

GoRoute(
  path: personalInformation,
  builder: (context, state) =>
      const PersonalInformationPage(),
),

GoRoute(
  path: savedAddresses,
  builder: (context, state) =>
      const SavedAddressesPage(),
),

GoRoute(
  path: addressForm,
  builder: (context, state) =>
      const AddressFormPage(),
),

GoRoute(
  path: addAddress,
  builder: (context, state) =>
      const AddAddressPage(),
),

GoRoute(
  path: editAddress,
  builder: (context, state) {
    final address = state.extra as AddressModel;

    return AddAddressPage(
      address: address,
      isEditing: true,
    );
  },
),

GoRoute(
  path: paymentMethods,
  builder: (context, state) =>
      const PaymentMethodsPage(),
),

GoRoute(
  path: changePassword,
  builder: (context, state) =>
      const ChangePasswordPage(),
),

GoRoute(
  path: notifications,
  builder: (context, state) =>
      const NotificationsPage(),
),

GoRoute(
  path: helpSupport,
  builder: (context, state) =>
      const HelpSupportPage(),
),

GoRoute(
  path: accountSettings,
  builder: (context, state) =>
      const AccountSettingsPage(),
),

// ==========================
// Orders
// ==========================

GoRoute(
  path: myOrders,
  builder: (context, state) =>
      const MyOrdersPage(),
),

GoRoute(
  path: orderDetails,
  builder: (context, state) =>
      const OrderDetailsPage(),
),

GoRoute(
  path: orderTracking,
  builder: (context, state) =>
      const OrderTrackingPage(),
),

// ==========================
// Reviews
// ==========================

GoRoute(
  path: reviews,
  builder: (context, state) =>
      const ReviewsPage(),
),

// ==========================
// Size Guide
// ==========================

GoRoute(
  path: sizeGuide,
  builder: (context, state) =>
      const SizeGuidePage(),
),

// ==========================
// Returns
// ==========================

GoRoute(
  path: returns,
  builder: (context, state) =>
      const ReturnsPage(),
),

// ==========================
// Coupons
// ==========================

GoRoute(
  path: coupons,
  builder: (context, state) =>
      const CouponsPage(),
),

// ==========================
// Privacy Policy
// ==========================

GoRoute(
  path: privacyPolicy,
  builder: (context, state) =>
      const PrivacyPolicyPage(),
),

// ==========================
// Terms & Conditions
// ==========================

GoRoute(
  path: termsConditions,
  builder: (context, state) =>
      const TermsConditionsPage(),
),

// ==========================
// legal Pages
// ==========================




GoRoute(
  path: faq,
  builder: (context, state) => const FAQPage(),
),

GoRoute(
  path: shippingPolicy,
  builder: (context, state) => const ShippingPolicyPage(),
),

GoRoute(
  path: exchangePolicy,
  builder: (context, state) => const ExchangePolicyPage(),
),

GoRoute(
  path: careers,
  builder: (context, state) => const CareersPage(),
),

GoRoute(
  path: cookiePolicy,
  builder: (context, state) => const CookiePolicyPage(),
),

// ==========================
// Admin (Placeholder)
// ==========================

GoRoute(
  path: admin,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Dashboard"),
    ),
  ),
),

GoRoute(
  path: adminDashboard,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Dashboard"),
    ),
  ),
),

GoRoute(
  path: adminProducts,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Products"),
    ),
  ),
),

GoRoute(
  path: adminOrders,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Orders"),
    ),
  ),
),

GoRoute(
  path: adminCustomers,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Customers"),
    ),
  ),
),

    ],
  );
  

  
}