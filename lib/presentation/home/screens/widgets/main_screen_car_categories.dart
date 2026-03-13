import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/main_screen_category_item.dart';

class MainScreenCarCategories extends StatelessWidget {
  const MainScreenCarCategories({super.key});

  @override
  Widget build(BuildContext context) {
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
          return MainScreenCategoryItem(label: cat.$1, iconData: cat.$2);
        },
      ),
    );
  }
}
