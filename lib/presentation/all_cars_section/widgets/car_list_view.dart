import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars_section/single_car_screen.dart';
import 'package:gegabyteauto/presentation/widgets/shimmer_network_image.dart';

class CarListView extends StatelessWidget {
  final List<CarViewModel> cars;

  const CarListView({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: cars.length,
      separatorBuilder: (_, __) => const Divider(
        color: Colors.white10,
        thickness: 0.5,
        height: 1,
      ),
      itemBuilder: (context, index) {
        final car = cars[index];
        final info = car.singleCarInfoViewModel;
        final imageUrl =
            info.images.isNotEmpty ? info.images.first.networkImageUrl : null;

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SingleCarScreen(car: car),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    car.brandLogoImageAsset,
                    width: 48,
                    height: 48,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.directions_car,
                        color: Colors.white54,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Car info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              '${info.brand} ${info.model}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            car.seria,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.price,
                        style: const TextStyle(
                          color: Color(0xFF3255ED),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Car image
                      if (imageUrl != null && imageUrl.isNotEmpty)
                        ShimmerNetworkImage(
                          imageUrl: imageUrl,
                          width: double.infinity,
                          height: 180,
                          borderRadius: BorderRadius.circular(10),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            color: Colors.white10,
                            child: const Center(
                              child: Icon(
                                Icons.photo_outlined,
                                color: Colors.white24,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
