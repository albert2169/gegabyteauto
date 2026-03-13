import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_email_text_field.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_forget_button.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_or_continue_text.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_password_text_field.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_sign_in_button.dart';
import 'package:gegabyteauto/presentation/auth/auth_screen/widgets/auth_social_buttons.dart';

class AuthSignInFormCard extends StatelessWidget {
  final Key formKey;
  final Function() onSignIn;
  final TextEditingController emailTextFieldController;
  final TextEditingController passwordTextFieldController;
  final FocusNode emailTextFieldFocus;
  final FocusNode passwordTextFieldFocus;
  const AuthSignInFormCard({
    super.key,
    required this.emailTextFieldController,
    required this.passwordTextFieldController,
    required this.onSignIn,
    required this.formKey,
    required this.emailTextFieldFocus,
    required this.passwordTextFieldFocus,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.border.withValues(alpha: 0.8),
              width: 0.5,
            ),
          ),
          padding: const EdgeInsets.all(28),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AuthEmailTextField(
                  emailTextFieldFocus: emailTextFieldFocus,
                  emailTextFieldController: emailTextFieldController,
                ),
                const SizedBox(height: 16),
                AuthPasswordTextField(
                  passwordTextFieldFocus: passwordTextFieldFocus,
                  passwordTextFieldController: passwordTextFieldController,
                  onSignIn: onSignIn,
                ),
                const SizedBox(height: 12),
                AuthForgetButton(),
                const SizedBox(height: 28),
                AuthSignInButton(onSignIn: onSignIn),
                const SizedBox(height: 24),
                AuthOrContinueText(),
                const SizedBox(height: 20),
                AuthSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
