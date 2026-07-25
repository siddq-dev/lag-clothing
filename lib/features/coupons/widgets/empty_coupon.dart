import 'package:flutter/material.dart';

class EmptyCoupon extends StatelessWidget {
  const EmptyCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          vertical: 60,
        ),
        child: Column(
          children: const [

            Icon(
              Icons.local_offer_outlined,
              size: 80,
              color: Colors.grey,
            ),

            SizedBox(height: 20),

            Text(
              "No Coupons Available",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15),

            Text(
              "There are currently no active coupons.\nPlease check back later for exciting offers!",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.6,
              ),
            ),

          ],
        ),
      ),
    );
  }
}