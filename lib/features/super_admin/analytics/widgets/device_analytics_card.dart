import 'package:flutter/material.dart';

import '/models/device_analytics_model.dart';

class DeviceAnalyticsCard extends StatelessWidget {
  const DeviceAnalyticsCard({super.key, required this.devices});

  final List<DeviceAnalyticsModel> devices;

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
              "Visitors by Device",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ...devices.map(
              (device) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(child: Text(device.device)),

                    SizedBox(
                      width: 120,
                      child: LinearProgressIndicator(
                        value: device.percentage / 100,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Text("${device.percentage.toStringAsFixed(1)}%"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
