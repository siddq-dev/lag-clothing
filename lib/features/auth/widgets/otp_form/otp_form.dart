import 'package:flutter/material.dart';

import '../../../../themes/app_colors.dart';
import '../../../../themes/app_text_style.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.destination,
    required this.isPhone,
  });

  final String destination;
  final bool isPhone;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {

  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  int seconds = 30;

  @override
  void dispose() {

    for (var controller in otpControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: otpControllers[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: "",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColors.background,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(50),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  "OTP Verification",
                  style: AppTextStyles.heading2,
                ),

                const SizedBox(height: 15),

                Text(
                  widget.isPhone
                      ? "We've sent a verification code to"
                      : "We've sent a verification email to",
                ),

                const SizedBox(height: 8),

                Text(
                  widget.destination,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => otpBox(index),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Text(
                      "Didn't receive OTP?",
                    ),

                    TextButton(
                      onPressed: seconds == 0
                          ? () {}
                          : null,
                      child: Text(
                        seconds == 0
                            ? "Resend OTP"
                            : "Resend in ${seconds}s",
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // Verify OTP
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      "VERIFY OTP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}