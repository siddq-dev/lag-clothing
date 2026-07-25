import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../widgets/addresses_header/addresses_header.dart';
import '../widgets/add_address_button/add_address_button.dart';
import '../widgets/address_card/address_card.dart';
import '../widgets/empty_address/empty_address.dart';

class SavedAddressesPage extends StatelessWidget {
  const SavedAddressesPage({super.key});

  @override
  Widget build(BuildContext context) {

    /// Temporary Data
    final List<Map<String, dynamic>> addresses = [
      {
        "type": "Home",
        "name": "John Doe",
        "phone": "+91 9876543210",
        "line1": "123 ABC Street",
        "line2": "Apartment 2B",
        "city": "Chennai",
        "state": "Tamil Nadu",
        "pincode": "600001",
        "default": true,
      },
      {
        "type": "Office",
        "name": "John Doe",
        "phone": "+91 9876543210",
        "line1": "LAG Clothing Pvt Ltd",
        "line2": "Tidel Park",
        "city": "Chennai",
        "state": "Tamil Nadu",
        "pincode": "600113",
        "default": false,
      },
    ];

    return WebsiteLayout(
      currentRoute: AppRouter.profile,
      child: SingleChildScrollView(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Header
                  const AddressesHeader(),

                  const SizedBox(height: 35),

                  /// Add Address Button
                  AddAddressButton(
                    onPressed: () {
                      // Navigate to Address Form
                    },
                  ),

                  const SizedBox(height: 35),

                  if (addresses.isEmpty)

                    EmptyAddresses(
                      onAddAddress: () {},
                    )

                  else

                    ...addresses.map(
                      (address) => AddressCard(
                        addressType: address["type"],
                        name: address["name"],
                        phone: address["phone"],
                        addressLine1: address["line1"],
                        addressLine2: address["line2"],
                        city: address["city"],
                        state: address["state"],
                        pincode: address["pincode"],
                        isDefault: address["default"],
                        onEdit: () {},
                        onDelete: () {},
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