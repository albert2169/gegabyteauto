import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AuthEmailTextField extends StatelessWidget {
  final TextEditingController emailTextFieldController;
  final FocusNode emailTextFieldFocus;
  const AuthEmailTextField(
      {super.key,
      required this.emailTextFieldController,
      required this.emailTextFieldFocus});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) {
        emailTextFieldFocus.unfocus();
      },
      focusNode: emailTextFieldFocus,
      controller: emailTextFieldController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      style: AppTextStyles.bodyMedium,
      decoration: const InputDecoration(
        hintText: 'Մուտքանոն',
        prefixIcon: Icon(Icons.email_outlined, size: 20),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Մուտքանունը չի կարող լինել դատարկ';
        if (!value.contains('@')) return 'Սխալ մուտքային տվյալներ';
        return null;
      },
    );
  }
}
