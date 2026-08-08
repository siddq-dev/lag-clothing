import 'package:flutter/material.dart';

class WebsiteTrafficCard extends StatelessWidget {
  const WebsiteTrafficCard({
    super.key,
    required this.todayVisitors,
    required this.totalVisitors,
  });

  final int todayVisitors;

  final int totalVisitors;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Website Traffic",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: _stat("Today", todayVisitors.toString(), Colors.blue),
                ),

                Expanded(
                  child: _stat("Total", totalVisitors.toString(), Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(String title, String value, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: .15),
          child: Icon(Icons.people, color: color),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        Text(title),
      ],
    );
  }
}
