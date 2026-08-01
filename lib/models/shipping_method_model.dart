class ShippingMethodModel {
  final String id;

  final String name;

  final String description;

  final double charge;

  final int estimatedDays;

  const ShippingMethodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.charge,
    required this.estimatedDays,
  });
}

const shippingMethods = [
  ShippingMethodModel(
    id: "standard",
    name: "Standard Delivery",
    description: "3-5 Business Days",
    charge: 0,
    estimatedDays: 5,
  ),
  ShippingMethodModel(
    id: "express",
    name: "Express Delivery",
    description: "1-2 Business Days",
    charge: 199,
    estimatedDays: 2,
  ),
];