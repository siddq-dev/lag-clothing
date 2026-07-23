import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';

import '../widgets/auth_banner/auth_banner.dart';
import '../widgets/login_form/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebsiteLayout(
      currentRoute: '',
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 80,
        child: Row(
          children: const [

            Expanded(
              flex: 6,
              child: AuthBanner(),
            ),

            Expanded(
              flex: 4,
              child: LoginForm(),
            ),

          ],
        ),
      ),
    );
  }
}