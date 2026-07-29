import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../routes/app_routes.dart';

class RoleRedirect extends StatefulWidget {
  const RoleRedirect({super.key});

  @override
  State<RoleRedirect> createState() =>
      _RoleRedirectState();
}

class _RoleRedirectState extends State<RoleRedirect> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final auth =
          context.read<AuthProvider>();

      final user = auth.currentUser;

      if (user == null) {
        context.go(AppRouter.login);
        return;
      }

      switch (user.role) {
        case UserRole.customer:
          context.go(AppRouter.home);
          break;

        case UserRole.admin:
        case UserRole.superAdmin:
          context.go(AppRouter.adminDashboard);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}