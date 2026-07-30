import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../models/admin_permission_model.dart';

class PermissionGuard extends StatelessWidget {
  const PermissionGuard({
    super.key,
    required this.builder,
    required this.hasPermission,
  });

  final WidgetBuilder builder;

  final bool Function(AdminPermissionModel permissions)
      hasPermission;

  @override
  Widget build(BuildContext context) {
    final user =
        context.watch<AuthProvider>().currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text("User not found"),
        ),
      );
    }

    final permission = user.permissions;

    if (!hasPermission(permission)) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Access Denied",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return builder(context);
  }
}