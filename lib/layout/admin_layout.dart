import 'package:flutter/material.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({
    super.key,
    required this.currentRoute,
    required this.title,
    required this.child,
  });

  final String currentRoute;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111111),

      body: Row(
        children: [
          //-----------------------------------
          // Sidebar
          //-----------------------------------
          Container(
            width: 260,
            color: const Color(0xff181818),
            child: Column(
              children: [
                const SizedBox(height: 40),

                const Text(
                  "LAG ADMIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                _menuTile(Icons.dashboard, "Dashboard"),

                _menuTile(Icons.people, "Customers"),

                _menuTile(Icons.shopping_bag, "Products"),

                _menuTile(Icons.inventory, "Inventory"),

                _menuTile(Icons.receipt_long, "Orders"),

                _menuTile(Icons.analytics, "Analytics"),

                _menuTile(Icons.settings, "Settings"),
              ],
            ),
          ),

          //-----------------------------------
          // Main Content
          //-----------------------------------
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                    color: Color(0xff181818),
                    border: Border(
                      bottom: BorderSide(color: Color(0xff2A2A2A)),
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
