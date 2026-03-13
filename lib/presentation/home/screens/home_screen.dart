import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildSearchBar(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Explore'),
                  const SizedBox(height: 16),
                  _buildMainSections(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Premium Picks'),
                  const SizedBox(height: 16),
                  _buildFeaturedCard(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Categories'),
                  const SizedBox(height: 16),
                  _buildCategories(context),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      floating: true,
      titleSpacing: 20,
      title: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning 👋',
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 2),
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.primaryGradient.createShader(bounds),
                child: Text(
                  'GEGABYTE AUTO',
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: AppColors.textSecondary,
                size: 22,
              ),
              constraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 44,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const AllCarsRoute()),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.search_rounded,
                color: AppColors.textHint, size: 20),
            const SizedBox(width: 12),
            Text(
              'Search by brand, model, year...',
              style:
                  AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.headlineMedium),
        TextButton(
          onPressed: () {},
          child: Text('See all', style: AppTextStyles.accent),
        ),
      ],
    );
  }

  Widget _buildMainSections(BuildContext context) {
    final sections = [
      _SectionData(
        icon: Icons.directions_car_rounded,
        title: 'Shop by Model',
        subtitle: 'All brands',
        color: const Color(0xFF2A2040),
        accentColor: const Color(0xFF9B7DDC),
        onTap: () => context.pushRoute(const BrandsRoute()),
      ),
      _SectionData(
        icon: Icons.list_rounded,
        title: 'Browse All',
        subtitle: '50+ cars',
        color: const Color(0xFF1A2A2A),
        accentColor: const Color(0xFF4ECDC4),
        onTap: () => context.pushRoute(const AllCarsRoute()),
      ),
      _SectionData(
        icon: Icons.sell_rounded,
        title: 'Sell My Car',
        subtitle: 'Quick listing',
        color: const Color(0xFF2A1A1A),
        accentColor: AppColors.primary,
        onTap: () {},
      ),
      _SectionData(
        icon: Icons.tune_rounded,
        title: 'Compare',
        subtitle: 'Side by side',
        color: const Color(0xFF1A1A2A),
        accentColor: const Color(0xFF7DC4FF),
        onTap: () {},
      ),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.45,
      children: sections.map((s) => _SectionCard(data: s)).toList(),
    );
  }

  Widget _buildFeaturedCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pushRoute(const AllCarsRoute()),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF1C1520), Color(0xFF2A1C10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'FEATURED',
                      style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontSize: 9,
                          letterSpacing: 1.5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Premium Collection',
                      style: AppTextStyles.headlineSmall),
                  const SizedBox(height: 6),
                  Text(
                    'Explore luxury vehicles\ncurated just for you',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'View All',
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.directions_car_filled_rounded,
              size: 90,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      ('Sedan', Icons.directions_car_rounded),
      ('SUV', Icons.airport_shuttle_rounded),
      ('Coupe', Icons.time_to_leave_rounded),
      ('Electric', Icons.electric_car_rounded),
      ('Luxury', Icons.star_rounded),
      ('Sports', Icons.speed_rounded),
    ];

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return _CategoryChip(label: cat.$1, icon: cat.$2);
        },
      ),
    );
  }
}

class _SectionData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color accentColor;
  final VoidCallback onTap;

  const _SectionData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.accentColor,
    required this.onTap,
  });
}

class _SectionCard extends StatelessWidget {
  final _SectionData data;

  const _SectionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: data.color,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: data.accentColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: data.accentColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(data.icon, color: data.accentColor, size: 18),
            ),
            const Spacer(),
            Text(data.title,
                style: AppTextStyles.headlineSmall.copyWith(fontSize: 14)),
            const SizedBox(height: 2),
            Text(data.subtitle,
                style: AppTextStyles.bodySmall.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(fontSize: 9.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
