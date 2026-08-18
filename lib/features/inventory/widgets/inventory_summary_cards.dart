import 'package:flutter/material.dart';

import '/providers/inventory_provider.dart';

class InventorySummaryCards extends StatelessWidget {
  const InventorySummaryCards({super.key, required this.provider});

  final InventoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Mobile / small tablet
        if (width < 600) {
          return _buildMobileCards();
        }

        // Desktop
        return _buildDesktopCards();
      },
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktopCards() {
    return Row(
      children: [
        Expanded(
          child: _card(
            title: 'Products',
            value: provider.totalProducts.toString(),
            color: Colors.blue,
            icon: Icons.inventory_2_outlined,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            title: 'In Stock',
            value: provider.inStock.toString(),
            color: Colors.green,
            icon: Icons.check_circle_outline,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            title: 'Low Stock',
            value: provider.lowStock.toString(),
            color: Colors.orange,
            icon: Icons.warning_amber_rounded,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            title: 'Out of Stock',
            value: provider.outOfStock.toString(),
            color: Colors.red,
            icon: Icons.cancel_outlined,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: _card(
            title: 'Inventory Value',
            value: '₹${provider.inventoryValue.toStringAsFixed(0)}',
            color: Colors.purple,
            icon: Icons.currency_rupee,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobileCards() {
    return Column(
      children: [
        // --------------------------------------------------------
        // ROW 1
        // Products + In Stock
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: _mobileCard(
                title: 'Products',
                value: provider.totalProducts.toString(),
                color: Colors.blue,
                icon: Icons.inventory_2_outlined,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _mobileCard(
                title: 'In Stock',
                value: provider.inStock.toString(),
                color: Colors.green,
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // --------------------------------------------------------
        // ROW 2
        // Low Stock + Out of Stock
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: _mobileCard(
                title: 'Low Stock',
                value: provider.lowStock.toString(),
                color: Colors.orange,
                icon: Icons.warning_amber_rounded,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _mobileCard(
                title: 'Out of Stock',
                value: provider.outOfStock.toString(),
                color: Colors.red,
                icon: Icons.cancel_outlined,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // --------------------------------------------------------
        // ROW 3
        // Inventory Value
        // --------------------------------------------------------
        _mobileWideCard(
          title: 'Inventory Value',
          value: '₹${provider.inventoryValue.toStringAsFixed(0)}',
          color: Colors.purple,
          icon: Icons.currency_rupee,
        ),
      ],
    );
  }

  // ============================================================
  // DESKTOP CARD
  // ============================================================

  Widget _card({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 145),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 21),
          ),

          const SizedBox(height: 12),

          // Value
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          // Title
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE SMALL CARD
  // ============================================================

  Widget _mobileCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ------------------------------------------------------
          // ICON
          // ------------------------------------------------------
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 19),
          ),

          const SizedBox(height: 8),

          // ------------------------------------------------------
          // VALUE
          // ------------------------------------------------------
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE WIDE CARD
  // ============================================================

  Widget _mobileWideCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      height: 92,
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          // ------------------------------------------------------
          // ICON
          // ------------------------------------------------------
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 21),
          ),

          const SizedBox(width: 14),

          // ------------------------------------------------------
          // TITLE
          // ------------------------------------------------------
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // ------------------------------------------------------
          // VALUE
          // ------------------------------------------------------
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
