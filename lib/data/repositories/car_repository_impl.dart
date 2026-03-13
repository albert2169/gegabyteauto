import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/data/datasources/car_remote_data_source.dart';
import 'package:gegabyteauto/domain/repositories/i_car_repository.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

@LazySingleton(as: ICarRepository)
class CarRepository implements ICarRepository {
  final ICarRemoteDataSource _dataSource;

  const CarRepository(this._dataSource);

  @override
  Future<List<CarViewModel>> getCars() async {
    try {
      final dtos = await _dataSource.getCars();
      return dtos.map((dto) => dto.toViewModel()).toList();
    } catch (e) {
      throw const ServerFailure('Failed to load cars. Please try again.');
    }
  }
}
