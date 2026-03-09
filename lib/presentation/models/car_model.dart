class CarModel {
  final String name;
  final String assetPath;

  const CarModel({required this.name, required this.assetPath});

  @override
  String toString() => 'CarModel(name: $name, asset: $assetPath)';
}
