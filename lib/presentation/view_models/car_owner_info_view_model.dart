import 'package:equatable/equatable.dart';

class CarOwnerInfoViewModel extends Equatable {
  final String name;
  final String city;
  final String phoneNumber;
  final String releaseDate;
  final String lastUpdate;

  const CarOwnerInfoViewModel({
    required this.name,
    required this.city,
    required this.phoneNumber,
    required this.releaseDate,
    required this.lastUpdate,
  });

  @override
  List<Object?> get props => [name, city, phoneNumber, releaseDate, lastUpdate];
}
