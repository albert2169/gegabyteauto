import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';

class BrandItem extends StatelessWidget {
  final CarBrandViewModel carBrandViewModel;
  const BrandItem({super.key, required this.carBrandViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                carBrandViewModel.logoAssetPath,
                width: 50,
                height: 50,
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carBrandViewModel.name,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Divider(
            color: Colors.white,
            thickness: 0.1,
          ),
        )
      ],
    );
  }
}
