import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:shimmer/shimmer.dart';

class AllCarsListView extends StatelessWidget {
  final List<CarViewModel> cars;

  const AllCarsListView({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CarsBloc>().add(const FetchAllCarsEvent());
      },
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      child: ListView.separated(
        key: const ValueKey('list'),
        padding: const EdgeInsets.all(16),
        itemCount: cars.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _CarCard(
            car: cars[index],
            onTap: () {
              context.pushRoute(SingleCarRoute(car: cars[index]));
            },
          );
        },
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  final CarViewModel car;
  final VoidCallback onTap;

  const _CarCard({required this.car, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final info = car.singleCarInfoViewModel;
    final imageUrl =
        info.images.isNotEmpty ? info.images.first.networkImageUrl : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              child: SizedBox(
                width: 130,
                height: 130,
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Shimmer.fromColors(
                          baseColor: AppColors.surfaceVariant,
                          highlightColor: AppColors.surface,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (_, __, ___) => const _CarImageFallback(),
                      )
                    : const _CarImageFallback(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${info.brand} ${info.model}',
                          style: AppTextStyles.headlineSmall
                              .copyWith(fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          car.seria,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _InfoBadge(label: info.year),
                        const SizedBox(width: 6),
                        _InfoBadge(label: info.gearBox),
                        const SizedBox(width: 6),
                        _InfoBadge(label: info.engine),
                      ],
                    ),
                    Text(
                      info.price,
                      style: AppTextStyles.price.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;

  const _InfoBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
      ),
    );
  }
}

class _CarImageFallback extends StatelessWidget {
  const _CarImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.directions_car_rounded,
        color: AppColors.textHint,
        size: 40,
      ),
    );
  }
}
