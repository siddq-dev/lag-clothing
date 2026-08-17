import 'package:flutter/material.dart';

import '../widgets/delivery_address.dart';
import '../widgets/delivery_partner.dart';
import '../widgets/delivery_timeline.dart';
import '../widgets/order_summary_card.dart';
import '../widgets/track_order_button.dart';
import '../widgets/tracking_header.dart';
import '../widgets/tracking_status.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text(
          "Order Tracking",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        elevation: 0,

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Page Header
            const TrackingHeader(),

            const SizedBox(height: 30),

            // Order Summary
            const OrderSummaryCard(
              orderId: "LAG10245",

              productName: "Real Madrid Jersey 2026",

              quantity: 2,

              totalAmount: "₹1998",

              orderDate: "20 July 2026",

              paymentStatus: "Paid",

              imageUrl:
                  "https://images.unsplash.com/photo-1517466787929-bc90951d0974",
            ),

            const SizedBox(height: 25),

            // Current Status
            const TrackingStatus(
              status: "Out For Delivery",

              expectedDate: "28 July 2026",
            ),

            const SizedBox(height: 25),

            // Timeline
            const DeliveryTimeline(),

            const SizedBox(height: 25),

            // Delivery Address
            const DeliveryAddress(
              name: "Siddiq",

              phone: "+91 9876543210",

              address: "123 Main Street",

              city: "Chennai",

              state: "Tamil Nadu",

              pincode: "600001",

              country: "India",
            ),

            const SizedBox(height: 25),

            // Delivery Partner
            const DeliveryPartner(
              partnerName: "Delhivery",

              trackingId: "DLV123456789",

              contactNumber: "+91 1800 123 456",
            ),

            const SizedBox(height: 30),

            // Track Live Button
            TrackOrderButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Opening live tracking...")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
