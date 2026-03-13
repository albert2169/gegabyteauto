import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_social_button.dart';

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: AuthSocialButton(
                icon: Icons.g_mobiledata_rounded, label: 'Google')),
        const SizedBox(width: 12),
        Expanded(child: AuthSocialButton(icon: Icons.apple, label: 'Apple')),
      ],
    );
  }
}