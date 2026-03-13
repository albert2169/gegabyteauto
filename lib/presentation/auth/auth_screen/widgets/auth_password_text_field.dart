import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AuthPasswordTextField extends StatefulWidget {
  final TextEditingController passwordTextFieldController;
  final FocusNode passwordTextFieldFocus;
  final Function() onSignIn;
  const AuthPasswordTextField(
      {super.key,
      required this.passwordTextFieldController,
      required this.onSignIn,
      required this.passwordTextFieldFocus});

  @override
  State<AuthPasswordTextField> createState() => _AuthPasswordTextFieldState();
}

class _AuthPasswordTextFieldState extends State<AuthPasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setFieldState) {
        return TextFormField(
          onTapOutside: (_) {
            widget.passwordTextFieldFocus.unfocus();
          },
          focusNode: widget.passwordTextFieldFocus,
          controller: widget.passwordTextFieldController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => widget.onSignIn(),
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Գաղտնաբառ',
            prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Գաղտնաբառը չի կարող լինել դատարկ';
            }
            if (value.length < 6) return 'Գրեք առնվազն 6 նիշ';
            return null;
          },
        );
      },
    );
  }
}
