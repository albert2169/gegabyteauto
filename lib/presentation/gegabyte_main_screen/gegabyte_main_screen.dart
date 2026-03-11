import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/all_cars_section/all_cars_main_screen.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/custom_app_bar.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/section_item.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/app_navigation.dart';
import 'package:gegabyteauto/presentation/brands_new_screen/brand_screen.dart';

class GegabyteMainScreen extends StatefulWidget {
  const GegabyteMainScreen({super.key});

  @override
  State<GegabyteMainScreen> createState() => _GegabyteMainScreenState();
}

class _GegabyteMainScreenState extends State<GegabyteMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212122),
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionItem(
              icon: Icons.car_repair,
              title: 'Shop by Model',
              onTap: () {
                Nav.push(const BrandScreen());
              },
            ),
            const SizedBox(height: 20),
            SectionItem(
              icon: Icons.car_crash,
              title: 'Shop by Category',
              onTap: () {},
            ),
            const SizedBox(height: 20),
            SectionItem(
              icon: Icons.list,
              title: 'See All',
              onTap: () {
                Nav.push(AllCarsMainScreen());
              },
            ),
            const SizedBox(height: 20),
            SectionItem(
              icon: Icons.monetization_on,
              title: 'Sell my car',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
