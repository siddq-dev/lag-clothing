import 'package:flutter/material.dart';

import '../../../../services/contact_service.dart';
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

  bool _isSubmitting = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();

    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      await ContactService.sendContactMessage(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        message: messageController.text,
      );

      if (!mounted) return;

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      messageController.clear();

      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Message Sent'),
          content: const Text(
            'Thank you for contacting LAG Clothing.\n\n'
            'Your message has been sent successfully. '
            'Our team will get back to you as soon as possible.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!mounted) return;

      final errorMessage = e.toString().replaceFirst('Exception: ', '');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';

    if (name.isEmpty) {
      return 'Please enter your name.';
    }

    if (name.length < 2) {
      return 'Name must be at least 2 characters.';
    }

    return null;
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Please enter your email address.';
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address.';
    }

    return null;
  }

  String? _validateMessage(String? value) {
    final message = value?.trim() ?? '';

    if (message.isEmpty) {
      return 'Please enter your message.';
    }

    if (message.length < 5) {
      return 'Message must be at least 5 characters.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Center(
        child: Container(
          width: 700,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text('Get In Touch', style: AppTextStyles.sectionTitle),

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
                  validator: _validateName,
                  enabled: !_isSubmitting,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Email Address',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  enabled: !_isSubmitting,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Phone Number',
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  enabled: !_isSubmitting,
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  label: 'Message',
                  controller: messageController,
                  maxLines: 6,
                  validator: _validateMessage,
                  enabled: !_isSubmitting,
                ),

                const SizedBox(height: 40),

                ContactButton(onPressed: _submit, isLoading: _isSubmitting),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
