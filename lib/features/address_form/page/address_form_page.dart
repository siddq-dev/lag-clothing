import 'package:flutter/material.dart';

import '../../../layout/website_layout.dart';
import '../../../routes/app_routes.dart';

import '../../../themes/app_spacing.dart';
import '../../../themes/app_text_style.dart';

import '../widgets/address_form.dart';

class AddressFormPage extends StatelessWidget {
  const AddressFormPage({
    super.key,
    this.isEditing = false,
  });

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
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
                maxWidth: 850,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Back Button + Title
                  Row(
                    children: [

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        isEditing
                            ? "EDIT ADDRESS"
                            : "ADD ADDRESS",
                        style: AppTextStyles.heading1.copyWith(
                          color: Colors.white,
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: AppSpacing.md),

                  Padding(
                    padding: const EdgeInsets.only(left: 52),
                    child: Text(
                      isEditing
                          ? "Update your delivery address."
                          : "Please enter your delivery details.",
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white12,
                      ),
                    ),
                    child: AddressForm(
                      isEditing: isEditing,
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