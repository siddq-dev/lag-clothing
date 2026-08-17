import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/auth_provider.dart';

class AdminAppBar extends StatelessWidget {
  const AdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          const Spacer(),

          Text(user?.name ?? ""),

          const SizedBox(width: 20),

          IconButton(
            onPressed: () {
              context.read<AuthProvider>().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
