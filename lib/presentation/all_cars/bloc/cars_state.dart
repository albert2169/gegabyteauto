import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';

abstract class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object?> get props => [];
}

class CarsInitial extends CarsState {
  const CarsInitial();
}

class CarsLoading extends CarsState {
  const CarsLoading();
}

class CarsLoaded extends CarsState {
  final List<CarViewModel> allCars;
  final List<CarViewModel> filteredCars;
  final String? searchQuery;
  final String? selectedBrand;
  final String? selectedGearBox;
  final String? selectedEngine;

  const CarsLoaded({
    required this.allCars,
    required this.filteredCars,
    this.searchQuery,
    this.selectedBrand,
    this.selectedGearBox,
    this.selectedEngine,
  });

  bool get hasActiveFilters =>
      (searchQuery?.isNotEmpty ?? false) ||
      selectedBrand != null ||
      selectedGearBox != null ||
      selectedEngine != null;

  CarsLoaded copyWith({
    List<CarViewModel>? allCars,
    List<CarViewModel>? filteredCars,
    String? searchQuery,
    String? selectedBrand,
    String? selectedGearBox,
    String? selectedEngine,
  }) {
    return CarsLoaded(
      allCars: allCars ?? this.allCars,
      filteredCars: filteredCars ?? this.filteredCars,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBrand: selectedBrand ?? this.selectedBrand,
      selectedGearBox: selectedGearBox ?? this.selectedGearBox,
      selectedEngine: selectedEngine ?? this.selectedEngine,
    );
  }

  @override
  List<Object?> get props => [
        allCars,
        filteredCars,
        searchQuery,
        selectedBrand,
        selectedGearBox,
        selectedEngine,
      ];
}

class CarsError extends CarsState {
  final String message;

  const CarsError({required this.message});

  @override
  List<Object?> get props => [message];
}
