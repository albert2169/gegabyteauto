import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/models/car_model.dart';

class BrandItem extends StatelessWidget {
  final CarModel model;
  const BrandItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                model.assetPath,
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name,
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
          child: Divider(color: Colors.white, thickness: 0.1,),
        )
      ],
    );
  }
}
