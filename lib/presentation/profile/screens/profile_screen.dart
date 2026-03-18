import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/auth/bloc/auth_bloc.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _buildProfileHeader(),
                const SizedBox(height: 32),
                _buildMenuItems(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.background,
            size: 32,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Հյուր', style: AppTextStyles.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'guest@example.com',
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final items = [
      _MenuItem(
          icon: Icons.directions_car_outlined,
          title: 'Իմ հրապարակումները',
          onTap: () {}),
      _MenuItem(icon: Icons.settings_outlined, title: 'Կարգավորումներ', onTap: () {}),
      _MenuItem(icon: Icons.help_outline_rounded, title: 'Օգնություն', onTap: () {}),
      _MenuItem(
        icon: Icons.logout_rounded,
        title: 'Դուրս գալ',
        isDestructive: true,
        onTap: () {
          // context.read<AuthBloc>().add(const AuthSignOutRequested());
          // context.router.replaceAll([const AuthRoute()]);
        },
      ),
    ];

    return Column(
      children: items.map((item) => _buildMenuItem(context, item)).toList(),
    );
  }

  Widget _buildMenuItem(BuildContext context, _MenuItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: item.isDestructive
                  ? AppColors.error
                  : AppColors.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              item.title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: item.isDestructive
                    ? AppColors.error
                    : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textHint,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });
}
