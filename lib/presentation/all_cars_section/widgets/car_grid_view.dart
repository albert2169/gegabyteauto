import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars_section/single_car_screen.dart';
import 'package:gegabyteauto/presentation/widgets/shimmer_network_image.dart';

class CarGridView extends StatelessWidget {
  final List<CarViewModel> cars;

  const CarGridView({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.72,
      ),
      itemCount: cars.length,
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
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car image
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14),
                    ),
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? ShimmerNetworkImage(
                            imageUrl: imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            color: Colors.white10,
                            child: const Center(
                              child: Icon(
                                Icons.photo_outlined,
                                color: Colors.white24,
                                size: 40,
                              ),
                            ),
                          ),
                  ),
                ),

                // Info section
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand logo + name
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                car.brandLogoImageAsset,
                                width: 22,
                                height: 22,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.directions_car,
                                  color: Colors.white54,
                                  size: 18,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                info.brand,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${info.model} ${car.seria}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          info.price,
                          style: const TextStyle(
                            color: Color(0xFF3255ED),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
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
