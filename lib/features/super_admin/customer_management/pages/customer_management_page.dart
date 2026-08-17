import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../routes/app_routes.dart';

import '/providers/customer_management_provider.dart';

import '../widgets/customer_table.dart';

import '../../dashboard/widgets/super_admin_sidebar.dart';

class CustomerManagementPage extends StatefulWidget {
  const CustomerManagementPage({super.key});

  @override
  State<CustomerManagementPage> createState() => _CustomerManagementPageState();
}

class _CustomerManagementPageState extends State<CustomerManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isMobileSidebarOpen = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<CustomerManagementProvider>().listenCustomers();
    });
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // MOBILE SIDEBAR
  // ============================================================

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

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final isMobile = width < 600;

    if (isMobile) {
      return _buildMobile();
    }

    return _buildDesktop();
  }

  // ============================================================
  // DESKTOP
  // ============================================================

  Widget _buildDesktop() {
    final provider = context.watch<CustomerManagementProvider>();

    final customers = provider.searchCustomers(_searchController.text);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // ========================================================
          // SIDEBAR
          // ========================================================
          const SizedBox(
            width: 260,
            child: SuperAdminSidebar(
              currentRoute: AppRouter.customerManagement,
            ),
          ),

          // ========================================================
          // CONTENT
          // ========================================================
          Expanded(
            child: Container(
              color: Colors.black,
              child: provider.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    )
                  : _buildDesktopContent(customers),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DESKTOP CONTENT
  // ============================================================

  Widget _buildDesktopContent(dynamic customers) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Management',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Manage customer accounts and orders.',
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),

          const SizedBox(height: 30),

          _buildSearchField(),

          const SizedBox(height: 25),

          // ======================================================
          // CUSTOMER TABLE
          // ======================================================
          _buildCustomerTable(customers, isMobile: false),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // MOBILE
  // ============================================================

  Widget _buildMobile() {
    final provider = context.watch<CustomerManagementProvider>();

    final customers = provider.searchCustomers(_searchController.text);

    return Scaffold(
      backgroundColor: Colors.black,

      // ==========================================================
      // APP BAR
      // ==========================================================
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          tooltip: 'Menu',
          icon: const Icon(Icons.menu),
          onPressed: _openMobileSidebar,
        ),

        title: const Text(
          'Customer Management',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ==========================================================
      // BODY
      // ==========================================================
      body: Stack(
        children: [
          provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.red),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ------------------------------------------
                        // PAGE TITLE
                        // ------------------------------------------
                        const Text(
                          'Customers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Manage customer accounts and orders.',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),

                        const SizedBox(height: 20),

                        // ------------------------------------------
                        // SEARCH
                        // ------------------------------------------
                        const Text(
                          'Search Customers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 10),

                        _buildSearchField(),

                        const SizedBox(height: 20),

                        // ------------------------------------------
                        // CUSTOMER TABLE
                        // ------------------------------------------
                        _buildCustomerTable(customers, isMobile: true),
                      ],
                    ),
                  ),
                ),

          // ========================================================
          // MOBILE SIDEBAR
          // ========================================================
          if (_isMobileSidebarOpen)
            Positioned.fill(
              child: Row(
                children: [
                  // ==================================================
                  // SIDEBAR
                  // ==================================================
                  SizedBox(
                    width: 280,
                    child: Material(
                      color: Colors.black,
                      elevation: 12,
                      child: SafeArea(
                        child: SuperAdminSidebar(
                          isMobile: true,
                          currentRoute: AppRouter.customerManagement,
                          onClose: _closeMobileSidebar,
                        ),
                      ),
                    ),
                  ),

                  // ==================================================
                  // OVERLAY
                  // ==================================================
                  Expanded(
                    child: GestureDetector(
                      onTap: _closeMobileSidebar,
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // CUSTOMER TABLE
  // ============================================================

  Widget _buildCustomerTable(dynamic customers, {required bool isMobile}) {
    if (!isMobile) {
      return CustomerTable(customers: customers);
    }

    // ------------------------------------------------------------
    // MOBILE TABLE CONTAINER
    // ------------------------------------------------------------

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      padding: const EdgeInsets.all(8),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),

        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          physics: const BouncingScrollPhysics(),

          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 760),

            child: CustomerTable(customers: customers),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH FIELD
  // ============================================================

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,

      style: const TextStyle(color: Colors.white),

      decoration: InputDecoration(
        hintText: 'Search customer...',

        hintStyle: const TextStyle(color: Colors.white54),

        prefixIcon: const Icon(Icons.search, color: Colors.white70),

        filled: true,

        fillColor: Colors.grey.shade900,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
      ),

      onChanged: (_) {
        setState(() {});
      },
    );
  }
}
