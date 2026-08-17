import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/customer_provider.dart';

import 'profile_image_picker.dart';
import 'save_button.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CustomerProvider>();
    final customer = provider.customer;

    if (customer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_initialized) {
      _initialized = true;

      _nameController.text = customer.fullName;
      _emailController.text = customer.email;
      _phoneController.text = customer.phone;
    }

    return Form(
      key: _formKey,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              ProfileImagePicker(imageUrl: customer.photoUrl),

              const SizedBox(height: 35),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your email";
                  }

                  if (!value.contains("@")) {
                    return "Invalid email";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter your phone number";
                  }

                  if (value.length < 10) {
                    return "Invalid phone number";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 40),

              SaveButton(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                phoneController: _phoneController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
