import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  });

  final String title;

  final List<String> options;

  final Set<String> selectedValues;

  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      children: options.map((option) {
        return CheckboxListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(
            left: 8,
          ),
          controlAffinity:
              ListTileControlAffinity.leading,
          title: Text(option),
          value: selectedValues.contains(option),
          onChanged: (_) {
            onChanged(option);
          },
        );
      }).toList(),
    );
  }
}