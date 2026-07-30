import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';
import '../widgets/admin_form.dart';

class EditAdminPage extends StatelessWidget {
  const EditAdminPage({
    super.key,
    required this.admin,
  });

  final UserModel admin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Admin"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: AdminForm(
          admin: admin,
        ),
      ),
    );
  }
}