// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gegabyteauto/presentation/filters/bloc/filters_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/car_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/car_repository_impl.dart';
import '../../domain/repositories/i_auth_repository.dart';
import '../../domain/repositories/i_car_repository.dart';
import '../../presentation/all_cars/bloc/cars_bloc.dart';
import '../../presentation/auth/bloc/auth_bloc.dart';

extension GetItInjectableX on GetIt {
  GetIt init({
    String? environment,
    EnvironmentFilter? environmentFilter,
  }) {
    final gh = GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<ICarRemoteDataSource>(() => CarRemoteDataSource());
    gh.lazySingleton<IAuthRepository>(() => AuthRepository());
    gh.lazySingleton<ICarRepository>(
        () => CarRepository(gh<ICarRemoteDataSource>()));
    gh.lazySingleton<FiltersBloc>(() => FiltersBloc());
    gh.factory<AuthBloc>(() => AuthBloc(gh<IAuthRepository>()));
    gh.lazySingleton<CarsBloc>(() => CarsBloc(gh<ICarRepository>()));
    return this;
  }
}
