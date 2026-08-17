import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),

        onPressed: () async {
          final user = FirebaseAuth.instance.currentUser;

          if (user != null) {
            await user.delete();
          }
        },

        child: const Text(
          "Delete Account",

          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
