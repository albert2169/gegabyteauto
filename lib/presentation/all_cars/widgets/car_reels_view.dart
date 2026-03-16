import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:shimmer/shimmer.dart';

class CarReelsView extends StatelessWidget {
  final List<CarViewModel> cars;

  const CarReelsView({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return _ReelPage(car: cars[index]);
        },
      ),
    );
  }
}

class _ReelPage extends StatelessWidget {
  final CarViewModel car;

  const _ReelPage({required this.car});

  @override
  Widget build(BuildContext context) {
    final info = car.singleCarInfoViewModel;
    final imageUrl =
        info.images.isNotEmpty ? info.images.first.networkImageUrl : null;

    return GestureDetector(
      onTap: () => context.pushRoute(SingleCarRoute(car: car)),
      child: Stack(
        alignment: AlignmentGeometry.center,
        fit: StackFit.expand,
        children: [
          imageUrl != null && imageUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Shimmer.fromColors(
                    baseColor: AppColors.surfaceVariant,
                    highlightColor: AppColors.surface,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (_, __, ___) => _imageFallback(),
                )
              : _imageFallback(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Color(0xCC000000),
                  Color(0xEE000000),
                ],
                stops: [0, 0.4, 0.75, 1],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 70,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  info.price,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${info.brand} ${info.model}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  car.seria,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _infoChip(info.year),
                    _infoChip(info.gearBox),
                    _infoChip(info.engine),
                    _infoChip(info.color),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _SidebarButton(
                    onTap: () {},
                    icon: Icons.favorite_border_rounded,
                    label: 'Like',
                  ),
                  const SizedBox(height: 20),
                  _SidebarButton(
                    onTap: () {},
                    icon: Icons.reply,
                    label: 'Share',
                  ),
                  const SizedBox(height: 20),
                  _SidebarButton(
                    onTap: () {},
                    icon: Icons.bookmark_border_rounded,
                    label: 'Save',
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: Colors.white38,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Center(
        child: Icon(Icons.directions_car_rounded,
            color: AppColors.textHint, size: 64),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SidebarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  const _SidebarButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
