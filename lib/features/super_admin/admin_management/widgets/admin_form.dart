import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/user_model.dart';
import '../../../../../providers/admin_management_provider.dart';

class AdminForm extends StatefulWidget {
  const AdminForm({
    super.key,
    this.admin,
  });

  final UserModel? admin;

  @override
  State<AdminForm> createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();

  bool status = true;

  @override
  void initState() {
    super.initState();

    if (widget.admin != null) {
      nameController.text = widget.admin!.name;
      emailController.text = widget.admin!.email;
      phoneController.text = widget.admin!.phone;
      status = widget.admin!.status;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminManagementProvider>();

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Admin Name",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Admin Name";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: emailController,
            readOnly: widget.admin != null,
            decoration: const InputDecoration(
              labelText: "Email",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter Email";
              }
              return null;
            },
          ),

          const SizedBox(height: 20),

          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: "Phone Number",
            ),
          ),

          if (widget.admin == null) ...[
            const SizedBox(height: 20),

            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return "Minimum 6 characters";
                }
                return null;
              },
            ),
          ],

          const SizedBox(height: 25),

          SwitchListTile(
            value: status,
            title: const Text("Active Status"),
            onChanged: (value) {
              setState(() {
                status = value;
              });
            },
          ),

          const SizedBox(height: 40),

          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: provider.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.admin == null
                          ? "Create Admin"
                          : "Update Admin",
                    ),
              onPressed: provider.loading
                  ? null
                  : () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (widget.admin == null) {
                        await provider.createAdmin(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          phone: phoneController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      } else {
                        await provider.updateAdmin(
                          uid: widget.admin!.uid,
                          name: nameController.text.trim(),
                          phone: phoneController.text.trim(),
                          status: status,
                        );
                      }

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}