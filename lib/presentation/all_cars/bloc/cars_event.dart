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
