import '../models/address_model.dart';
import '../models/cart_item_model.dart';
import '../models/coupon_model.dart';

class CheckoutModel {
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;

  final List<CartItemModel> cartItems;

  final CouponModel? coupon;

  final String? paymentMethod;

  final double subtotal;
  final double tax;
  final double discount;
  final double grandTotal;

  const CheckoutModel({
    required this.shippingAddress,
    required this.billingAddress,
    required this.cartItems,
    required this.coupon,
    required this.paymentMethod,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.grandTotal,
  });

  CheckoutModel copyWith({
    AddressModel? shippingAddress,
    AddressModel? billingAddress,
    List<CartItemModel>? cartItems,
    CouponModel? coupon,
    String? paymentMethod,
    double? subtotal,
    double? tax,
    double? discount,
    double? grandTotal,

    // These flags allow nullable values to actually be cleared.
    bool clearShippingAddress = false,
    bool clearBillingAddress = false,
    bool clearCoupon = false,
    bool clearPaymentMethod = false,
  }) {
    return CheckoutModel(
      shippingAddress: clearShippingAddress
          ? null
          : shippingAddress ?? this.shippingAddress,

      billingAddress: clearBillingAddress
          ? null
          : billingAddress ?? this.billingAddress,

      cartItems: cartItems ?? this.cartItems,

      coupon: clearCoupon ? null : coupon ?? this.coupon,

      paymentMethod: clearPaymentMethod
          ? null
          : paymentMethod ?? this.paymentMethod,

      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
    );
  }

  bool get hasShippingAddress => shippingAddress != null;

  bool get hasBillingAddress => billingAddress != null;

  bool get hasPaymentMethod =>
      paymentMethod != null && paymentMethod!.trim().isNotEmpty;

  bool get hasProducts => cartItems.isNotEmpty;

  bool get canPlaceOrder =>
      hasProducts &&
      hasShippingAddress &&
      hasBillingAddress &&
      hasPaymentMethod;
}
