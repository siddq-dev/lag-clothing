import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';

import '../widgets/auth_banner/auth_banner.dart';
import '../widgets/forgot_password_form/forgot_password_form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        child: const Row(
          children: [

            Expanded(
              flex: 6,
              child: AuthBanner(),
            ),

            Expanded(
              flex: 4,
              child: ForgotPasswordForm(),
            ),

          ],
        ),
      ),
    );
  }
}