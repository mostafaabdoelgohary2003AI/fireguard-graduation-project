import 'package:flutter/material.dart';
import '../../feature/auth/forgot_password_screen.dart';

/// A reusable TextButton widget for triggering the forgot password flow.
/// This widget can be easily plugged into any login screen without modifying existing code.
/// On press, it navigates to the ForgotPasswordScreen using Navigator.push.
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
        );
      },
      child: const Text('Forgot Password?'),
    );
  }
}
