import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_bloc.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/categories_section_header.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/custom_search_bar.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/custom_sliver_app_bar.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/main_screen_car_categories.dart';
import 'package:gegabyteauto/presentation/home/screens/widgets/main_screen_sections.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FiltersBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    CustomSearchBar(),
                    const SizedBox(height: 32),
                    MainScreenSections(),
                    const SizedBox(height: 32),
                    CategoriesSectionHeader(),
                    const SizedBox(height: 16),
                    MainScreenCarCategories(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
