import 'package:flutter/material.dart';

import '../../../../layout/website_layout.dart';

import '../widgets/success/success_buttons.dart';
import '../widgets/success/success_details.dart';
import '../widgets/success/success_header.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const WebsiteLayout(
      currentRoute: '/order-success',
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(60),
          child: SizedBox(
            width: 700,
            child: Column(
              children: [

                SuccessHeader(),

                SizedBox(height: 30),

                SuccessDetails(),

                SizedBox(height: 40),

                SuccessButtons(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}