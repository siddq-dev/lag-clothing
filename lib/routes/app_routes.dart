class AppRouter {
  AppRouter._();

  // Public
  static const String home = '/';
  static const String shop = '/shop';
  static const String collections = '/collections';
  static const String product = '/product';
  static const String about = '/about-us';
  static const String contact = '/contact-us';

  // Customer
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String wishlist = '/wishlist';
  static const String profile = '/profile';
  static const String orders = '/orders';
  static const String orderConfirmation = '/order-confirmation';

  // Authentication
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Admin
  static const String admin = '/admin';
  static const String adminProducts = '/admin/products';
  static const String adminOrders = '/admin/orders';
  static const String adminCustomers = '/admin/customers';
  static const String adminDashboard = '/admin/dashboard';
}