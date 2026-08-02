import 'package:flutter/material.dart';

class ProductStatusBadge extends StatelessWidget {
  const ProductStatusBadge({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor:
          enabled
              ? Colors.green.shade100
              : Colors.red.shade100,
      label: Text(
        enabled ? "Active" : "Disabled",
      ),
    );
  }
}