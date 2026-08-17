import '../providers/cart_provider.dart';

class CheckoutValidationService {
  CheckoutValidationService._();

  static Future<String?> validate(CartProvider cartProvider) async {
    if (cartProvider.items.isEmpty) {
      return "Your cart is empty.";
    }

    // TODO
    // Check inventory
    // Check product availability
    // Check latest prices

    return null;
  }
}
