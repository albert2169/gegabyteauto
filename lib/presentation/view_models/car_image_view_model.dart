import 'package:equatable/equatable.dart';

class CarImageViewModel extends Equatable {
  final bool isInterior;
  final String assetImagePath;
  final String? networkImageUrl;

  const CarImageViewModel({
    required this.isInterior,
    required this.assetImagePath,
    this.networkImageUrl,
  });

  @override
  List<Object?> get props => [isInterior, assetImagePath, networkImageUrl];
}
