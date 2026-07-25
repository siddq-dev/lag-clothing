import 'package:flutter/material.dart';

class SizeChart extends StatelessWidget {
  const SizeChart({super.key});

  TableRow buildRow(
    String size,
    String chest,
    String length,
    String shoulder,
  ) {
    return TableRow(
      children: [

        _cell(size, true),

        _cell(chest, false),

        _cell(length, false),

        _cell(shoulder, false),

      ],
    );
  }

  Widget _cell(String text, bool bold) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight:
              bold ? FontWeight.bold : FontWeight.normal,
        ),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Size Chart (cm)",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Table(
              border: TableBorder.all(
                color: Colors.grey.shade300,
              ),
              children: [

                buildRow(
                  "Size",
                  "Chest",
                  "Length",
                  "Shoulder",
                ),

                buildRow(
                  "XS",
                  "88",
                  "67",
                  "40",
                ),

                buildRow(
                  "S",
                  "94",
                  "70",
                  "42",
                ),

                buildRow(
                  "M",
                  "100",
                  "73",
                  "44",
                ),

                buildRow(
                  "L",
                  "106",
                  "75",
                  "46",
                ),

                buildRow(
                  "XL",
                  "112",
                  "77",
                  "48",
                ),

                buildRow(
                  "XXL",
                  "118",
                  "80",
                  "50",
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}