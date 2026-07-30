import 'package:flutter/material.dart';

import '../../../../models/admin_permission_model.dart';

class AdminPermissionsSection extends StatelessWidget {
  const AdminPermissionsSection({
    super.key,
    required this.permissions,
    required this.onChanged,
  });

  final AdminPermissionModel permissions;

  final ValueChanged<AdminPermissionModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Permissions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildSwitch(
              title: "Dashboard",
              value: permissions.dashboard,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  dashboard: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Products",
              value: permissions.products,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  products: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Orders",
              value: permissions.orders,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  orders: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Customers",
              value: permissions.customers,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  customers: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Inventory",
              value: permissions.inventory,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  inventory: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Coupons",
              value: permissions.coupons,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  coupons: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Analytics",
              value: permissions.analytics,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  analytics: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Admins",
              value: permissions.admins,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  admins: value,
                ),
              ),
            ),

            _buildSwitch(
              title: "Settings",
              value: permissions.settings,
              onChanged: (value) => onChanged(
                permissions.copyWith(
                  settings: value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}