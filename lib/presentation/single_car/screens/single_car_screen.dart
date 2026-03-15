import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';

@RoutePage()
class SingleCarScreen extends StatefulWidget {
  final CarViewModel car;

  const SingleCarScreen({super.key, required this.car});

  @override
  State<SingleCarScreen> createState() => _SingleCarScreenState();
}

class _SingleCarScreenState extends State<SingleCarScreen> {
  int _currentImageIndex = 0;
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    final info = widget.car.singleCarInfoViewModel;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildImageSliver(context, info),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(info),
                  const SizedBox(height: 20),
                  _buildQuickStats(info),
                  const SizedBox(height: 24),
                  _buildDetailsSection(info),
                  const SizedBox(height: 24),
                  _buildDescriptionSection(info),
                  const SizedBox(height: 24),
                  _buildOwnerCard(info),
                  const SizedBox(height: 24),
                  _buildContactButton(info),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSliver(BuildContext context, dynamic info) {
    final images = info.images;
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: GestureDetector(
        onTap: () => context.maybePop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.8),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded,
              color: AppColors.textPrimary, size: 20),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isSaved = !_isSaved),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.8),
              shape: BoxShape.circle,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Icon(
                _isSaved
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                key: ValueKey(_isSaved),
                color: _isSaved ? AppColors.error : AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image carousel
            PageView.builder(
              itemCount: images.isEmpty ? 1 : images.length,
              onPageChanged: (i) => setState(() => _currentImageIndex = i),
              itemBuilder: (context, i) {
                final imageUrl =
                    images.isNotEmpty ? images[i].networkImageUrl : null;
                if (imageUrl != null) {
                  return CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Shimmer.fromColors(
                      baseColor: AppColors.surfaceVariant,
                      highlightColor: AppColors.surface,
                      child: Container(color: Colors.white),
                    ),
                    errorWidget: (_, __, ___) => _fallbackImage(),
                  );
                }
                return _fallbackImage();
              },
            ),
            // Gradient overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.background,
                    ],
                  ),
                ),
              ),
            ),
            // Page indicator
            if (images.length > 1)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(images.length, (i) {
                    final isActive = i == _currentImageIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color:
                            isActive ? AppColors.primary : AppColors.textHint,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.directions_car_rounded,
        color: AppColors.textHint,
        size: 80,
      ),
    );
  }

  Widget _buildTitleSection(dynamic info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${info.brand} ${info.model}',
                    style: AppTextStyles.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.car.seria,
                    style: AppTextStyles.bodyLarge
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            Text(info.price, style: AppTextStyles.price),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on_outlined,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              info.carOwnerInfoViewModel.city,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.access_time_rounded,
                size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(
              info.carOwnerInfoViewModel.lastUpdate,
              style: AppTextStyles.bodySmall
                  .copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickStats(dynamic info) {
    final stats = [
      ('Year', info.year, Icons.calendar_today_rounded),
      ('Mileage', info.mileage, Icons.speed_rounded),
      ('Gearbox', info.gearBox, Icons.settings_rounded),
      ('Condition', info.condition, Icons.star_rounded),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.8,
      children: stats.map((stat) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            children: [
              Icon(stat.$3, size: 14, color: AppColors.primary),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(stat.$1,
                        style: AppTextStyles.labelSmall.copyWith(fontSize: 9)),
                    const SizedBox(height: 1),
                    Text(
                      stat.$2,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDetailsSection(dynamic info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Specifications', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: Column(
            children: [
              _DetailRow('Engine', info.engine, isFirst: true),
              _DetailRow('Engine Volume', info.engineVolume),
              _DetailRow('Color', info.color),
              _DetailRow('Interior', info.interior),
              _DetailRow('Gearbox', info.gearBox),
              _DetailRow('Condition', info.condition, isLast: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(dynamic info) {
    if (info.description.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 12),
        Text(
          info.description,
          style: AppTextStyles.bodyMedium
              .copyWith(color: AppColors.textSecondary, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildOwnerCard(dynamic info) {
    final owner = info.carOwnerInfoViewModel;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: const Icon(Icons.person_rounded,
                color: AppColors.background, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(owner.name, style: AppTextStyles.headlineSmall),
                const SizedBox(height: 3),
                Text(
                  '${owner.city} • ${owner.releaseDate}',
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(dynamic info) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone_rounded,
                      color: AppColors.background, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Call Owner',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.background,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 0.5),
          ),
          child: const Icon(Icons.chat_bubble_outline_rounded,
              color: AppColors.primary, size: 22),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isFirst;
  final bool isLast;

  const _DetailRow(
    this.label,
    this.value, {
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFirst) const Divider(height: 1, indent: 18, endIndent: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textSecondary),
              ),
              Text(
                value,
                style: AppTextStyles.labelLarge.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
