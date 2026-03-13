import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AuthRegisterLinkSection extends StatelessWidget {
  const AuthRegisterLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Չունե՞ս հաշիվ,  ",
          style:
              AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'Ստեղծիր նորը',
            style: AppTextStyles.accent.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
