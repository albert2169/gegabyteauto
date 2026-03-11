import 'package:flutter/material.dart';
import 'package:gegabyteauto/app_constants.dart';
import 'package:gegabyteauto/presentation/brands_new_screen/widgets/brand_item.dart';
import 'package:gegabyteauto/presentation/car_models_screen/car_models_main_screen.dart';
import 'package:gegabyteauto/presentation/gegabyte_main_screen/widgets/app_navigation.dart';

class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Select Car Brand',
              style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView.builder(
          itemCount: AppConstants.mockCarBrandViewModels.length,
          itemBuilder: (context, index) {
            final carBrand = AppConstants.mockCarBrandViewModels[index];
            return Column(
              spacing: 20,
              children: [
                GestureDetector(
                  onTap: () {
                    Nav.push(CarModelsMainScreen(
                      models: carBrand.models,
                      brandName: carBrand.name,
                    ));
                  },
                  child: BrandItem(
                    carBrandViewModel: carBrand,
                  ),
                ),
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
