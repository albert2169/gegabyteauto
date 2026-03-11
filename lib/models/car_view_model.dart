import 'package:gegabyteauto/models/single_car_info_view_model.dart';

class CarViewModel {
  final String brandLogoImageAsset;
  final String seria;
  final SingleCarInfoViewModel singleCarInfoViewModel;
  const CarViewModel({
    required this.brandLogoImageAsset,
    required this.seria,
    required this.singleCarInfoViewModel,
  });
}
