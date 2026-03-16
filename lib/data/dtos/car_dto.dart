import 'package:gegabyteauto/data/dtos/car_image_dto.dart';
import 'package:gegabyteauto/data/dtos/car_owner_info_dto.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/models/single_car_info_view_model.dart';

class CarDto {
  final String id;
  final String brandLogoImageAsset;
  final String seria;
  final CarOwnerInfoDto owner;
  final List<CarImageDto> images;
  final String price;
  final String year;
  final String mileage;
  final String brand;
  final String model;
  final String gearBox;
  final String condition;
  final String color;
  final String engine;
  final String engineVolume;
  final String interior;
  final String description;
  final bool doILike;
  final bool doISave;

  const CarDto({
    required this.id,
    required this.brandLogoImageAsset,
    required this.seria,
    required this.owner,
    required this.images,
    required this.price,
    required this.year,
    required this.mileage,
    required this.brand,
    required this.model,
    required this.gearBox,
    required this.condition,
    required this.color,
    required this.engine,
    required this.engineVolume,
    required this.interior,
    required this.description,
    required this.doILike,
    required this.doISave,
  });

  factory CarDto.fromJson(Map<String, dynamic> json) {
    return CarDto(
      id: json['id'] as String? ?? '',
      brandLogoImageAsset: json['brand_logo_image_asset'] as String? ?? '',
      seria: json['seria'] as String? ?? '',
      owner: CarOwnerInfoDto.fromJson(
          json['owner'] as Map<String, dynamic>? ?? {}),
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => CarImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      price: json['price'] as String? ?? '',
      year: json['year'] as String? ?? '',
      mileage: json['mileage'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      model: json['model'] as String? ?? '',
      gearBox: json['gear_box'] as String? ?? '',
      condition: json['condition'] as String? ?? '',
      color: json['color'] as String? ?? '',
      engine: json['engine'] as String? ?? '',
      engineVolume: json['engine_volume'] as String? ?? '',
      interior: json['interior'] as String? ?? '',
      description: json['description'] as String? ?? '',
      doILike: false,
      doISave: false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand_logo_image_asset': brandLogoImageAsset,
        'seria': seria,
        'owner': owner.toJson(),
        'images': images.map((e) => e.toJson()).toList(),
        'price': price,
        'year': year,
        'mileage': mileage,
        'brand': brand,
        'model': model,
        'gear_box': gearBox,
        'condition': condition,
        'color': color,
        'engine': engine,
        'engine_volume': engineVolume,
        'interior': interior,
        'description': description,
        'do_I_like': doILike,
        'do_I_save': doISave,
      };

  CarViewModel toViewModel() => CarViewModel(
        brandLogoImageAsset: brandLogoImageAsset,
        seria: seria,
        singleCarInfoViewModel: SingleCarInfoViewModel(
          doILike: doILike,
          doISave: doISave,
          carOwnerInfoViewModel: owner.toViewModel(),
          images: images.map((e) => e.toViewModel()).toList(),
          price: price,
          year: year,
          mileage: mileage,
          brand: brand,
          model: model,
          gearBox: gearBox,
          condition: condition,
          color: color,
          engine: engine,
          engineVolume: engineVolume,
          interior: interior,
          description: description,
        ),
      );
}
