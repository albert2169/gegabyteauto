import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

class CategoriesSectionHeader extends StatelessWidget {
  const CategoriesSectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Կատեգորիաներ', style: AppTextStyles.headlineMedium),
        TextButton(
          onPressed: () {},
          child: Text('Տեսնել բոլորը', style: AppTextStyles.accent),
        ),
      ],
    );
  }
}
