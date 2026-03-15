import 'package:gegabyteauto/models/car_view_model.dart';

abstract class ICarRepository {
  Future<List<CarViewModel>> getCars();
}
