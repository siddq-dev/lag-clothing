import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/notification_settings_model.dart';
import '../../../providers/notification_provider.dart';

class SaveNotificationButton extends StatefulWidget {
  const SaveNotificationButton({
    super.key,
    required this.provider,
    required this.settings,
  });

  final NotificationProvider provider;
  final NotificationSettingsModel settings;

  @override
  State<SaveNotificationButton> createState() => _SaveNotificationButtonState();
}

class _SaveNotificationButtonState extends State<SaveNotificationButton> {
  bool loading = false;

  Future<void> saveSettings() async {
    try {
      setState(() {
        loading = true;
      });

      await widget.provider.updateSettings(widget.settings);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Notification settings updated successfully"),
        ),
      );

      context.pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: loading ? null : saveSettings,
        child: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
            : const Text(
                "SAVE SETTINGS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
