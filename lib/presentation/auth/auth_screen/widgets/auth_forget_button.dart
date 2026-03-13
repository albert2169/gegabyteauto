import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AuthForgetButton extends StatelessWidget {
  const AuthForgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Վերականգնել Գաղտնաբառը',
          style: AppTextStyles.accent.copyWith(fontSize: 13),
        ),
      ),
    );
  }
}
