import 'package:flutter/material.dart';

class NavLogo extends StatelessWidget {
  const NavLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Image.asset(
        'assets/images/logo/lag_logo.png',
        fit: BoxFit.contain,
      ),
    );
  }
}