import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Gegabyte', style: AppTextStyles.displayMedium.copyWith()),
        const SizedBox(width: 4),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'auto',
              style: AppTextStyles.displayMedium
                  .copyWith(fontWeight: FontWeight.w400),
            ),
          ),
        )
      ],
    );
  }
}
