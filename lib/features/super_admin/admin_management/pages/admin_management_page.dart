import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../dashboard/widgets/super_admin_sidebar.dart';
import '../widgets/admin_list_table.dart';

class AdminManagementPage extends StatefulWidget {
  const AdminManagementPage({super.key});

  @override
  State<AdminManagementPage> createState() => _AdminManagementPageState();
}

class _AdminManagementPageState extends State<AdminManagementPage> {
  bool _isMobileSidebarOpen = false;

  // ================================================================
  // MOBILE SIDEBAR
  // ================================================================

  void _openMobileSidebar() {
    setState(() {
      _isMobileSidebarOpen = true;
    });
  }

  void _closeMobileSidebar() {
    if (!mounted) return;

    setState(() {
      _isMobileSidebarOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ============================================================
          // MAIN PAGE
          // ============================================================
          if (isMobile) _buildMobile(context) else _buildDesktop(context),

          // ============================================================
          // MOBILE SIDEBAR OVERLAY
          // ============================================================
          if (isMobile && _isMobileSidebarOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMobileSidebar,
                child: Container(color: Colors.black.withValues(alpha: 0.65)),
              ),
            ),

          // ============================================================
          // MOBILE SIDEBAR
          // ============================================================
          if (isMobile && _isMobileSidebarOpen)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                width: 285,
                child: Material(
                  color: Colors.black,
                  elevation: 20,
                  child: SafeArea(
                    child: SuperAdminSidebar(
                      isMobile: true,
                      onClose: _closeMobileSidebar,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ================================================================
  // DESKTOP UI
  // ================================================================

  Widget _buildDesktop(BuildContext context) {
    return Row(
      children: [
        const SuperAdminSidebar(),

        Expanded(
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ======================================================
                // HEADER
                // ======================================================
                Row(
                  children: [
                    const Text(
                      'Admin Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.push(AppRouter.addAdmin);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Admin'),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ======================================================
                // TABLE
                // ======================================================
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AdminListTable(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // MOBILE UI
  // ================================================================

  Widget _buildMobile(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ==========================================================
          // MOBILE HEADER
          // ==========================================================
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.black,
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Menu',
                  onPressed: _openMobileSidebar,
                  icon: const Icon(Icons.menu, color: Colors.white, size: 29),
                ),

                const SizedBox(width: 6),

                const Expanded(
                  child: Text(
                    'Admin Management',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  tooltip: 'Add Admin',
                  onPressed: () {
                    context.push(AppRouter.addAdmin);
                  },
                  icon: const Icon(Icons.person_add_alt_1, color: Colors.white),
                ),
              ],
            ),
          ),

          // ==========================================================
          // CONTENT
          // ==========================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ====================================================
                  // TITLE
                  // ====================================================
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Administrators',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      ElevatedButton.icon(
                        onPressed: () {
                          context.push(AppRouter.addAdmin);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'Add Admin',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ====================================================
                  // TABLE
                  // ====================================================
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              // IMPORTANT:
                              // Keep the table wide enough so the
                              // Action column does not disappear.
                              width: 900,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: AdminListTable(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ====================================================
                  // MOBILE TABLE HINT
                  // ====================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.swipe, color: Colors.white54, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Swipe left/right to view all columns',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
