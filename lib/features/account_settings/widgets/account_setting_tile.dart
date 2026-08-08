import 'package:flutter/material.dart';

class AccountSettingTile extends StatelessWidget {
  final String title;
  final String subtitle;

  final bool value;

  final Function(bool) onChanged;

  const AccountSettingTile({
    super.key,

    required this.title,

    required this.subtitle,

    required this.value,

    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(
        color: Colors.grey.shade900,

        borderRadius: BorderRadius.circular(15),
      ),

      child: SwitchListTile(
        title: Text(
          title,

          style: const TextStyle(
            color: Colors.white,

            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),

        value: value,

        onChanged: onChanged,

        activeThumbColor: Colors.white,
      ),
    );
  }
}
