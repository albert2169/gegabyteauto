import 'package:equatable/equatable.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object?> get props => [];
}

class CarsLoadRequested extends CarsEvent {
  const CarsLoadRequested();
}

class CarsRefreshRequested extends CarsEvent {
  const CarsRefreshRequested();
}

class CarsFilterChanged extends CarsEvent {
  final String? searchQuery;
  final String? brand;
  final String? gearBox;
  final String? engine;
  final double? minPrice;
  final double? maxPrice;
  final double? minYear;
  final double? maxYear;

  const CarsFilterChanged({
    this.searchQuery,
    this.brand,
    this.gearBox,
    this.engine,
    this.minPrice,
    this.maxPrice,
    this.minYear,
    this.maxYear,
  });

  @override
  List<Object?> get props => [
        searchQuery,
        brand,
        gearBox,
        engine,
        minPrice,
        maxPrice,
        minYear,
        maxYear
      ];
}

class CarsFilterReset extends CarsEvent {
  const CarsFilterReset();
}
