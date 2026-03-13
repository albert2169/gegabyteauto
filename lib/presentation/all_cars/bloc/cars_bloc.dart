import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/domain/repositories/i_car_repository.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';
import 'cars_event.dart';
import 'cars_state.dart';

@injectable
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final ICarRepository _carRepository;

  CarsBloc(this._carRepository) : super(const CarsInitial()) {
    on<CarsLoadRequested>(_onLoadRequested);
    on<CarsRefreshRequested>(_onRefreshRequested);
    on<CarsFilterChanged>(_onFilterChanged);
    on<CarsFilterReset>(_onFilterReset);
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
      emit(CarsLoaded(allCars: cars, filteredCars: cars));
    } on Failure catch (e) {
      emit(CarsError(message: e.message));
    } catch (_) {
      emit(const CarsError(message: 'Failed to load cars. Please try again.'));
    }
  }

  void _onFilterChanged(
    CarsFilterChanged event,
    Emitter<CarsState> emit,
  ) {
    final current = state;
    if (current is! CarsLoaded) return;

    final filtered = _applyFilters(
      cars: current.allCars,
      searchQuery: event.searchQuery ?? current.searchQuery,
      brand: event.brand ?? current.selectedBrand,
      gearBox: event.gearBox ?? current.selectedGearBox,
      engine: event.engine ?? current.selectedEngine,
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
      minYear: event.minYear,
      maxYear: event.maxYear,
    );

    emit(current.copyWith(
      filteredCars: filtered,
      searchQuery: event.searchQuery,
      selectedBrand: event.brand,
      selectedGearBox: event.gearBox,
      selectedEngine: event.engine,
    ));
  }

  void _onFilterReset(CarsFilterReset event, Emitter<CarsState> emit) {
    final current = state;
    if (current is! CarsLoaded) return;
    emit(CarsLoaded(allCars: current.allCars, filteredCars: current.allCars));
  }

  List<CarViewModel> _applyFilters({
    required List<CarViewModel> cars,
    String? searchQuery,
    String? brand,
    String? gearBox,
    String? engine,
    double? minPrice,
    double? maxPrice,
    double? minYear,
    double? maxYear,
  }) {
    return cars.where((car) {
      final info = car.singleCarInfoViewModel;

      if (searchQuery != null && searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final searchable =
            '${info.brand} ${info.model} ${car.seria} ${info.color} ${info.engine}'
                .toLowerCase();
        if (!searchable.contains(q)) return false;
      }

      if (brand != null && brand.isNotEmpty && info.brand != brand) {
        return false;
      }

      if (gearBox != null && gearBox.isNotEmpty && info.gearBox != gearBox) {
        return false;
      }

      if (engine != null && engine.isNotEmpty && info.engine != engine) {
        return false;
      }

      if (minPrice != null || maxPrice != null) {
        final price =
            double.tryParse(info.price.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
        if (minPrice != null && price < minPrice) return false;
        if (maxPrice != null && price > maxPrice) return false;
      }

      if (minYear != null || maxYear != null) {
        final year = double.tryParse(info.year) ?? 2020;
        if (minYear != null && year < minYear) return false;
        if (maxYear != null && year > maxYear) return false;
      }

      return true;
    }).toList();
  }
}
