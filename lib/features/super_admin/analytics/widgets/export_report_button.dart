import 'package:flutter/material.dart';

class ExportReportButton extends StatelessWidget {
  const ExportReportButton({super.key, required this.onExport});

  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onExport,
      icon: const Icon(Icons.download),
      label: const Text("Export Report"),
    );
  }
}
