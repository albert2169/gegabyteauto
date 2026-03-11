import 'package:gegabyteauto/models/car_image_view_model.dart';
import 'package:gegabyteauto/models/car_model_view_model.dart';
import 'package:gegabyteauto/models/car_owner_info_view_model.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/models/single_car_info_view_model.dart';

import 'models/car_brand_view_model.dart';

class AppConstants {
  AppConstants._();

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

  static final List<CarViewModel> mockCarViewModels =
      List<CarViewModel>.generate(50, (index) {
    final brand = mockCarBrandViewModels[index % mockCarBrandViewModels.length];
    final brandModels = _availableModelsForBrand(brand);
    final model = brandModels[index % brandModels.length];
    final seria = model.serias[index % model.serias.length];

    return CarViewModel(
      brandLogoImageAsset: brand.logoAssetPath,
      seria: seria,
      singleCarInfoViewModel: SingleCarInfoViewModel(
        carOwnerInfoViewModel: CarOwnerInfoViewModel(
          name: _ownerNames[index % _ownerNames.length],
          city: _cities[index % _cities.length],
          phoneNumber: '+374 ${77 + (index % 22)} ${100000 + index * 137}',
          releaseDate: '${(index % 28) + 1}.${(index % 12) + 1}.2025',
          lastUpdate: '${(index % 9) + 1} օր առաջ',
        ),
        images: [
          CarImageViewModel(
            isInterier: false,
            assetImagePath: brand.logoAssetPath,
          ),
          CarImageViewModel(
            isInterier: true,
            assetImagePath: brand.logoAssetPath,
          ),
          CarImageViewModel(
            isInterier: false,
            assetImagePath: brand.logoAssetPath,
          ),
        ],
        price: '${6500000 + index * 185000} դրամ',
        year: '${2015 + (index % 10)}',
        mileage: '${28000 + index * 3900} կմ',
        brand: brand.name,
        model: model.name,
        gearBox: _gearBoxes[index % _gearBoxes.length],
        condition: _conditions[index % _conditions.length],
        color: _colors[index % _colors.length],
        engine: _engines[index % _engines.length],
        engineVolume: _engineVolumes[index % _engineVolumes.length],
        interior: _interiors[index % _interiors.length],
        description:
            '${brand.name} ${model.name} ${seria} վաճառվում է գերազանց վիճակում։ Մեքենան պահված է խնամքով, սրահը մաքուր է, տեխնիկապես լիովին սարքին է և պատրաստ է շահագործման։ Հնարավոր է տեղում զննություն ${_cities[index % _cities.length]} քաղաքում։',
      ),
    );
  });

  static List<CarModelViewModel> _availableModelsForBrand(
    CarBrandViewModel brand,
  ) {
    if (brand.models.isNotEmpty) {
      return brand.models;
    }

    switch (brand.name) {
      case 'Rolls-Royce':
        return const [
          CarModelViewModel(name: 'Ghost', serias: ['Base', 'Black Badge']),
          CarModelViewModel(name: 'Cullinan', serias: ['SUV', 'Black Badge']),
        ];
      case 'Audi':
        return const [
          CarModelViewModel(name: 'A6', serias: ['Premium', 'S line']),
          CarModelViewModel(name: 'Q7', serias: ['Quattro', 'S line']),
        ];
      case 'Ferrari':
        return const [
          CarModelViewModel(name: 'Roma', serias: ['Coupe', 'Spider']),
          CarModelViewModel(name: '296', serias: ['GTB', 'GTS']),
        ];
      case 'Ford':
        return const [
          CarModelViewModel(name: 'Mustang', serias: ['GT', 'EcoBoost']),
          CarModelViewModel(name: 'Explorer', serias: ['XLT', 'Limited']),
        ];
      case 'Honda':
        return const [
          CarModelViewModel(name: 'Civic', serias: ['Sedan', 'Type R']),
          CarModelViewModel(name: 'CR-V', serias: ['EX', 'Touring']),
        ];
      case 'Hyundai':
        return const [
          CarModelViewModel(name: 'Elantra', serias: ['SEL', 'N Line']),
          CarModelViewModel(
              name: 'Santa Fe', serias: ['Premium', 'Calligraphy']),
        ];
      case 'Jaguar':
        return const [
          CarModelViewModel(name: 'F-PACE', serias: ['R-Dynamic', 'SVR']),
          CarModelViewModel(name: 'XE', serias: ['Standard', 'R-Dynamic']),
        ];
      case 'Jeep':
        return const [
          CarModelViewModel(name: 'Wrangler', serias: ['Sport', 'Rubicon']),
          CarModelViewModel(
              name: 'Grand Cherokee', serias: ['Limited', 'Summit']),
        ];
      case 'Kia':
        return const [
          CarModelViewModel(name: 'Sportage', serias: ['EX', 'GT Line']),
          CarModelViewModel(name: 'Sorento', serias: ['Prestige', 'X-Line']),
        ];
      case 'Lexus':
        return const [
          CarModelViewModel(name: 'RX', serias: ['350', '500h']),
          CarModelViewModel(name: 'NX', serias: ['250', '350 F Sport']),
        ];
      case 'Mazda':
        return const [
          CarModelViewModel(name: 'CX-5', serias: ['Touring', 'Signature']),
          CarModelViewModel(
              name: 'Mazda 6', serias: ['Sport', 'Grand Touring']),
        ];
      case 'Tesla':
        return const [
          CarModelViewModel(
              name: 'Model 3', serias: ['Long Range', 'Performance']),
          CarModelViewModel(
              name: 'Model Y', serias: ['Standard', 'Long Range']),
        ];
      case 'Toyota':
        return const [
          CarModelViewModel(name: 'Camry', serias: ['LE', 'XSE']),
          CarModelViewModel(name: 'RAV4', serias: ['Adventure', 'Limited']),
        ];
      case 'BMW':
        return const [
          CarModelViewModel(name: 'X5', serias: ['xDrive40i', 'M60i']),
          CarModelViewModel(name: '5 Series', serias: ['530i', '540i']),
        ];
      case 'Bentley':
        return const [
          CarModelViewModel(name: 'Bentayga', serias: ['V8', 'Azure']),
          CarModelViewModel(name: 'Continental GT', serias: ['Coupe', 'Speed']),
        ];
      case 'Porche':
        return const [
          CarModelViewModel(name: 'Cayenne', serias: ['Base', 'Turbo']),
          CarModelViewModel(name: '911', serias: ['Carrera', 'Turbo S']),
        ];
      default:
        return const [
          CarModelViewModel(name: 'Հիմնական մոդել', serias: ['Ստանդարտ']),
        ];
    }
  }

  static const List<String> _ownerNames = [
    'Արամ Պետրոսյան',
    'Գարիկ Մկրտչյան',
    'Նարեկ Սարգսյան',
    'Հայկ Հովհաննիսյան',
    'Սուրեն Կարապետյան',
    'Տիգրան Մանուկյան',
    'Վահե Գրիգորյան',
    'Արտյոմ Հարությունյան',
  ];

  static const List<String> _cities = [
    'Երևան',
    'Գյումրի',
    'Վանաձոր',
    'Աբովյան',
    'Էջմիածին',
    'Հրազդան',
    'Կապան',
    'Աշտարակ',
  ];

  static const List<String> _gearBoxes = [
    'Ավտոմատ',
    'Մեխանիկական',
    'Ռոբոտացված',
  ];

  static const List<String> _conditions = [
    'Գերազանց',
    'Լավ',
    'Իդեալական',
    'Վթարված չէ',
  ];

  static const List<String> _colors = [
    'Սև',
    'Սպիտակ',
    'Արծաթագույն',
    'Մոխրագույն',
    'Կապույտ',
    'Կարմիր',
  ];

  static const List<String> _engines = [
    'Բենզին',
    'Դիզել',
    'Հիբրիդ',
    'Էլեկտրական',
  ];

  static const List<String> _engineVolumes = [
    '1.6 լ',
    '2.0 լ',
    '2.5 լ',
    '3.0 լ',
    '4.0 լ',
  ];

  static const List<String> _interiors = [
    'Կաշվե սրահ',
    'Կոմբինացված սրահ',
    'Սև կաշվե սրահ',
    'Բեժ կաշվե սրահ',
  ];
}
