import 'package:flutter/material.dart';

import '/providers/product_management_provider.dart';

class ProductStatistics extends StatelessWidget {
  const ProductStatistics({super.key, required this.provider});

  final ProductManagementProvider provider;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    final cards = [
      _StatisticData(
        title: 'Products',
        value: provider.totalProducts.toString(),
        icon: Icons.inventory_2_outlined,
        color: Colors.blue,
      ),
      _StatisticData(
        title: 'Active',
        value: provider.activeProducts.toString(),
        icon: Icons.check_circle_outline,
        color: Colors.green,
      ),
      _StatisticData(
        title: 'Inactive',
        value: provider.inactiveProducts.toString(),
        icon: Icons.cancel_outlined,
        color: Colors.red,
      ),
    ];

    if (isMobile) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cards.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.45,
        ),
        itemBuilder: (context, index) {
          return _card(cards[index]);
        },
      );
    }

    return Row(
      children: [
        for (int i = 0; i < cards.length; i++) ...[
          Expanded(child: _card(cards[i])),
          if (i != cards.length - 1) const SizedBox(width: 20),
        ],
      ],
    );
  }

  Widget _card(_StatisticData data) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: data.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(data.icon, color: data.color, size: 26),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    data.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticData {
  const _StatisticData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
}
