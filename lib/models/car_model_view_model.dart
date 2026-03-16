class CarModelViewModel {
  final String name;
  final List<String> serias;
  const CarModelViewModel({
    required this.name,
    required this.serias,
  });

  factory CarModelViewModel.fromJson(Map<String, dynamic> json) {
    return CarModelViewModel(
      name: json['name'] as String,
      serias:
          (json['serias'] as List<dynamic>).map((e) => e as String).toList(),
    );
  }
}
