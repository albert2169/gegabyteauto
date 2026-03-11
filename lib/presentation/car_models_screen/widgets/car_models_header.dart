import 'package:flutter/material.dart';

class CarModelsHeader extends StatelessWidget {
  final String brandName;

  const CarModelsHeader({
    super.key,
    required this.brandName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          brandName,
          style: const TextStyle(
            color: Color(0xFF6A6A6A),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Select Model',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
