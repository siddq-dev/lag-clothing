class CheckoutPaymentMethodModel {
  final String id;
  final String title;
  final String icon;

  const CheckoutPaymentMethodModel({
    required this.id,
    required this.title,
    required this.icon,
  });
}

const checkoutPaymentMethods = [
  CheckoutPaymentMethodModel(
    id: "card",
    title: "Credit / Debit Card",
    icon: "credit_card",
  ),
  CheckoutPaymentMethodModel(id: "upi", title: "UPI", icon: "payments"),
  CheckoutPaymentMethodModel(
    id: "netbanking",
    title: "Net Banking",
    icon: "account_balance",
  ),
  CheckoutPaymentMethodModel(
    id: "wallet",
    title: "Wallet",
    icon: "account_balance_wallet",
  ),
  CheckoutPaymentMethodModel(
    id: "cod",
    title: "Cash on Delivery",
    icon: "local_shipping",
  ),
];
