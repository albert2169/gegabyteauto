import 'package:gegabyteauto/models/car_model_view_model.dart';

import 'models/car_brand_view_model.dart';

class AppConstants {
  AppConstants._(); // private ctor

  static const String carBrandsAssetDir = 'assets/car_brands/';

  static final List<CarBrandViewModel> mockCarBrandViewModels = [
    CarBrandViewModel(
      name: 'Rolls-Royce',
      logoAssetPath: '${carBrandsAssetDir}image1.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Audi',
      logoAssetPath: '${carBrandsAssetDir}image2.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Ferrari',
      logoAssetPath: '${carBrandsAssetDir}image3.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Ford',
      logoAssetPath: '${carBrandsAssetDir}image4.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Honda',
      logoAssetPath: '${carBrandsAssetDir}image5.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Hyundai',
      logoAssetPath: '${carBrandsAssetDir}image6.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Jaguar',
      logoAssetPath: '${carBrandsAssetDir}image8.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Jeep',
      logoAssetPath: '${carBrandsAssetDir}image9.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Kia',
      logoAssetPath: '${carBrandsAssetDir}image10.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Ferrari',
      logoAssetPath: '${carBrandsAssetDir}image11.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Lexus',
      logoAssetPath: '${carBrandsAssetDir}image12.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Mazda',
      logoAssetPath: '${carBrandsAssetDir}image13.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Tesla',
      logoAssetPath: '${carBrandsAssetDir}image14.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Toyota',
      logoAssetPath: '${carBrandsAssetDir}image15.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Mercedes-Benz',
      logoAssetPath: '${carBrandsAssetDir}image16.png',
      models: [
        CarModelViewModel(
          name: 'AMG GT',
          serias: [
            '43',
            '53',
            '63 S E Performance',
          ],
        ),
        CarModelViewModel(
          name: 'C-Class',
          serias: [
            'AMG C 43',
            'AMG C 63 S E Performance',
            'Sedan',
          ],
        ),
        CarModelViewModel(
          name: 'CLA',
          serias: [
            'AMG CLA 35',
            'AMG CLA 45 S',
            'Sedan',
          ],
        ),
        CarModelViewModel(
          name: 'CLE',
          serias: [
            'AMG CLA 53',
            'Convertible',
            'Soupe',
          ],
        ),
        CarModelViewModel(
          name: 'E-Class',
          serias: [
            'AMG E 53 HYBRID 53',
            'Convertible',
            'Soupe',
          ],
        ),
        CarModelViewModel(
          name: 'G-Class',
          serias: [
            'AMG G 63',
            'AMG G 63 4x4 Squared',
            'Electric',
            'SUV',
          ],
        ),
        CarModelViewModel(
          name: 'GLA',
          serias: [
            'AMG GLA 35',
            'SUV',
          ],
        ),
      ],
    ),
    CarBrandViewModel(
      name: 'BMW',
      logoAssetPath: '${carBrandsAssetDir}image17.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Bentley',
      logoAssetPath: '${carBrandsAssetDir}image18.png',
      models: [],
    ),
    CarBrandViewModel(
      name: 'Porche',
      logoAssetPath: '${carBrandsAssetDir}image19.png',
      models: [],
    ),
  ]..sort((a, b) => a.name.compareTo(b.name));
}
