import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../routes/app_routes.dart';
import '/providers/admin_management_provider.dart';

class AdminListTable extends StatefulWidget {
  const AdminListTable({super.key});

  @override
  State<AdminListTable> createState() => _AdminListTableState();
}

class _AdminListTableState extends State<AdminListTable> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AdminManagementProvider>().loadAdmins();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AdminManagementProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.admins.isEmpty) {
      return const Center(child: Text("No Admin Accounts Found"));
    }

    return SingleChildScrollView(
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Name")),

          DataColumn(label: Text("Email")),

          DataColumn(label: Text("Phone")),

          DataColumn(label: Text("Role")),

          DataColumn(label: Text("Status")),

          DataColumn(label: Text("Actions")),
        ],

        rows: provider.admins.map((admin) {
          return DataRow(
            cells: [
              DataCell(Text(admin.name)),

              DataCell(Text(admin.email)),

              DataCell(Text(admin.phone)),

              DataCell(Text(admin.role.name)),

              DataCell(
                Switch(
                  value: admin.status,
                  onChanged: (value) async {
                    await provider.updateStatus(uid: admin.uid, status: value);
                  },
                ),
              ),

              DataCell(
                Row(
                  children: [
                    // edit
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        context.push(AppRouter.editAdmin, extra: admin);
                      },
                    ),

                    IconButton(
                      icon: const Icon(Icons.lock_reset),
                      tooltip: "Reset Password",
                      onPressed: () async {
                        await provider.sendPasswordReset(admin.email);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Password reset email sent to ${admin.email}",
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    // delete
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text("Delete Admin"),
                              content: const Text(
                                "Are you sure you want to delete this admin?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancel"),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );

                        if (confirm == true) {
                          await provider.deleteAdmin(admin.uid);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
