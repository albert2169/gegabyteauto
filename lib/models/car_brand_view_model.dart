import 'package:gegabyteauto/models/car_model_view_model.dart';

class CarBrandViewModel {
  final String name;
  final String logoAssetPath;
  final List<CarModelViewModel> models;

  const CarBrandViewModel(
      {required this.name, required this.logoAssetPath, required this.models});

  @override
  String toString() => 'CarModel(name: $name, asset: $logoAssetPath)';
}
