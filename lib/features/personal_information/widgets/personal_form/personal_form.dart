import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_spacing.dart';
import '../../../../themes/app_text_style.dart';

class PersonalForm extends StatelessWidget {
  const PersonalForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        children: [

          /// First Name + Last Name
          Row(
            children: [

              Expanded(
                child: _buildTextField(
                  label: "First Name",
                  hint: "John",
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildTextField(
                  label: "Last Name",
                  hint: "Doe",
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          /// Email
          _buildTextField(
            label: "Email Address",
            hint: "john@email.com",
          ),

          const SizedBox(height: 24),

          /// Phone
          _buildTextField(
            label: "Phone Number",
            hint: "+91 9876543210",
          ),

          const SizedBox(height: 24),

          /// DOB + Gender
          Row(
            children: [

              Expanded(
                child: _buildTextField(
                  label: "Date of Birth",
                  hint: "20 July 2001",
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildDropdown(),
              ),

            ],
          ),

        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: AppTextStyles.bodyLarge,
        ),

        const SizedBox(height: 10),

        TextField(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Gender",
          style: AppTextStyles.bodyLarge,
        ),

        const SizedBox(height: 10),

        DropdownButtonFormField<String>(
          value: "Male",
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black26,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          items: const [

            DropdownMenuItem(
              value: "Male",
              child: Text("Male"),
            ),

            DropdownMenuItem(
              value: "Female",
              child: Text("Female"),
            ),

            DropdownMenuItem(
              value: "Other",
              child: Text("Other"),
            ),

          ],
          onChanged: (value) {},
        ),

      ],
    );
  }
}