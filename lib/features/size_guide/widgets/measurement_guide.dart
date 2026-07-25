import 'package:flutter/material.dart';

class MeasurementGuide extends StatelessWidget {
  const MeasurementGuide({super.key});

  Widget buildStep(
    IconData icon,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          CircleAvatar(
            radius: 24,
            child: Icon(icon),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,
                  style: const TextStyle(
                    height: 1.6,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "How to Measure Yourself",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            buildStep(
              Icons.accessibility_new,
              "Chest",
              "Measure around the fullest part of your chest while keeping the measuring tape horizontal.",
            ),

            buildStep(
              Icons.straighten,
              "Shoulder",
              "Measure from one shoulder edge to the other across your upper back.",
            ),

            buildStep(
              Icons.height,
              "Length",
              "Measure from the highest shoulder point straight down to the bottom of the jersey.",
            ),

          ],
        ),
      ),
    );
  }
}