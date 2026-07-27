import 'package:flutter/material.dart';

enum AddressType {
  home,
  office,
  other,
}

class AddressTypeSelector extends StatelessWidget {
  const AddressTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final AddressType selectedType;
  final ValueChanged<AddressType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Address Type",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          children: [
            ChoiceChip(
              label: const Text("Home"),
              selected: selectedType == AddressType.home,
              onSelected: (_) => onChanged(AddressType.home),
            ),

            ChoiceChip(
              label: const Text("Office"),
              selected: selectedType == AddressType.office,
              onSelected: (_) => onChanged(AddressType.office),
            ),

            ChoiceChip(
              label: const Text("Other"),
              selected: selectedType == AddressType.other,
              onSelected: (_) => onChanged(AddressType.other),
            ),
          ],
        ),
      ],
    );
  }
}