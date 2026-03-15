import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/domain/repositories/i_car_repository.dart';
import 'cars_event.dart';
import 'cars_state.dart';

@injectable
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final ICarRepository _carRepository;

  CarsBloc(this._carRepository) : super(const CarsInitial()) {
    on<CarsLoadRequested>(_onLoadRequested);
    on<CarsRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onLoadRequested(
    CarsLoadRequested event,
    Emitter<CarsState> emit,
  ) async {
    emit(const CarsLoading());
    await _fetchCars(emit);
  }

  Future<void> _onRefreshRequested(
    CarsRefreshRequested event,
    Emitter<CarsState> emit,
  ) async {
    await _fetchCars(emit);
  }

  Future<void> _fetchCars(Emitter<CarsState> emit) async {
    try {
      final cars = await _carRepository.getCars();
      emit(CarsLoaded(allCars: cars));
    } on Failure catch (e) {
      emit(CarsError(message: e.message));
    } catch (_) {
      emit(const CarsError(message: 'Failed to load cars. Please try again.'));
    }
  }
}
