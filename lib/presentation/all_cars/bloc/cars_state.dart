import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

/// Enum representing loading states for the cars
enum LoadState { initial, loading, loaded, error }

/// View mode for displaying cars
enum CarsViewMode { list, grid, reels }

class CarsState extends Equatable {
  /// Current load state
  final LoadState loadState;

  /// Error message when loadState is error
  final String? errorMessage;

  /// All loaded cars
  final List<CarViewModel> allCars;

  /// Filtered cars (after applying filters)
  final List<CarViewModel> filteredCars;

  /// Current view mode
  final CarsViewMode viewMode;

  /// Search query
  final String searchQuery;

  /// Active filter count for badge
  final int activeFilterCount;

  const CarsState({
    required this.loadState,
    this.errorMessage,
    required this.allCars,
    required this.filteredCars,
    required this.viewMode,
    required this.searchQuery,
    required this.activeFilterCount,
  });

  const CarsState.initial()
      : loadState = LoadState.initial,
        errorMessage = null,
        allCars = const [],
        filteredCars = const [],
        viewMode = CarsViewMode.list,
        searchQuery = '',
        activeFilterCount = 0;

  bool get isLoading => loadState == LoadState.loading;
  bool get isLoaded => loadState == LoadState.loaded;
  bool get isError => loadState == LoadState.error;

  CarsState copyWith({
    LoadState? loadState,
    String? errorMessage,
    bool clearErrorMessage = false,
    List<CarViewModel>? allCars,
    List<CarViewModel>? filteredCars,
    CarsViewMode? viewMode,
    String? searchQuery,
    int? activeFilterCount,
  }) {
    return CarsState(
      loadState: loadState ?? this.loadState,
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      allCars: allCars ?? this.allCars,
      filteredCars: filteredCars ?? this.filteredCars,
      viewMode: viewMode ?? this.viewMode,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilterCount: activeFilterCount ?? this.activeFilterCount,
    );
  }

  @override
  List<Object?> get props => [
        loadState,
        errorMessage,
        allCars,
        filteredCars,
        viewMode,
        searchQuery,
        activeFilterCount,
      ];
}
