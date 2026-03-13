import 'package:equatable/equatable.dart';
import 'car_model_view_model.dart';

class CarBrandViewModel extends Equatable {
  final String name;
  final String logoAssetPath;
  final List<CarModelViewModel> models;

  const CarBrandViewModel({
    required this.name,
    required this.logoAssetPath,
    required this.models,
  });

  @override
  List<Object?> get props => [name, logoAssetPath, models];

  @override
  String toString() => 'CarBrandViewModel(name: $name)';
}
