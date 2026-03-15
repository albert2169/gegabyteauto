import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_view_model.dart';

import '../bloc/filters_bloc.dart';
import '../bloc/filters_event.dart';
import '../bloc/filters_state.dart';
import 'widgets/filter_brand_dropdown.dart';
import 'widgets/filter_engine_dropdown.dart';
import 'widgets/filter_gearbox_dropdown.dart';
import 'widgets/filter_model_dropdown.dart';
import 'widgets/filter_price_slider.dart';
import 'widgets/filter_series_dropdown.dart';
import 'widgets/filter_year_slider.dart';
import 'widgets/filters_action_buttons.dart';
import 'widgets/filters_header.dart';

@RoutePage()
class FiltersScreen extends StatelessWidget {
  final List<CarViewModel> cars;

  const FiltersScreen({super.key, required this.cars});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FiltersBloc()..add(FiltersLoadRequested(cars: cars)),
      child: const _FiltersScreenContent(),
    );
  }
}

class _FiltersScreenContent extends StatelessWidget {
  const _FiltersScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const FiltersHeader(),
      body: BlocBuilder<FiltersBloc, FiltersState>(
        buildWhen: (previous, current) =>
            previous.loadState != current.loadState,
        builder: (context, state) {
          switch (state.loadState) {
            case LoadState.initial:
            case LoadState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red.shade300,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'An error occurred',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              );
            case LoadState.loaded:
              return const _FiltersBody();
          }
        },
      ),
      bottomNavigationBar: const FiltersActionButtons(),
    );
  }
}

class _FiltersBody extends StatelessWidget {
  const _FiltersBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Vehicle'),
          const SizedBox(height: 16),
          const FilterBrandDropdown(),
          const SizedBox(height: 16),
          const FilterModelDropdown(),
          const SizedBox(height: 16),
          const FilterSeriesDropdown(),
          const SizedBox(height: 32),
          _buildSectionTitle('Specifications'),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: FilterGearboxDropdown()),
              const SizedBox(width: 12),
              const Expanded(child: FilterEngineDropdown()),
            ],
          ),
          const SizedBox(height: 32),
          _buildSectionTitle('Price & Year'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            child: const Column(
              children: [
                FilterPriceSlider(),
                SizedBox(height: 24),
                FilterYearSlider(),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
