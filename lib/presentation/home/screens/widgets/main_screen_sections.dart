import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/main_screen_section_item.dart';

class MainScreenSections extends StatelessWidget {
  const MainScreenSections({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.45,
      children: [
        MainScreenSectionItem(
          iconData: Icons.directions_car_rounded,
          title: 'Ըստ մոդելի',
          subtitle: 'Բոլոր բրենդները',
          color: const Color(0xFF2A2040),
          accentColor: const Color(0xFF9B7DDC),
          onTap: () => context.pushRoute(const BrandsRoute()),
        ),
        MainScreenSectionItem(
          iconData: Icons.list_rounded,
          title: 'Դիտիր բոլորը',
          subtitle: 'Բազմաթիվ մեքենաներ',
          color: const Color(0xFF1A2A2A),
          accentColor: const Color(0xFF4ECDC4),
          onTap: () => context.pushRoute(const AllCarsRoute()),
        ),
        MainScreenSectionItem(
          iconData: Icons.sell_rounded,
          title: 'Վաճառել մեքենա',
          subtitle: 'Արագ տեղադրում',
          color: const Color(0xFF2A1A1A),
          accentColor: AppColors.primary,
          onTap: () {},
        ),
        MainScreenSectionItem(
          iconData: Icons.tune_rounded,
          title: 'համեմատել',
          subtitle: 'կողք կողքի',
          color: const Color(0xFF1A1A2A),
          accentColor: const Color(0xFF7DC4FF),
          onTap: () {},
        ),
      ],
    );
  }
}
