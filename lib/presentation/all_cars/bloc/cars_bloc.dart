import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:gegabyteauto/core/error/failures.dart';
import 'package:gegabyteauto/domain/repositories/i_car_repository.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_state.dart'
    hide LoadState;
import 'cars_event.dart';
import 'cars_state.dart';

@injectable
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final ICarRepository _carRepository;

  // Store current filter state
  FiltersState? _currentFilters;

  CarsBloc(this._carRepository) : super(const CarsState.initial()) {
    on<CarsLoadRequested>(_onLoadRequested);
    on<CarsRefreshRequested>(_onRefreshRequested);
    on<CarsViewModeChanged>(_onViewModeChanged);
    on<CarsSearchQueryChanged>(_onSearchQueryChanged);
    on<CarsFiltersApplied>(_onFiltersApplied);
    on<CarsFiltersClear>(_onFiltersClear);
  }

  Future<void> _onLoadRequested(
    CarsLoadRequested event,
    Emitter<CarsState> emit,
  ) async {
    emit(state.copyWith(loadState: LoadState.loading));
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
      final filteredCars = _applyAllFilters(cars);
      emit(state.copyWith(
        loadState: LoadState.loaded,
        allCars: cars,
        filteredCars: filteredCars,
        clearErrorMessage: true,
      ));
    } on Failure catch (e) {
      emit(state.copyWith(
        loadState: LoadState.error,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        loadState: LoadState.error,
        errorMessage: 'Failed to load cars. Please try again.',
      ));
    }
  }

  void _onViewModeChanged(
    CarsViewModeChanged event,
    Emitter<CarsState> emit,
  ) {
    emit(state.copyWith(viewMode: event.viewMode));
  }

  void _onSearchQueryChanged(
    CarsSearchQueryChanged event,
    Emitter<CarsState> emit,
  ) {
    final filteredCars =
        _applyAllFilters(state.allCars, searchQuery: event.query);
    emit(state.copyWith(
      searchQuery: event.query,
      filteredCars: filteredCars,
    ));
  }

  void _onFiltersApplied(
    CarsFiltersApplied event,
    Emitter<CarsState> emit,
  ) {
    _currentFilters = event.filters;
    final filteredCars = _applyAllFilters(state.allCars);
    emit(state.copyWith(
      filteredCars: filteredCars,
      activeFilterCount: event.filters.activeFilterCount,
    ));
  }

  void _onFiltersClear(
    CarsFiltersClear event,
    Emitter<CarsState> emit,
  ) {
    _currentFilters = null;
    final filteredCars = _applyAllFilters(state.allCars);
    emit(state.copyWith(
      filteredCars: filteredCars,
      activeFilterCount: 0,
    ));
  }

  List<CarViewModel> _applyAllFilters(
    List<CarViewModel> cars, {
    String? searchQuery,
  }) {
    final query = searchQuery ?? state.searchQuery;
    final filters = _currentFilters;

    return cars.where((car) {
      final info = car.singleCarInfoViewModel;

      if (query.isNotEmpty) {
        final searchable =
            '${info.brand} ${info.model} ${car.seria} ${info.color} ${info.engine}'
                .toLowerCase();
        if (!searchable.contains(query.toLowerCase())) {
          return false;
        }
      }
      if (filters != null) {
        if (filters.selectedBrand != null &&
            info.brand != filters.selectedBrand) {
          return false;
        }

        if (filters.selectedModel != null &&
            info.model != filters.selectedModel) {
          return false;
        }

        if (filters.selectedSeries != null &&
            car.seria != filters.selectedSeries) {
          return false;
        }

        if (filters.selectedGearBox != null &&
            info.gearBox != filters.selectedGearBox) {
          return false;
        }

        if (filters.selectedEngine != null &&
            info.engine != filters.selectedEngine) {
          return false;
        }

        final price = _parsePrice(info.price);
        if (price < filters.priceRange.start ||
            price > filters.priceRange.end) {
          return false;
        }

        final year = _parseYear(info.year);
        if (year < filters.yearRange.start || year > filters.yearRange.end) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  double _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  double _parseYear(String year) {
    final cleaned = year.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }
}
