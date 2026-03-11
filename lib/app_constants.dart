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
        images: List.generate(
          3,
          (i) {
            final urls = _carImageUrls[brand.name.toLowerCase()] ??
                _carImageUrls['default']!;
            return CarImageViewModel(
              isInterier: i == 1,
              assetImagePath: brand.logoAssetPath,
              networkImageUrl: urls[(index + i) % urls.length],
            );
          },
        ),
        price:
            '\$${(15000 + index * 4500).toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}',
        year: '${2015 + (index % 10)}',
        mileage: '${28000 + index * 3900} km',
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

  static const Map<String, List<String>> _carImageUrls = {
    'mercedes-benz': [
      'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
      'https://images.unsplash.com/photo-1617814076367-b2e0bc6e21fd?w=800',
      'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?w=800',
    ],
    'bmw': [
      'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
      'https://images.unsplash.com/photo-1542362567-b07e54358753?w=800',
      'https://images.unsplash.com/photo-1580274455191-1c62238ce452?w=800',
    ],
    'audi': [
      'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800',
      'https://images.unsplash.com/photo-1603584173870-7f23fdae1b7a?w=800',
      'https://images.unsplash.com/photo-1614162692292-7ac56d7f7f1e?w=800',
    ],
    'toyota': [
      'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb?w=800',
      'https://images.unsplash.com/photo-1559416523-140ddc3d238c?w=800',
      'https://images.unsplash.com/photo-1632038229384-4ebb3aa4a5cb?w=800',
    ],
    'tesla': [
      'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800',
      'https://images.unsplash.com/photo-1536700503339-1e4b06520771?w=800',
      'https://images.unsplash.com/photo-1571127236794-81c0bbfe1ce3?w=800',
    ],
    'ferrari': [
      'https://images.unsplash.com/photo-1592198084033-aade902d1aae?w=800',
      'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800',
      'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800',
    ],
    'ford': [
      'https://images.unsplash.com/photo-1551830820-330a71b99659?w=800',
      'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800',
      'https://images.unsplash.com/photo-1612825173281-9a193378527e?w=800',
    ],
    'porche': [
      'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
      'https://images.unsplash.com/photo-1614162118030-f72a108f5949?w=800',
      'https://images.unsplash.com/photo-1580414057403-c5f451f30e1c?w=800',
    ],
    'rolls-royce': [
      'https://images.unsplash.com/photo-1563720223185-11003d516935?w=800',
      'https://images.unsplash.com/photo-1631295868223-63265b40d9e4?w=800',
      'https://images.unsplash.com/photo-1616422285623-13ff0162193c?w=800',
    ],
    'bentley': [
      'https://images.unsplash.com/photo-1580274437636-1a4d63c6fc10?w=800',
      'https://images.unsplash.com/photo-1616455579100-2ceaa4eb2d37?w=800',
      'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800',
    ],
    'honda': [
      'https://images.unsplash.com/photo-1609521263047-f8f205293f24?w=800',
      'https://images.unsplash.com/photo-1606611013016-969c19ba27a5?w=800',
      'https://images.unsplash.com/photo-1679429463711-5c06dfbb07e5?w=800',
    ],
    'hyundai': [
      'https://images.unsplash.com/photo-1629897048514-3dd7414fe72a?w=800',
      'https://images.unsplash.com/photo-1674763297744-4a29b60fb51e?w=800',
      'https://images.unsplash.com/photo-1637963954264-bd02fb6acb2a?w=800',
    ],
    'jaguar': [
      'https://images.unsplash.com/photo-1597007066837-a31891832ca8?w=800',
      'https://images.unsplash.com/photo-1612392062631-94e3145085b5?w=800',
      'https://images.unsplash.com/photo-1600712242805-5f78671b24da?w=800',
    ],
    'jeep': [
      'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800',
      'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?w=800',
      'https://images.unsplash.com/photo-1606016159991-dfe4f2746ad5?w=800',
    ],
    'kia': [
      'https://images.unsplash.com/photo-1671893635498-4ec12e0add8c?w=800',
      'https://images.unsplash.com/photo-1625231334168-25f95a1399c2?w=800',
      'https://images.unsplash.com/photo-1620891549027-942fdc95d3f5?w=800',
    ],
    'lexus': [
      'https://images.unsplash.com/photo-1621993202323-eb4e8a665dbc?w=800',
      'https://images.unsplash.com/photo-1623869675781-80aa31012a5a?w=800',
      'https://images.unsplash.com/photo-1551522355-dbf80597eba8?w=800',
    ],
    'mazda': [
      'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=800',
      'https://images.unsplash.com/photo-1615063029789-7333e4e2b6cc?w=800',
      'https://images.unsplash.com/photo-1549317661-bd32c8ce0afa?w=800',
    ],
    'default': [
      'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=800',
      'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
      'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800',
    ],
  };

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
