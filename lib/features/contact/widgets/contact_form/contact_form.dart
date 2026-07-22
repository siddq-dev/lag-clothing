import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

import 'custom_text_field.dart';
import 'contact_button.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  void _submit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Message Sent'),
        content: const Text(
          'Thank you for contacting LAG Clothing.\n\n'
          'Our team will reach out to you as soon as possible.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);

              nameController.clear();
              emailController.clear();
              phoneController.clear();
              messageController.clear();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 60,
        vertical: 80,
      ),
      child: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                const Text(
                  'Get In Touch',
                  style: AppTextStyles.sectionTitle,
                ),

                const SizedBox(height: 12),

                const Text(
                  "We'd love to hear from you.",
                  style: AppTextStyles.sectionSubtitle,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  label: 'Name',
                  controller: nameController,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Message',
                  controller: messageController,
                  maxLines: 6,
                ),

                const SizedBox(height: 40),

                ContactButton(
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}