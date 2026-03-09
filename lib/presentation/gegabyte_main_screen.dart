import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/widgets/custom_app_bar.dart';
import 'package:gegabyteauto/presentation/widgets/section_item.dart';
import 'package:gegabyteauto/presentation/widgets/app_navigation.dart';
import 'package:gegabyteauto/presentation/brands/brand_screen.dart';

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
              icon: Icons.car_rental_sharp,
              title: 'See All',
              onTap: () {},
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
