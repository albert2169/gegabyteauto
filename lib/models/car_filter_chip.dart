enum FilterChipType {
  brand,
  model,
  seria,
  gearbox,
  engine;
}

class CarFilterChip {
  final FilterChipType type;
  final String chipName;
  const CarFilterChip({required this.type, required this.chipName});
}
