import 'package:gegabyteauto/presentation/view_models/car_image_view_model.dart';

class CarImageDto {
  final bool isInterior;
  final String assetImagePath;
  final String? networkImageUrl;

  const CarImageDto({
    required this.isInterior,
    required this.assetImagePath,
    this.networkImageUrl,
  });

  factory CarImageDto.fromJson(Map<String, dynamic> json) {
    return CarImageDto(
      isInterior: json['is_interior'] as bool? ?? false,
      assetImagePath: json['asset_image_path'] as String? ?? '',
      networkImageUrl: json['network_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'is_interior': isInterior,
        'asset_image_path': assetImagePath,
        'network_image_url': networkImageUrl,
      };

  CarImageViewModel toViewModel() => CarImageViewModel(
        isInterior: isInterior,
        assetImagePath: assetImagePath,
        networkImageUrl: networkImageUrl,
      );
}
