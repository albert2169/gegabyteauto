import 'package:equatable/equatable.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

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

  const CarsLoaded({
    required this.allCars,
  });

  @override
  List<Object?> get props => [allCars];
}

class CarsError extends CarsState {
  final String message;

  const CarsError({required this.message});

  @override
  List<Object?> get props => [message];
}
