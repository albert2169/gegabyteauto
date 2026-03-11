class CarImageViewModel {
  final bool isInterier;
  final String assetImagePath;
  final String? networkImageUrl;

  const CarImageViewModel({
    required this.isInterier,
    required this.assetImagePath,
    this.networkImageUrl,
  });
}
