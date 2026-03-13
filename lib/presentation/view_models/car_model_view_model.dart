import 'package:equatable/equatable.dart';

class CarModelViewModel extends Equatable {
  final String name;
  final List<String> serias;

  const CarModelViewModel({
    required this.name,
    required this.serias,
  });

  @override
  List<Object?> get props => [name, serias];
}
