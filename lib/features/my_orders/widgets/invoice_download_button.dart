import 'package:flutter/material.dart';

class InvoiceDownloadButton extends StatelessWidget {
  const InvoiceDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.download),
        label: const Text("Download Invoice"),
      ),
    );
  }
}
