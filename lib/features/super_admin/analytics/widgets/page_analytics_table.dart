import 'package:flutter/material.dart';

import '/models/page_analytics_model.dart';

class PageAnalyticsTable extends StatelessWidget {
  const PageAnalyticsTable({
    super.key,
    required this.pages,
  });

  final List<PageAnalyticsModel> pages;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              "Page Analytics",
              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            DataTable(
              columns: const [
                DataColumn(
                  label: Text("Page"),
                ),
                DataColumn(
                  label: Text("Views"),
                ),
                DataColumn(
                  label: Text("Visitors"),
                ),
                DataColumn(
                  label: Text("Avg Time"),
                ),
              ],
              rows: pages
                  .map(
                    (page) => DataRow(
                      cells: [
                        DataCell(
                          Text(page.page),
                        ),
                        DataCell(
                          Text(
                            page.views.toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            page.uniqueVisitors
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            "${page.averageTime.toStringAsFixed(1)} sec",
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}