import 'package:flutter/material.dart';

import '/models/traffic_source_model.dart';

class TrafficSourceChart extends StatelessWidget {
  const TrafficSourceChart({super.key, required this.sources});

  final List<TrafficSourceModel> sources;

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
              "Traffic Sources",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sources.length,
              itemBuilder: (context, index) {
                final source = sources[index];

                return ListTile(
                  leading: const Icon(Icons.analytics),
                  title: Text(source.source),
                  trailing: Text(source.visitors.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
