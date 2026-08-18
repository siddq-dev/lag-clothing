import 'package:flutter/material.dart';

class InventoryFilterBar extends StatelessWidget {
  const InventoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return _buildMobileFilters();
        }

        return _buildDesktopFilters();
      },
    );
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktopFilters() {
    return Row(
      children: [
        _filterButton(label: 'All', isSelected: true),

        const SizedBox(width: 15),

        _filterButton(label: 'In Stock'),

        const SizedBox(width: 15),

        _filterButton(label: 'Low Stock'),

        const SizedBox(width: 15),

        _filterButton(label: 'Out of Stock'),
      ],
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobileFilters() {
    return Column(
      children: [
        // --------------------------------------------------------
        // ROW 1
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(child: _filterButton(label: 'All', isSelected: true)),

            const SizedBox(width: 10),

            Expanded(child: _filterButton(label: 'In Stock')),
          ],
        ),

        const SizedBox(height: 10),

        // --------------------------------------------------------
        // ROW 2
        // --------------------------------------------------------
        Row(
          children: [
            Expanded(child: _filterButton(label: 'Low Stock')),

            const SizedBox(width: 10),

            Expanded(child: _filterButton(label: 'Out of Stock')),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // FILTER BUTTON
  // ============================================================

  Widget _filterButton({required String label, bool isSelected = false}) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : const Color(0xFF1A1A1A),
          foregroundColor: isSelected ? Colors.white : Colors.white70,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isSelected
                  ? Colors.red
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
