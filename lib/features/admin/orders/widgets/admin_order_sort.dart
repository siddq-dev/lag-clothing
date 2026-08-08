import 'package:flutter/material.dart';

class AdminOrderSort extends StatelessWidget {
  const AdminOrderSort({super.key, this.value = "Newest", this.onChanged});

  final String value;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: const [
          DropdownMenuItem(value: "Newest", child: Text("Newest")),
          DropdownMenuItem(value: "Oldest", child: Text("Oldest")),
          DropdownMenuItem(
            value: "Highest Amount",
            child: Text("Highest Amount"),
          ),
          DropdownMenuItem(
            value: "Lowest Amount",
            child: Text("Lowest Amount"),
          ),
          DropdownMenuItem(
            value: "Pending First",
            child: Text("Pending First"),
          ),
          DropdownMenuItem(
            value: "Delivered First",
            child: Text("Delivered First"),
          ),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
