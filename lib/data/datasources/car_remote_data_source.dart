import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/data/dtos/car_dto.dart';
import 'package:gegabyteauto/data/dtos/car_image_dto.dart';
import 'package:gegabyteauto/data/dtos/car_owner_info_dto.dart';

abstract class ICarRemoteDataSource {
  Future<List<CarDto>> getCars();
}

@LazySingleton(as: ICarRemoteDataSource)
class CarRemoteDataSource implements ICarRemoteDataSource {
  // ─── Mock data (replace with real HTTP calls later) ─────────────────────────

  static const String _brandsDir = 'assets/car_brands/';

  static const _ownerNames = [
    'Armen Petrosyan',
    'Karen Hakobyan',
    'Narek Sargsyan',
    'Ani Grigoryan',
    'Gevorg Avetisyan',
    'Lusine Hovhannisyan',
    'David Simonyan',
    'Meri Khachatryan',
  ];

  static const _cities = [
    'Yerevan',
    'Gyumri',
    'Vanadzor',
    'Abovyan',
    'Etchmiadzin',
    'Hrazdan',
    'Kapan',
    'Gavar',
  ];

  static const _gearBoxes = ['Automatic', 'Manual', 'CVT'];
  static const _engines = ['Gasoline', 'Diesel', 'Hybrid', 'Electric'];
  static const _conditions = ['New', 'Used', 'Certified Pre-Owned'];
  static const _colors = [
    'Black',
    'White',
    'Silver',
    'Red',
    'Blue',
    'Gray',
    'Navy',
    'Beige'
  ];
  static const _interiors = ['Leather', 'Textile', 'Alcantara', 'Premium'];

  static const _carData = [
    {
      'brand': 'Mercedes-Benz',
      'model': 'AMG GT',
      'seria': '63 S',
      'logo': '${_brandsDir}image16.png'
    },
    {
      'brand': 'Mercedes-Benz',
      'model': 'C-Class',
      'seria': 'AMG C 43',
      'logo': '${_brandsDir}image16.png'
    },
    {
      'brand': 'Mercedes-Benz',
      'model': 'G-Class',
      'seria': 'AMG G 63',
      'logo': '${_brandsDir}image16.png'
    },
    {
      'brand': 'BMW',
      'model': 'M3',
      'seria': 'Competition',
      'logo': '${_brandsDir}image17.png'
    },
    {
      'brand': 'BMW',
      'model': 'M5',
      'seria': 'CS',
      'logo': '${_brandsDir}image17.png'
    },
    {
      'brand': 'BMW',
      'model': 'X5 M',
      'seria': 'Competition',
      'logo': '${_brandsDir}image17.png'
    },
    {
      'brand': 'Audi',
      'model': 'RS6',
      'seria': 'Avant',
      'logo': '${_brandsDir}image2.png'
    },
    {
      'brand': 'Audi',
      'model': 'R8',
      'seria': 'V10 Performance',
      'logo': '${_brandsDir}image2.png'
    },
    {
      'brand': 'Audi',
      'model': 'Q8',
      'seria': 'RS',
      'logo': '${_brandsDir}image2.png'
    },
    {
      'brand': 'Ferrari',
      'model': 'F8',
      'seria': 'Tributo',
      'logo': '${_brandsDir}image3.png'
    },
    {
      'brand': 'Ferrari',
      'model': '488',
      'seria': 'Pista',
      'logo': '${_brandsDir}image3.png'
    },
    {
      'brand': 'Ferrari',
      'model': 'Roma',
      'seria': 'Spider',
      'logo': '${_brandsDir}image3.png'
    },
    {
      'brand': 'Rolls-Royce',
      'model': 'Ghost',
      'seria': 'Black Badge',
      'logo': '${_brandsDir}image1.png'
    },
    {
      'brand': 'Rolls-Royce',
      'model': 'Wraith',
      'seria': 'Luminary',
      'logo': '${_brandsDir}image1.png'
    },
    {
      'brand': 'Porsche',
      'model': '911',
      'seria': 'GT3 RS',
      'logo': '${_brandsDir}image19.png'
    },
    {
      'brand': 'Porsche',
      'model': 'Taycan',
      'seria': 'Turbo S',
      'logo': '${_brandsDir}image19.png'
    },
    {
      'brand': 'Tesla',
      'model': 'Model S',
      'seria': 'Plaid',
      'logo': '${_brandsDir}image14.png'
    },
    {
      'brand': 'Tesla',
      'model': 'Model X',
      'seria': 'Plaid',
      'logo': '${_brandsDir}image14.png'
    },
    {
      'brand': 'Lamborghini',
      'model': 'Huracán',
      'seria': 'EVO',
      'logo': '${_brandsDir}image11.png'
    },
    {
      'brand': 'Lamborghini',
      'model': 'Urus',
      'seria': 'Performante',
      'logo': '${_brandsDir}image11.png'
    },
  ];

  static const _networkImages = [
    'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800',
    'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800',
    'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800',
    'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?w=800',
    'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800',
    'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800',
    'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?w=800',
    'https://images.unsplash.com/photo-1514267226929-0fe36e52cfb5?w=800',
  ];

  String _formatPrice(int base) {
    final s = base.toString();
    final result = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) result.write(',');
      result.write(s[i]);
    }
    return '\$$result';
  }

  @override
  Future<List<CarDto>> getCars() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    return List<CarDto>.generate(50, (index) {
      final data = _carData[index % _carData.length];

      return CarDto(
        id: 'car_$index',
        brandLogoImageAsset: data['logo']!,
        seria: data['seria']!,
        owner: CarOwnerInfoDto(
          name: _ownerNames[index % _ownerNames.length],
          city: _cities[index % _cities.length],
          phoneNumber: '+374 ${77 + (index % 22)} ${100000 + index * 137}',
          releaseDate: '${(index % 28) + 1}.${(index % 12) + 1}.2025',
          lastUpdate: '${(index % 9) + 1} days ago',
        ),
        images: List.generate(3, (i) {
          return CarImageDto(
            isInterior: i == 1,
            assetImagePath: data['logo']!,
            networkImageUrl:
                _networkImages[(index + i) % _networkImages.length],
          );
        }),
        price: _formatPrice(15000 + index * 4500),
        year: '${2015 + (index % 10)}',
        mileage: '${28000 + index * 3900} km',
        brand: data['brand']!,
        model: data['model']!,
        gearBox: _gearBoxes[index % _gearBoxes.length],
        condition: _conditions[index % _conditions.length],
        color: _colors[index % _colors.length],
        engine: _engines[index % _engines.length],
        engineVolume: index % 2 == 0 ? '3.0L' : '4.0L',
        interior: _interiors[index % _interiors.length],
        description:
            'A premium ${data['brand']} ${data['model']} ${data['seria']}. '
            'Excellent condition, well maintained. Full service history. '
            'All options available. Test drive by appointment.',
      );
    });
  }
}
