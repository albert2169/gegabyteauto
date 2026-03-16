import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

abstract class ICarRepository {
  Future<List<CarViewModel>> getCars({
    required String searchText,
    required CarFilterViewModel appliedFilters,
  });
}
