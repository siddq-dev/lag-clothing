import 'package:flutter/material.dart';

class AnalyticsDateFilter extends StatelessWidget {
  const AnalyticsDateFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final String selected;

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selected,
      items: const [
        DropdownMenuItem(value: "Today", child: Text("Today")),
        DropdownMenuItem(value: "Week", child: Text("This Week")),
        DropdownMenuItem(value: "Month", child: Text("This Month")),
        DropdownMenuItem(value: "Year", child: Text("This Year")),
      ],
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
