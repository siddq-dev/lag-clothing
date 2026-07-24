import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/order_header/order_header.dart';
import '../widgets/order_search_bar/order_search_bar.dart';
import '../widgets/order_card/order_card.dart';
import '../widgets/order_item/order_item.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const OrdersHeader(),

              const SizedBox(height: 30),

              const OrderSearchBar(),

              const SizedBox(height: 40),

              OrderCard(
                status: "Delivered",
                orderId: "#LAG202607230001",
                orderDate: "23 Jul 2026",
                deliveryDate: "27 Jul 2026",
                totalAmount: 6096,
                itemsCount: 3,
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

              OrderCard(
                status: "Shipped",
                orderId: "#LAG202607230002",
                orderDate: "20 Jul 2026",
                deliveryDate: "25 Jul – 27 Jul 2026",
                totalAmount: 3098,
                itemsCount: 2,
                items: const [

                  OrderItem(
                    image: "assets/images/products/product4.png",
                    title: "Liverpool Away Jersey",
                    quantity: 1,
                    price: 1499,
                  ),

                  OrderItem(
                    image: "assets/images/products/product5.png",
                    title: "Brazil Away Jersey",
                    quantity: 1,
                    price: 1599,
                  ),

                ],
              ),

              OrderCard(
                status: "Processing",
                orderId: "#LAG202607230003",
                orderDate: "18 Jul 2026",
                deliveryDate: "24 Jul – 26 Jul 2026",
                totalAmount: 1499,
                itemsCount: 1,
                items: const [

                  OrderItem(
                    image: "assets/images/products/product6.png",
                    title: "Manchester City Home Jersey",
                    quantity: 1,
                    price: 1499,
                  ),

                ],
              ),

              OrderCard(
                status: "Cancelled",
                orderId: "#LAG202607230004",
                orderDate: "15 Jul 2026",
                deliveryDate: "",
                totalAmount: 1399,
                itemsCount: 1,
                items: const [

                  OrderItem(
                    image: "assets/images/products/product7.png",
                    title: "Chelsea Home Jersey",
                    quantity: 1,
                    price: 1399,
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}