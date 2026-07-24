import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../../my_orders/widgets/order_item/order_item.dart';

import '../widgets/details_header/details_header.dart';
import '../widgets/order_information/order_information.dart';
import '../widgets/ordered_products/ordered_products.dart';
import '../widgets/shipping_information/shipping_information.dart';
import '../widgets/payment_information/payment_information.dart';
import '../widgets/order_timeline/order_timeline.dart';
import '../widgets/order_summary/order_summary.dart';
import '../widgets/action_buttons/action_buttons.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 60,
            vertical: 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Header
                  const DetailsHeader(),

                  const SizedBox(height: 35),

                  /// Order Information
                  const OrderInformation(
                    status: "Delivered",
                    orderId: "#LAG202607230001",
                    orderDate: "23 Jul 2026",
                    deliveryDate: "27 Jul 2026",
                  ),

                  const SizedBox(height: 30),

                  /// Ordered Products
                  OrderedProducts(
                    items: const [

                      OrderItem(
                        image: "assets/images/products/product1.png",
                        title: "Real Madrid Home Jersey",
                        quantity: 1,
                        price: 1999,
                      ),

                      OrderItem(
                        image: "assets/images/products/product2.png",
                        title: "Barcelona Home Jersey",
                        quantity: 1,
                        price: 1999,
                      ),

                      OrderItem(
                        image: "assets/images/products/product3.png",
                        title: "Argentina Home Jersey",
                        quantity: 1,
                        price: 2098,
                      ),

                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Shipping Information
                  const ShippingInformation(
                    name: "John Doe",
                    phone: "+91 9876543210",
                    addressLine1: "123 ABC Street",
                    addressLine2: "Apartment 2B",
                    city: "Chennai",
                    state: "Tamil Nadu",
                    pincode: "600001",
                  ),

                  const SizedBox(height: 30),

                  /// Payment Information
                  const PaymentInformation(
                    paymentMethod: "UPI",
                    paymentStatus: "Successful",
                    transactionId: "TXN2389482394",
                    paymentDate: "23 Jul 2026",
                  ),

                  const SizedBox(height: 30),

                  /// Timeline
                  const OrderTimeline(
                    currentStep: 4,
                  ),

                  const SizedBox(height: 30),

                  /// Summary
                  const OrderSummary(
                    subtotal: 6096,
                    shipping: 0,
                    discount: 200,
                    total: 5896,
                  ),

                  const SizedBox(height: 40),

                  /// Buttons
                  const ActionButtons(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}