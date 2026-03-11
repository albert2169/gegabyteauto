import 'package:flutter/material.dart';
import 'package:gegabyteauto/models/car_model_view_model.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_model_item.dart';
import 'package:gegabyteauto/presentation/car_models_screen/widgets/car_models_header.dart';

class CarModelsMainScreen extends StatefulWidget {
  final List<CarModelViewModel> models;
  final String brandName;
  const CarModelsMainScreen({
    super.key,
    required this.models,
    required this.brandName,
  });

  @override
  State<CarModelsMainScreen> createState() => _CarModelsMainScreenState();
}

class _CarModelsMainScreenState extends State<CarModelsMainScreen> {
  final Set<int> _openIndices = {};
  final Set<int> _closingIndices = {};
  final Set<int> _collapsingIndices = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CarModelsHeader(brandName: widget.brandName),
              ),
              Expanded(
                  child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.models.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CarModelItem(
                      model: widget.models[i],
                      index: i,
                      totalCount: widget.models.length,
                      isOpen: _openIndices.contains(i),
                      isClosing: _closingIndices.contains(i),
                      isCollapsing: _collapsingIndices.contains(i),
                      onTap: () => _onModelTap(i),
                      onHideCompleted: () => _onHideCompleted(i),
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _onModelTap(int index) {
    final isOpen = _openIndices.contains(index);

    setState(() {
      if (isOpen) {
        _openIndices.remove(index);
        _closingIndices.add(index);
      } else {
        _openIndices.add(index);
        _closingIndices.remove(index);
        _collapsingIndices.remove(index);
      }
    });
  }

  Future<void> _onHideCompleted(int index) async {
    if (!mounted) return;

    setState(() {
      _closingIndices.remove(index);
      _collapsingIndices.add(index);
    });

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    setState(() {
      _collapsingIndices.remove(index);
    });
  }
}
