// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AllCarsScreen]
class AllCarsRoute extends PageRouteInfo<void> {
  const AllCarsRoute({List<PageRouteInfo>? children})
    : super(AllCarsRoute.name, initialChildren: children);

  static const String name = 'AllCarsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AllCarsScreen();
    },
  );
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

class BrandsRoute extends PageRouteInfo<void> {
  const BrandsRoute({List<PageRouteInfo>? children})
    : super(BrandsRoute.name, initialChildren: children);

  static const String name = 'BrandsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BrandsScreen();
    },
  );
}

/// generated route for
/// [CarModelsScreen]
class CarModelsRoute extends PageRouteInfo<CarModelsRouteArgs> {
  CarModelsRoute({
    Key? key,
    required CarBrandViewModel brand,
    List<PageRouteInfo>? children,
  }) : super(
         CarModelsRoute.name,
         args: CarModelsRouteArgs(key: key, brand: brand),
         initialChildren: children,
       );

  static const String name = 'CarModelsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CarModelsRouteArgs>();
      return CarModelsScreen(key: args.key, brand: args.brand);
    },
  );
}

class CarModelsRouteArgs {
  const CarModelsRouteArgs({this.key, required this.brand});

  final Key? key;

  final CarBrandViewModel brand;

  @override
  String toString() {
    return 'CarModelsRouteArgs{key: $key, brand: $brand}';
  }
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [ShellScreen]
class ShellRoute extends PageRouteInfo<void> {
  const ShellRoute({List<PageRouteInfo>? children})
    : super(ShellRoute.name, initialChildren: children);

  static const String name = 'ShellRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ShellScreen();
    },
  );
}

/// generated route for
/// [SingleCarScreen]
class SingleCarRoute extends PageRouteInfo<SingleCarRouteArgs> {
  SingleCarRoute({
    Key? key,
    required CarViewModel car,
    List<PageRouteInfo>? children,
  }) : super(
         SingleCarRoute.name,
         args: SingleCarRouteArgs(key: key, car: car),
         initialChildren: children,
       );

  static const String name = 'SingleCarRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SingleCarRouteArgs>();
      return SingleCarScreen(key: args.key, car: args.car);
    },
  );
}

class SingleCarRouteArgs {
  const SingleCarRouteArgs({this.key, required this.car});

  final Key? key;

  final CarViewModel car;

  @override
  String toString() {
    return 'SingleCarRouteArgs{key: $key, car: $car}';
  }
}
