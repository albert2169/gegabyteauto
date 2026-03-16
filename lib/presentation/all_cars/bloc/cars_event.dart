import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/models/car_filter_view_model.dart';

import 'cars_state.dart';

abstract class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllCarsEvent extends CarsEvent {
  final bool isInitialFetch;
  final String? searchText;
  final CarFilterViewModel? appliedFilters;
  const FetchAllCarsEvent({
     this.searchText,
     this.appliedFilters,
    this.isInitialFetch = false,
  });
}



class CarsViewModeChanged extends CarsEvent {
  final CarsViewMode viewMode;

  const CarsViewModeChanged(this.viewMode);

  @override
  List<Object?> get props => [viewMode];
}





class CarsFiltersClear extends CarsEvent {
  const CarsFiltersClear();
}
