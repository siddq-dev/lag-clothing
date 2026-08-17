import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,

        title: const Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Privacy Policy",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            policySection(
              "Introduction",
              "At LAG Clothing, we respect your privacy and are committed "
                  "to protecting your personal information when you use our "
                  "website and services.",
            ),

            policySection(
              "Information We Collect",
              "We may collect your name, email address, phone number, "
                  "delivery address, payment information, and order details "
                  "to provide better shopping experience.",
            ),

            policySection(
              "How We Use Your Information",
              "Your information is used for processing orders, "
                  "delivery updates, customer support, and improving "
                  "our products and services.",
            ),

            policySection(
              "Payment Information",
              "Payments are processed securely through trusted payment "
                  "providers. LAG Clothing does not store your complete "
                  "payment card details.",
            ),

            policySection(
              "Data Security",
              "We take reasonable measures to protect your personal "
                  "information from unauthorized access or misuse.",
            ),

            policySection(
              "Contact Us",
              "If you have questions regarding this Privacy Policy, "
                  "please contact LAG Clothing support.",
            ),
          ],
        ),
      ),
    );
  }

  Widget policySection(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,

            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            description,

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
