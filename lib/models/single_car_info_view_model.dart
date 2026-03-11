import 'package:gegabyteauto/models/car_image_view_model.dart';
import 'package:gegabyteauto/models/car_owner_info_view_model.dart';

class SingleCarInfoViewModel {
  final CarOwnerInfoViewModel carOwnerInfoViewModel;
  final List<CarImageViewModel> images;
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

  const SingleCarInfoViewModel({
    required this.carOwnerInfoViewModel,
    required this.images,
    required this.price,
    required this.year,
    required this.mileage,
    required this.brand,
    required this.model,
    required this.gearBox,
    required this.condition,
    required this.engine,
    required this.color,
    required this.engineVolume,
    required this.interior,
    required this.description,
  });
}
