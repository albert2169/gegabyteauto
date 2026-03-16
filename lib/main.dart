import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_theme.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(GegabyteAutoApp());
}

class GegabyteAutoApp extends StatelessWidget {
  GegabyteAutoApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FiltersBloc>(),
      child: MaterialApp.router(
        title: 'Gegabyte Auto',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}
