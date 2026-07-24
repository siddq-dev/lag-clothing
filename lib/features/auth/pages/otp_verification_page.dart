import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';

import '../widgets/auth_banner/auth_banner.dart';
import '../widgets/otp_form/otp_form.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({
    super.key,
    required this.destination,
    required this.isPhone,
  });

  final String destination;
  final bool isPhone;

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        child: Row(
          children: [

            const Expanded(
              flex: 6,
              child: AuthBanner(),
            ),

            Expanded(
              flex: 4,
              child: OtpForm(
                destination: destination,
                isPhone: isPhone,
              ),
            ),

          ],
        ),
      ),
    );
  }
}