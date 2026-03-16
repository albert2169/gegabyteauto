import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/domain/repositories/i_car_repository.dart';
import 'cars_event.dart';
import 'cars_state.dart';

@lazySingleton
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final ICarRepository _carRepository;

  CarsBloc(this._carRepository) : super(const CarsState.initial()) {
    on<FetchAllCarsEvent>(_onFetchAllCarsEvent);
    on<CarsViewModeChanged>(_onViewModeChanged);
  }

  Future<void> _onFetchAllCarsEvent(
    FetchAllCarsEvent event,
    Emitter<CarsState> emit,
  ) async {
    emit(state.copyWith(loadState: LoadState.loading));
    final cars = await _carRepository.getCars(
      appliedFilters: event.appliedFilters ?? state.appliedFilters,
      searchText: event.searchText ?? state.searchText,
    );
    emit(
      state.copyWith(
        loadState: LoadState.loaded,
        allCars: cars,
        appliedFilters: event.appliedFilters ?? state.appliedFilters,
        searchText: event.searchText ?? state.searchText,
      ),
    );
  }

  void _onViewModeChanged(
    CarsViewModeChanged event,
    Emitter<CarsState> emit,
  ) {
    emit(state.copyWith(viewMode: event.viewMode));
  }


}
