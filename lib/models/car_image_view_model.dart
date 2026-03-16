import 'package:equatable/equatable.dart';

class CarImageViewModel extends Equatable {
  final bool isInterier;
  final String assetImagePath;
  final String? networkImageUrl;

  const CarImageViewModel({
    required this.isInterier,
    required this.assetImagePath,
    this.networkImageUrl,
  });

  @override
  List<Object?> get props => [
        isInterier,
        assetImagePath,
        networkImageUrl,
      ];
}
