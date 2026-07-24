import 'package:flutter/material.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_spacing.dart';
import '../../../themes/app_text_style.dart';

class AddressTypeSelector extends StatelessWidget {
  const AddressTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final String selectedType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Address Type",
          style: AppTextStyles.bodyLarge,
        ),

        const SizedBox(height: AppSpacing.md),

        Row(
          children: [

            _buildOption("Home"),

            const SizedBox(width: 20),

            _buildOption("Office"),

            const SizedBox(width: 20),

            _buildOption("Other"),

          ],
        ),

      ],
    );
  }

  Widget _buildOption(String value) {
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [

          Radio<String>(
            value: value,
            groupValue: selectedType,
            activeColor: AppColors.primary,
            onChanged: (v) {
              if (v != null) {
                onChanged(v);
              }
            },
          ),

          Text(
            value,
            style: AppTextStyles.bodyLarge,
          ),

        ],
      ),
    );
  }
}