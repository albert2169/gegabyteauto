import 'package:gegabyteauto/presentation/view_models/car_owner_info_view_model.dart';

class CarOwnerInfoDto {
  final String name;
  final String city;
  final String phoneNumber;
  final String releaseDate;
  final String lastUpdate;

  const CarOwnerInfoDto({
    required this.name,
    required this.city,
    required this.phoneNumber,
    required this.releaseDate,
    required this.lastUpdate,
  });

  factory CarOwnerInfoDto.fromJson(Map<String, dynamic> json) {
    return CarOwnerInfoDto(
      name: json['name'] as String? ?? '',
      city: json['city'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      lastUpdate: json['last_update'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'city': city,
        'phone_number': phoneNumber,
        'release_date': releaseDate,
        'last_update': lastUpdate,
      };

  CarOwnerInfoViewModel toViewModel() => CarOwnerInfoViewModel(
        name: name,
        city: city,
        phoneNumber: phoneNumber,
        releaseDate: releaseDate,
        lastUpdate: lastUpdate,
      );
}
