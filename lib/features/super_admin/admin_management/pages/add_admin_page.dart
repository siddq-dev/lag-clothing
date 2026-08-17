import 'package:flutter/material.dart';

import '../widgets/admin_form.dart';

class AddAdminPage extends StatelessWidget {
  const AddAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Admin")),
      body: const Padding(padding: EdgeInsets.all(30), child: AdminForm()),
    );
  }
}
