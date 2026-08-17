import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/auth_banner/auth_banner.dart';
import '../widgets/login_form/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;

    return WebsiteLayout(
      currentRoute: '',
      child: isMobile
          ? const LoginForm()
          : SizedBox(
              height: MediaQuery.of(context).size.height - 80,
              child: const Row(
                children: [
                  Expanded(flex: 6, child: AuthBanner()),
                  Expanded(flex: 4, child: LoginForm()),
                ],
              ),
            ),
    );
  }
}
