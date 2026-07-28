import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../layout/website_layout.dart';
import '../../../providers/address_provider.dart';
import '../../../routes/app_routes.dart';

import '../widgets/addresses_header/addresses_header.dart';
import '../widgets/add_address_button/add_address_button.dart';
import '../widgets/address_card/address_card.dart';
import '../widgets/empty_address/empty_address.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() =>
      _SavedAddressesPageState();
}

class _SavedAddressesPageState
    extends State<SavedAddressesPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<AddressProvider>().listenAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AddressProvider>();

    final addresses = provider.addresses;

    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 40,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1100,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        /// Header
                        const AddressesHeader(),

                        const SizedBox(height: 35),

                        /// Add Address
                        AddAddressButton(
                          onPressed: () {
                            context.go(
                              AppRouter.addAddress,
                            );
                          },
                        ),

                        const SizedBox(height: 35),

                        /// Empty State
                        if (addresses.isEmpty)
                          EmptyAddresses(
                            onAddAddress: () {
                              context.go(
                                AppRouter.addAddress,
                              );
                            },
                          )

                        /// Address List
                        else
                          ...addresses.map(
                            (address) => Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: AddressCard(
                                addressType:
                                    address.addressType.name,

                                name: address.fullName,

                                phone: address.phone,

                                addressLine1:
                                    address.addressLine1,

                                addressLine2:
                                    address.addressLine2,

                                city: address.city,

                                state: address.state,

                                pincode:
                                    address.pincode,

                                isDefault:
                                    address.isDefault,

                                onEdit: () {
                                  context.go(
                                    AppRouter.editAddress,
                                    extra: address,
                                  );
                                },

                                onDelete: () async {
                                  final confirm =
                                      await showDialog<bool>(
                                    context: context,
                                    builder: (_) =>
                                        AlertDialog(
                                      title: const Text(
                                        "Delete Address",
                                      ),
                                      content:
                                          const Text(
                                        "Are you sure you want to delete this address?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                false);
                                          },
                                          child:
                                              const Text(
                                            "Cancel",
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context,
                                                true);
                                          },
                                          child:
                                              const Text(
                                            "Delete",
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm ==
                                      true) {
                                    await provider
                                        .deleteAddress(
                                      address.id,
                                    );

                                    if (!mounted) {
                                      return;
                                    }

                                    ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Address Deleted Successfully",
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}