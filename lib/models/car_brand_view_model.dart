import 'package:gegabyteauto/models/car_model_view_model.dart';

class CarBrandViewModel {
  final String name;
  final String logoAssetPath;
  final List<CarModelViewModel> models;

  const CarBrandViewModel(
      {required this.name, required this.logoAssetPath, required this.models});

  @override
  String toString() => 'CarModel(name: $name, asset: $logoAssetPath)';

  factory CarBrandViewModel.fromJson(Map<String, dynamic> json) {
    return CarBrandViewModel(
      name: json['name'] as String,
      logoAssetPath: json['logoAssetPath'] as String,
      models: (json['models'] as List<dynamic>)
          .map((e) => CarModelViewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
