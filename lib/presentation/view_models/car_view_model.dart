import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/presentation/view_models/single_car_info_view_model.dart';

class CarViewModel extends Equatable {
  final String brandLogoImageAsset;
  final String seria;
  final SingleCarInfoViewModel singleCarInfoViewModel;

  const CarViewModel({
    required this.brandLogoImageAsset,
    required this.seria,
    required this.singleCarInfoViewModel,
  });

  @override
  List<Object?> get props =>
      [brandLogoImageAsset, seria, singleCarInfoViewModel];
}
