import 'feature_product_model.dart';

class CartProduct {
  final ProductModel product;
  final int quantity;

  const CartProduct({
    required this.product,
    required this.quantity,
  });
}