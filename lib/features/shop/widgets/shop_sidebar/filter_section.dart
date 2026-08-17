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
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,

      // Keep filters closed initially.
      initiallyExpanded: false,

      iconColor: Colors.white,
      collapsedIconColor: Colors.white,

      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),

      children: options.map((option) {
        final isSelected = selectedValues.contains(option);

        return CheckboxListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 4, right: 0),

          controlAffinity: ListTileControlAffinity.leading,

          title: Text(option, style: const TextStyle(fontSize: 14)),

          value: isSelected,

          onChanged: (_) {
            onChanged(option);
          },
        );
      }).toList(),
    );
  }
}
