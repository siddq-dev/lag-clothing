import 'package:flutter/material.dart';

class TermsCheckbox extends StatefulWidget {
  const TermsCheckbox({
    super.key,
  });

  @override
  State<TermsCheckbox> createState() =>
      _TermsCheckboxState();
}

class _TermsCheckboxState
    extends State<TermsCheckbox> {

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: accepted,

      onChanged: (value) {
        setState(() {
          accepted = value ?? false;
        });
      },

      title: const Text(
        "I agree to the Terms & Conditions",
      ),

      controlAffinity:
          ListTileControlAffinity.leading,
    );
  }
}