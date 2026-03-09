import 'package:flutter/material.dart';
import 'package:gegabyteauto/presentation/app_constants.dart';
import 'package:gegabyteauto/presentation/brands/widgets/brand_item.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:
              const Text('Car Brands', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
          itemCount: AppConstants.mockCarModels.length,
          itemBuilder: (context, index) {
            final model = AppConstants.mockCarModels[index];
            return Column(
              spacing: 20,
              children: [
                BrandItem(model: model),
                Row(
                  children: [
                    const SizedBox(width: 42),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
