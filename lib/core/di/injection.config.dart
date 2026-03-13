// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/datasources/car_remote_data_source.dart' as _i844;
import '../../data/repositories/auth_repository_impl.dart' as _i895;
import '../../data/repositories/car_repository_impl.dart' as _i1046;
import '../../domain/repositories/i_auth_repository.dart' as _i841;
import '../../domain/repositories/i_car_repository.dart' as _i689;
import '../../presentation/all_cars/bloc/cars_bloc.dart' as _i200;
import '../../presentation/auth/bloc/auth_bloc.dart' as _i476;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i844.ICarRemoteDataSource>(
        () => _i844.CarRemoteDataSource());
    gh.lazySingleton<_i841.IAuthRepository>(() => _i895.AuthRepository());
    gh.lazySingleton<_i689.ICarRepository>(
        () => _i1046.CarRepository(gh<_i844.ICarRemoteDataSource>()));
    gh.factory<_i476.AuthBloc>(
        () => _i476.AuthBloc(gh<_i841.IAuthRepository>()));
    gh.factory<_i200.CarsBloc>(
        () => _i200.CarsBloc(gh<_i689.ICarRepository>()));
    return this;
  }
}
