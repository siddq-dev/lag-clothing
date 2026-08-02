
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lag_clothing/features/admin/orders/pages/order_details_page.dart';
import 'package:lag_clothing/features/admin/widgets/permission_guard.dart';
import 'package:lag_clothing/features/orders/order_page.dart';
import 'package:lag_clothing/features/saved_address/page/add_address_page.dart';
import 'package:lag_clothing/models/customer_admin_model.dart';
import 'package:lag_clothing/routes/router_observer.dart';

import '../features/about/pages/about_page.dart';
import '../features/auth/pages/forgot_password_page.dart';
import '../features/auth/pages/login_page.dart';
import '../features/auth/pages/register_page.dart';
import '../features/cart/pages/cart_page.dart';
import '../features/checkout/pages/checkout_page.dart';
import '../features/contact/pages/contact_pages.dart';
import '../features/home/pages/home_pages.dart';
import '../features/profiles/page/profile_page.dart';
import '../features/products/pages/shop_page.dart';
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
import '../models/payment_method_model.dart';
import '../models/product_model.dart';
import '../features/payment_methods/page/add_payment_method_page.dart';
import '../features/admin/products/pages/add_product_page.dart';
import '../features/admin/products/pages/edit_product_page.dart';
import '../features/admin/products/pages/product_preview_page.dart';
import '../features/admin/dashboard/admin_dashboard_page.dart';
import '../features/auth/widgets/role_redirect.dart';
// import '../features/admin/products/pages/manage_products_page.dart';
import '../features/super_admin/dashboard/pages/super_admin_dashboard_page.dart';
import '../features/super_admin/admin_management/pages/admin_management_page.dart';
import '../features/super_admin/admin_management/pages/add_admin_page.dart';
import '../features/super_admin/admin_management/pages/edit_admin_page.dart';
import '/models/user_model.dart';
import '../features/admin/orders/pages/manage_orders_page.dart';
import '../features/checkout/pages/order_success_page.dart';
import '../features/super_admin/customer_management/pages/customer_details_page.dart';
import '../features/super_admin/customer_management/pages/customer_management_page.dart';
import '../features/super_admin/analytics/pages/analytics_dashboard_page.dart';
import '../features/inventory/pages/inventory_dashboard_page.dart';
import 'package:lag_clothing/features/super_admin/product_management/pages/product_management_page.dart';
// import '../features/super_admin/product_management/pages/add_product_page.dart';

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
static const String roleRedirect = '/role-redirect';

// ==========================
// Shopping
// ==========================

static const String cart = '/cart';
static const String checkout = '/checkout';
static const String wishlist = '/wishlist';
static const String coupons = '/coupons';
static const String orderSuccess = '/order-success';
static const String orders = '/orders';


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
static const String personalInformation = '/profile/personal-information';

static const String savedAddresses = '/profile/saved-addresses';

static const String addressForm = '/profile/address-form';
    static const String addAddress ='/profile/add-address';

static const String editAddress = '/profile/edit-address';

static const String paymentMethods = '/profile/payment-methods';

static const String changePassword = '/profile/change-password';

static const String notifications = '/profile/notifications';

static const String accountSettings = '/profile/account-settings';

static const String helpSupport = '/profile/help-support';

    static const String addPaymentMethod = '/profile/payment-methods/add';

static const String editPaymentMethod = '/profile/payment-methods/edit';
    

// ==========================
// Product
// ==========================

static const String reviews = '/reviews';
static const String sizeGuide = '/size-guide';
static const String returns = '/returns';
static const String addProduct = '/addproduct';
static const String editProduct = '/editProduct';
static const String productPreview = '/productPreview';

// ==========================
// Legal
// ==========================

static const String privacyPolicy = '/privacy-policy';

static const String termsConditions = '/terms-conditions';

    static const String faq = '/faq';

static const String shippingPolicy = '/shipping-policy';

static const String exchangePolicy = '/exchange-policy';

static const String careers = '/careers';

static const String cookiePolicy = '/cookie-policy';

// ==========================
// Admin
// ==========================

static const String admin = '/admin';

static const String adminDashboard ='/admin/dashboard';

static const String adminProducts = '/admin/products';

static const String adminOrderDetails ='/admin/order-details';

static const String adminCustomers = '/admin/customers';

    static const String manageProducts = '/admin/manage-products';

   


// ==========================
// super Admin
// ==========================

static const String superAdminDashboard = '/super-admin/dashboard';

static const String adminManagement = '/super-admin/admin-management';

static const String customerManagement = '/super-admin/customer-management';

static const String analytics = '/super-admin/analytics';

static const String websiteSettings = '/super-admin/website-settings';

static const String addAdmin = '/super-admin/add-admin';

static const String editAdmin = '/super-admin/edit-admin';

static const String customer ='/admin/customer-management';

static const String customerDetails ='/admin/customer-details';

static const String inventory ='/admin/inventory';


// ==========================
// goroutes
// ==========================



  static final GoRouter router = GoRouter(
    observers: [
    AnalyticsRouteObserver(),
  ],
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

GoRoute(
  path: addPaymentMethod,
  builder: (context, state) =>
      const AddPaymentMethodPage(),
),

GoRoute(
  path: editPaymentMethod,
  builder: (context, state) {
    final payment =
        state.extra as PaymentMethodModel;

    return AddPaymentMethodPage(
      paymentMethod: payment,
      isEditing: true,
    );
  },
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
  path: adminProducts,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Products"),
    ),
  ),
),

GoRoute(
  path: adminOrderDetails,
  builder: (context, state) =>
      const AdminManageOrdersPage(),
),

GoRoute(
  path: adminCustomers,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Admin Customers"),
    ),
  ),
),

GoRoute(
  path: AppRouter.roleRedirect,
  builder: (context, state) =>
      const RoleRedirect(),
),

GoRoute(
  path: AppRouter.adminDashboard,
  builder: (context, state) =>
      const AdminDashboardPage(),
),

// ==========================
// product
// ==========================

GoRoute(
  path: AppRouter.manageProducts,
  builder: (context, state) =>
      const ProductManagementPage(),
),




GoRoute(
  path: AppRouter.addProduct,
  builder: (context, state) {
    final productId =
        state.uri.queryParameters["id"];

    return AddProductPage(
      productId: productId,
    );
  },
),

GoRoute(
  path: AppRouter.editProduct,
  builder: (context, state) {
    // state.extra may not have a static type here; use dynamic to avoid invalid cast
    final product = state.extra as dynamic;

    return EditProductPage(
      product: product,
    );
  },
),



GoRoute(
  path: AppRouter.productPreview,
  builder: (context, state) {
    final product = state.extra as ProductModel;

    return ProductPreviewPage(
      product: product,
    );
  },
),

// ==========================
// super Admin
// ==========================


GoRoute(
  path: AppRouter.superAdminDashboard,
  builder: (context, state) =>
      const SuperAdminDashboardPage(),
),

GoRoute(
  path: AppRouter.adminManagement,
  builder: (context, state) =>
      const AdminManagementPage(),
),

GoRoute(
  path: AppRouter.addAdmin,
  builder: (context, state) =>
      const AddAdminPage(),
),

GoRoute(
  path: AppRouter.editAdmin,
  builder: (context, state) {
    final admin = state.extra as UserModel;

    return EditAdminPage(
      admin: admin,
    );
  },
),

GoRoute(
  path: AppRouter.customerManagement,
  builder: (context, state) =>
      const CustomerManagementPage(),
),

GoRoute(
  path: AppRouter.customerDetails,
  builder: (context, state) {
    final customer =
        state.extra as CustomerAdminModel;

    return CustomerDetailsPage(
      customer: customer,
    );
  },
),

GoRoute(
  path: AppRouter.inventory,
  builder: (context, state) =>
      const InventoryDashboardPage(),
),


GoRoute(
  path: AppRouter.customerManagement,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Customer Management"),
    ),
  ),
),

GoRoute(
  path: AppRouter.analytics,
  builder: (context, state) =>
      const AnalyticsDashboardPage(),
),

GoRoute(
  path: AppRouter.websiteSettings,
  builder: (context, state) => const Scaffold(
    body: Center(
      child: Text("Website Settings"),
    ),
  ),
),



// ==========================
// shopping
// ==========================



GoRoute(
  path: AppRouter.checkout,
  builder: (context, state) =>
      const CheckoutPage(),
),

GoRoute(
  path: AppRouter.orderSuccess,
  builder: (context, state) =>
      const OrderSuccessPage(),
),

GoRoute(
  path: AppRouter.orders,
  builder: (context, state) =>
      const OrdersPage(),
),

    ],
  );
  

  
}