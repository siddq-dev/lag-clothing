import '../models/address_model.dart';
import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';

class CheckoutModel {
  final AddressModel? selectedAddress;

  final List<CartItemModel> cartItems;

  final CouponModel? coupon;

  final String shippingMethod;

  final String paymentMethod;

  final double subtotal;

  final double shippingCharge;

  final double tax;

  final double discount;

  final double grandTotal;

  const CheckoutModel({
    required this.selectedAddress,
    required this.cartItems,
    required this.coupon,
    required this.shippingMethod,
    required this.paymentMethod,
    required this.subtotal,
    required this.shippingCharge,
    required this.tax,
    required this.discount,
    required this.grandTotal,
  });

  CheckoutModel copyWith({
    AddressModel? selectedAddress,
    List<CartItemModel>? cartItems,
    CouponModel? coupon,
    String? shippingMethod,
    String? paymentMethod,
    double? subtotal,
    double? shippingCharge,
    double? tax,
    double? discount,
    double? grandTotal,
  }) {
    return CheckoutModel(
      selectedAddress:
          selectedAddress ?? this.selectedAddress,
      cartItems: cartItems ?? this.cartItems,
      coupon: coupon ?? this.coupon,
      shippingMethod:
          shippingMethod ?? this.shippingMethod,
      paymentMethod:
          paymentMethod ?? this.paymentMethod,
      subtotal: subtotal ?? this.subtotal,
      shippingCharge:
          shippingCharge ?? this.shippingCharge,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }
}