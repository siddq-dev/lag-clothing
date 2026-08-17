import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../providers/customer_provider.dart';
import '../../../../routes/app_routes.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool loading = false;

  Future<void> saveProfile() async {
    if (!widget.formKey.currentState!.validate()) {
      return;
    }

    try {
      setState(() {
        loading = true;
      });

      await context.read<CustomerProvider>().updateProfile(
        fullName: widget.nameController.text.trim(),
        // email: widget.emailController.text.trim(),
        phone: widget.phoneController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated Successfully")),
      );

      context.go(AppRouter.profile);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: loading ? null : saveProfile,
        child: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : const Text(
                "SAVE CHANGES",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
