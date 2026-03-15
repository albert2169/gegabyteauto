import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_model_item.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_models_header.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_bloc.dart';
import 'package:gegabyteauto/presentation/filters/bloc/filters_state.dart';

@RoutePage()
class CarModelsScreen extends StatefulWidget {
  final CarBrandViewModel brand;

  const CarModelsScreen({super.key, required this.brand});

  @override
  State<CarModelsScreen> createState() => _CarModelsScreenState();
}

class _CarModelsScreenState extends State<CarModelsScreen> {
  final Set<int> _openIndices = {};

  void _onModelTap(int index) {

    setState(() {
      if (_openIndices.contains(index)) {
        _openIndices.remove(index);
      } else {
        _openIndices.add(index);
      }
    });
  }

  Future<void> _onHideCompleted(int index) async {
    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 50));
    if (!mounted) return;
    setState(() {
    });
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
  
  }

  void _onSeriaTap(String modelName, String seria) {
    // getIt<FiltersBloc>().add()
    final brandName = widget.brand.name;
    final filtersState = FiltersState(
      loadState: LoadState.loaded,
      selectedBrand: brandName,
      selectedModel: modelName,
      selectedSeries: seria,
      selectedGearBox: null,
      selectedEngine: null,
      priceRange: FiltersState.defaultPriceRange,
      yearRange: FiltersState.defaultYearRange,
      availableBrands: const [],
      availableModels: const [],
      availableSeries: const [],
      availableGearBoxes: const [],
      availableEngines: const [],
      allBrands: const [],
      allModels: const [],
      allSeries: const [],
    );

    context.router.pushAndPopUntil(
      ShellRoute(children: [AllCarsRoute(preAppliedFilters: filtersState)]),
      predicate: (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.maybePop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarModelsHeader(brandName: widget.brand.name),
            Expanded(
              child: ListView.builder(
                itemCount: widget.brand.models.length,
                itemBuilder: (context, index) {
                  final model = widget.brand.models[index];
                  final isOpen = _openIndices.contains(index);

                  return CarModelItem(
                    model: model,
                    index: index,
                    totalCount: widget.brand.models.length,
                    isOpen: isOpen,
                    onTap: () => _onModelTap(index),
                    onHideCompleted: () => _onHideCompleted(index),
                    onSeriaTap: (seria) => _onSeriaTap(model.name, seria),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
