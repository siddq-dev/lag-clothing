import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.options,
  });

  final String title;
  final List<String> options;

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = List.generate(widget.options.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      title: Text(
        widget.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      children: List.generate(
        widget.options.length,
        (index) => CheckboxListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(left: 8),
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.options[index]),
          value: selected[index],
          onChanged: (value) {
            setState(() {
              selected[index] = value!;
            });
          },
        ),
      ),
    );
  }
}