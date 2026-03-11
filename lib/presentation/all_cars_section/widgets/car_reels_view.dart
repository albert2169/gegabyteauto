import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

class CarReelsView extends StatelessWidget {
  final List<CarViewModel> cars;

  const CarReelsView({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: cars.length,
      itemBuilder: (context, index) {
        final car = cars[index];
        final info = car.singleCarInfoViewModel;

        return Container(
          color: Colors.black,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Placeholder full-screen image
              Container(
                color: Colors.white.withValues(alpha: 0.05),
                child: const Center(
                  child: Icon(
                    Icons.photo_outlined,
                    color: Colors.white12,
                    size: 120,
                  ),
                ),
              ),

              // Gradient overlay at bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 80, 20, 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Brand logo + name row
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              car.brandLogoImageAsset,
                              width: 36,
                              height: 36,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Icon(
                                  Icons.directions_car,
                                  color: Colors.white54,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              info.brand,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Model + seria
                      Text(
                        '${info.model} ${car.seria}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Price
                      Text(
                        info.price,
                        style: const TextStyle(
                          color: Color(0xFF3255ED),
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Quick info chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          _infoChip(info.year),
                          _infoChip(info.mileage),
                          _infoChip(info.gearBox),
                          _infoChip(info.engine),
                          _infoChip(info.color),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Description
                      Text(
                        info.description,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          height: 1.4,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),

              // Page indicator on the right
              Positioned(
                right: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.favorite_border,
                          color: Colors.white, size: 28),
                      const SizedBox(height: 20),
                      const Icon(Icons.share_outlined,
                          color: Colors.white, size: 28),
                      const SizedBox(height: 20),
                      const Icon(Icons.bookmark_border,
                          color: Colors.white, size: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
