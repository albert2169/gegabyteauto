import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

enum LoadState { initial, loading, loaded, error }

enum CarsViewMode { list, grid, reels }

class CarsState extends Equatable {
  final LoadState loadState;
  final String? errorMessage;
  final List<CarViewModel> allCars;
  final CarsViewMode viewMode;
  final String searchText;
  final CarFilterViewModel appliedFilters;
  const CarsState({
    required this.loadState,
    this.errorMessage,
    required this.allCars,
    required this.viewMode,
    required this.searchText,
    required this.appliedFilters,
  });

  const CarsState.initial()
      : loadState = LoadState.initial,
        errorMessage = null,
        allCars = const [],
        viewMode = CarsViewMode.list,
        searchText = '',
        appliedFilters = const CarFilterViewModel();

  bool get isLoading => loadState == LoadState.loading;
  bool get isLoaded => loadState == LoadState.loaded;
  bool get isError => loadState == LoadState.error;

  CarsState copyWith({
    LoadState? loadState,
    String? errorMessage,
    bool clearErrorMessage = false,
    List<CarViewModel>? allCars,
    CarsViewMode? viewMode,
    String? searchText,
    CarFilterViewModel? appliedFilters
  }) {
    return CarsState(
      appliedFilters: appliedFilters ?? this.appliedFilters,
      loadState: loadState ?? this.loadState,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      allCars: allCars ?? this.allCars,
      viewMode: viewMode ?? this.viewMode,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
        loadState,
        errorMessage,
        allCars,
        viewMode,
        searchText,
        appliedFilters,
      ];
}
