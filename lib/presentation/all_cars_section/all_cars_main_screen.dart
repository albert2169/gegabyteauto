import 'package:flutter/material.dart';
import 'package:gegabyteauto/app_constants.dart';
import 'package:gegabyteauto/models/car_view_model.dart';
import 'package:gegabyteauto/presentation/all_cars_section/widgets/car_list_view.dart';
import 'package:gegabyteauto/presentation/all_cars_section/widgets/car_grid_view.dart';
import 'package:gegabyteauto/presentation/all_cars_section/widgets/car_reels_view.dart';

enum _ViewMode { list, grid, reels }

class AllCarsMainScreen extends StatefulWidget {
  const AllCarsMainScreen({super.key});

  @override
  State<AllCarsMainScreen> createState() => _AllCarsMainScreenState();
}

class _AllCarsMainScreenState extends State<AllCarsMainScreen> {
  List<CarViewModel> _cars = [];
  _ViewMode _viewMode = _ViewMode.list;

  @override
  void initState() {
    super.initState();
    _cars = [...AppConstants.mockCarViewModels];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'All Cars',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          _viewModeButton(Icons.view_list_rounded, _ViewMode.list),
          _viewModeButton(Icons.grid_view_rounded, _ViewMode.grid),
          _viewModeButton(Icons.slow_motion_video_rounded, _ViewMode.reels),
          const SizedBox(width: 8),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildBody(),
      ),
    );
  }

  Widget _viewModeButton(IconData icon, _ViewMode mode) {
    final isSelected = _viewMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _viewMode = mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF3255ED)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white54,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_viewMode) {
      case _ViewMode.list:
        return CarListView(key: const ValueKey('list'), cars: _cars);
      case _ViewMode.grid:
        return CarGridView(key: const ValueKey('grid'), cars: _cars);
      case _ViewMode.reels:
        return CarReelsView(key: const ValueKey('reels'), cars: _cars);
    }
  }
}
