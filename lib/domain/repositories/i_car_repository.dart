import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

abstract class ICarRepository {
  Future<List<CarViewModel>> getCars();
}
