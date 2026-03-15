import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_model_item.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_models_header.dart';

@RoutePage()
class CarModelsScreen extends StatefulWidget {
  final CarBrandViewModel brand;

  const CarModelsScreen({super.key, required this.brand});

  @override
  State<CarModelsScreen> createState() => _CarModelsScreenState();
}

class _CarModelsScreenState extends State<CarModelsScreen> {
  final Set<int> _openIndices = {};
  final Set<int> _closingIndices = {};
  final Set<int> _collapsingIndices = {};

  void _onModelTap(int index) {
    if (_closingIndices.contains(index)) return;

    setState(() {
      if (_openIndices.contains(index)) {
        _openIndices.remove(index);
        _closingIndices.add(index);
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
      _closingIndices.remove(index);
      _collapsingIndices.add(index);
    });
    await Future.delayed(const Duration(milliseconds: 350));
    if (!mounted) return;
    setState(() {
      _collapsingIndices.remove(index);
    });
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarModelsHeader(brandName: widget.brand.name),
          Expanded(
            child: ListView.builder(
              itemCount: widget.brand.models.length,
              itemBuilder: (context, index) {
                final model = widget.brand.models[index];
                final isOpen = _openIndices.contains(index) ||
                    _closingIndices.contains(index);
                final isClosing = _closingIndices.contains(index);
                final isCollapsing = _collapsingIndices.contains(index);

                return CarModelItem(
                  model: model,
                  index: index,
                  totalCount: widget.brand.models.length,
                  isOpen: isOpen,
                  isClosing: isClosing,
                  isCollapsing: isCollapsing,
                  onTap: () => _onModelTap(index),
                  onHideCompleted: () => _onHideCompleted(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
