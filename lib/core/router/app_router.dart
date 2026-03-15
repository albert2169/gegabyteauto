import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// Route argument types
import 'package:gegabyteauto/models/car_brand_view_model.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
// Screens
import 'package:gegabyteauto/presentation/auth/auth_screen/auth_screen.dart';
import 'package:gegabyteauto/presentation/shell/screens/shell_screen.dart';
import 'package:gegabyteauto/presentation/home/screens/home_screen.dart';
import 'package:gegabyteauto/presentation/all_cars/screens/all_cars_screen.dart';
import 'package:gegabyteauto/presentation/favorites/screens/favorites_screen.dart';
import 'package:gegabyteauto/presentation/profile/screens/profile_screen.dart';
import 'package:gegabyteauto/presentation/brands/screens/brands_screen.dart';
import 'package:gegabyteauto/presentation/car_models_screen/car_models_main_screen.dart';
import 'package:gegabyteauto/presentation/single_car/screens/single_car_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AuthRoute.page, initial: true),
        AutoRoute(
          page: ShellRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: AllCarsRoute.page),
            AutoRoute(page: FavoritesRoute.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: BrandsRoute.page),
        AutoRoute(page: CarModelsRoute.page),
        AutoRoute(page: SingleCarRoute.page),
      ];
}
