import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AuthOrContinueText extends StatelessWidget {
  const AuthOrContinueText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.border),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Կամ շարունակիր',
            style: AppTextStyles.labelSmall.copyWith(fontSize: 11),
          ),
        ),
        const Expanded(
          child: Divider(color: AppColors.border),
        ),
      ],
    );
  }
}
