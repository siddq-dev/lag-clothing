import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingSocialButtons extends StatelessWidget {
  const FloatingSocialButtons({super.key});

  // ================================================================
  // REPLACE THESE TWO VALUES
  // ================================================================

  static const String whatsappNumber = '+917338824433';

  static const String instagramUrl =
      'https://www.instagram.com/lagclothing2.0?igsh=MXB0eXY3a3E5Zmhoag==';

  // ================================================================
  // WHATSAPP
  // ================================================================

  Future<void> _openWhatsApp() async {
    final String message = Uri.encodeComponent(
      'Hello LAG Clothing! I would like to know more about your jerseys.',
    );

    final Uri uri = Uri.parse('https://wa.me/$whatsappNumber?text=$message');

    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  // ================================================================
  // INSTAGRAM
  // ================================================================

  Future<void> _openInstagram() async {
    final Uri uri = Uri.parse(instagramUrl);

    await launchUrl(uri, mode: LaunchMode.platformDefault);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 22,
      bottom: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ============================================================
          // INSTAGRAM
          // ============================================================
          _SocialButton(
            icon: Icons.camera_alt_outlined,
            backgroundColor: const Color(0xFFE1306C),
            tooltip: 'Instagram',
            onPressed: _openInstagram,
          ),

          const SizedBox(height: 12),

          // ============================================================
          // WHATSAPP
          // ============================================================
          _SocialButton(
            icon: Icons.chat,
            backgroundColor: const Color(0xFF25D366),
            tooltip: 'WhatsApp',
            onPressed: _openWhatsApp,
          ),
        ],
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final String tooltip;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.backgroundColor,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: backgroundColor,
        shape: const CircleBorder(),
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.25),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 56,
            height: 56,
            child: Center(child: Icon(icon, color: Colors.white, size: 27)),
          ),
        ),
      ),
    );
  }
}
