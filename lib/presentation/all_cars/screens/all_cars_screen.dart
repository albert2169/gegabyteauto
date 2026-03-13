import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/core/di/injection.dart';
import 'package:gegabyteauto/core/theme/app_colors.dart';
import 'package:gegabyteauto/core/theme/app_text_styles.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_bloc.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_event.dart';
import 'package:gegabyteauto/presentation/all_cars/bloc/cars_state.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_grid_view.dart';
import 'package:gegabyteauto/presentation/all_cars/widgets/car_reels_view.dart';
import 'package:gegabyteauto/presentation/view_models/car_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gegabyteauto/core/router/app_router.dart';
import 'package:shimmer/shimmer.dart';

enum _ViewMode { list, grid, reels }

@RoutePage()
class AllCarsScreen extends StatelessWidget {
  const AllCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CarsBloc>()..add(const CarsLoadRequested()),
      child: const _AllCarsView(),
    );
  }
}

class _AllCarsView extends StatefulWidget {
  const _AllCarsView();

  @override
  State<_AllCarsView> createState() => _AllCarsViewState();
}

class _AllCarsViewState extends State<_AllCarsView> {
  _ViewMode _viewMode = _ViewMode.list;

  final _searchController = TextEditingController();
  bool _showFilters = false;

  String? _selectedBrand;
  String? _selectedGearBox;
  String? _selectedEngine;
  RangeValues _priceRange = const RangeValues(0, 250000);
  RangeValues _yearRange = const RangeValues(2015, 2025);

  List<CarViewModel> _allCars = [];
  List<CarViewModel> _filteredCars = [];

  List<String> _brands = [];
  List<String> _gearBoxes = [];
  List<String> _engines = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCarsLoaded(List<CarViewModel> cars) {
    _allCars = cars;
    _brands = cars.map((c) => c.singleCarInfoViewModel.brand).toSet().toList()
      ..sort();
    _gearBoxes =
        cars.map((c) => c.singleCarInfoViewModel.gearBox).toSet().toList();
    _engines =
        cars.map((c) => c.singleCarInfoViewModel.engine).toSet().toList();
    _applyFilters();
  }

  double _parsePriceValue(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  int _parseYear(String year) => int.tryParse(year) ?? 2020;

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCars = _allCars.where((car) {
        final info = car.singleCarInfoViewModel;

        if (query.isNotEmpty) {
          final searchable =
              '${info.brand} ${info.model} ${car.seria} ${info.color} ${info.engine}'
                  .toLowerCase();
          if (!searchable.contains(query)) return false;
        }

        if (_selectedBrand != null && info.brand != _selectedBrand) {
          return false;
        }
        if (_selectedGearBox != null && info.gearBox != _selectedGearBox) {
          return false;
        }
        if (_selectedEngine != null && info.engine != _selectedEngine) {
          return false;
        }

        final price = _parsePriceValue(info.price);
        if (price < _priceRange.start || price > _priceRange.end) {
          return false;
        }

        final year = _parseYear(info.year);
        if (year < _yearRange.start || year > _yearRange.end) return false;

        return true;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _selectedBrand = null;
      _selectedGearBox = null;
      _selectedEngine = null;
      _priceRange = const RangeValues(0, 250000);
      _yearRange = const RangeValues(2015, 2025);
      _filteredCars = List.of(_allCars);
    });
  }

  bool get _hasActiveFilters =>
      _selectedBrand != null ||
      _selectedGearBox != null ||
      _selectedEngine != null ||
      _priceRange != const RangeValues(0, 250000) ||
      _yearRange != const RangeValues(2015, 2025) ||
      _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarsBloc, CarsState>(
      listenWhen: (_, current) => current is CarsLoaded,
      listener: (context, state) {
        if (state is CarsLoaded) {
          _onCarsLoaded(state.allCars);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: _buildAppBar(context),
          body: SafeArea(
            top: false,
            child: _buildScaffoldBody(context, state),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      title: Text('Browse Cars', style: AppTextStyles.headlineMedium),
      actions: [
        _viewModeButton(Icons.view_list_rounded, _ViewMode.list),
        _viewModeButton(Icons.grid_view_rounded, _ViewMode.grid),
        _viewModeButton(Icons.slow_motion_video_rounded, _ViewMode.reels),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildScaffoldBody(BuildContext context, CarsState state) {
    if (state is CarsLoading) return _buildShimmer();
    if (state is CarsError) return _buildError(context, state.message);

    // Show content (loaded or initial)
    return Column(
      children: [
        _buildSearchBar(),
        if (_showFilters) _buildFilterPanel(),
        if (_hasActiveFilters) _buildActiveFilterChips(),
        _buildCountBar(),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _filteredCars.isEmpty && _allCars.isNotEmpty
                ? _buildEmptyState()
                : _buildBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'Search brand, model, color...',
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3),
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 22,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.white.withValues(alpha: 0.4),
                            size: 20,
                          ),
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => setState(() => _showFilters = !_showFilters),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: _showFilters || _hasActiveFilters
                    ? AppColors.primary
                    : Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.tune, color: Colors.white, size: 22),
                  ),
                  if (_hasActiveFilters)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2ECC71),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPanel() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _filterDropdown(
              label: 'Brand',
              value: _selectedBrand,
              items: _brands,
              onChanged: (v) {
                setState(() => _selectedBrand = v);
                _applyFilters();
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _filterDropdown(
                    label: 'Gearbox',
                    value: _selectedGearBox,
                    items: _gearBoxes,
                    onChanged: (v) {
                      setState(() => _selectedGearBox = v);
                      _applyFilters();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _filterDropdown(
                    label: 'Engine',
                    value: _selectedEngine,
                    items: _engines,
                    onChanged: (v) {
                      setState(() => _selectedEngine = v);
                      _applyFilters();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildRangeSlider(
              label: 'Price',
              values: _priceRange,
              min: 0,
              max: 250000,
              prefix: '\$',
              onChanged: (v) {
                _priceRange = v;
                _applyFilters();
              },
            ),
            const SizedBox(height: 12),
            _buildRangeSlider(
              label: 'Year',
              values: _yearRange,
              min: 2015,
              max: 2025,
              prefix: '',
              divisions: 10,
              onChanged: (v) {
                _yearRange = v;
                _applyFilters();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                'All',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.3), fontSize: 13),
              ),
              dropdownColor: const Color(0xFF1C1C1E),
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: Colors.white.withValues(alpha: 0.4), size: 20),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              items: [
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('All', style: TextStyle(color: Colors.white54)),
                ),
                ...items.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    )),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRangeSlider({
    required String label,
    required RangeValues values,
    required double min,
    required double max,
    required String prefix,
    required ValueChanged<RangeValues> onChanged,
    int? divisions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              '$prefix${values.start.round()} — $prefix${values.end.round()}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
            thumbColor: Colors.white,
            overlayColor: AppColors.primary.withValues(alpha: 0.15),
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: values,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: (v) => setState(() => onChanged(v)),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveFilterChips() {
    final chips = <Widget>[];

    if (_selectedBrand != null) {
      chips.add(_activeChip(_selectedBrand!, () {
        setState(() => _selectedBrand = null);
        _applyFilters();
      }));
    }
    if (_selectedGearBox != null) {
      chips.add(_activeChip(_selectedGearBox!, () {
        setState(() => _selectedGearBox = null);
        _applyFilters();
      }));
    }
    if (_selectedEngine != null) {
      chips.add(_activeChip(_selectedEngine!, () {
        setState(() => _selectedEngine = null);
        _applyFilters();
      }));
    }

    if (chips.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
      child: SizedBox(
        height: 32,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: chips.length,
          separatorBuilder: (_, __) => const SizedBox(width: 6),
          itemBuilder: (_, i) => chips[i],
        ),
      ),
    );
  }

  Widget _activeChip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onRemove,
            child: const Icon(Icons.close, color: Colors.white54, size: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildCountBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Text(
            '${_filteredCars.length} cars found',
            style: AppTextStyles.bodySmall
                .copyWith(color: AppColors.textSecondary),
          ),
          const Spacer(),
          if (_hasActiveFilters)
            GestureDetector(
              onTap: _resetFilters,
              child: Text(
                'Clear all',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
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
              ? AppColors.primary
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
        return _buildListView();
      case _ViewMode.grid:
        return CarGridView(key: const ValueKey('grid'), cars: _filteredCars);
      case _ViewMode.reels:
        return CarReelsView(key: const ValueKey('reels'), cars: _filteredCars);
    }
  }

  Widget _buildListView() {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CarsBloc>().add(const CarsRefreshRequested());
      },
      color: AppColors.primary,
      backgroundColor: AppColors.surface,
      child: ListView.separated(
        key: const ValueKey('list'),
        padding: const EdgeInsets.all(16),
        itemCount: _filteredCars.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _CarCard(
            car: _filteredCars[index],
            onTap: () => context.pushRoute(
              SingleCarRoute(car: _filteredCars[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      key: const ValueKey('empty'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            color: Colors.white.withValues(alpha: 0.15),
            size: 64,
          ),
          const SizedBox(height: 16),
          Text('No cars found', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _resetFilters,
            child: Text(
              'Reset filters',
              style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceVariant,
      highlightColor: AppColors.surface,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 56, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Something went wrong', style: AppTextStyles.headlineMedium),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () =>
                  context.read<CarsBloc>().add(const CarsLoadRequested()),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Car List Card ────────────────────────────────────────────────────────────

class _CarCard extends StatelessWidget {
  final CarViewModel car;
  final VoidCallback onTap;

  const _CarCard({required this.car, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final info = car.singleCarInfoViewModel;
    final imageUrl =
        info.images.isNotEmpty ? info.images.first.networkImageUrl : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border, width: 0.5),
        ),
        child: Row(
          children: [
            // Car image
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20)),
              child: SizedBox(
                width: 130,
                height: 130,
                child: imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Shimmer.fromColors(
                          baseColor: AppColors.surfaceVariant,
                          highlightColor: AppColors.surface,
                          child: Container(color: Colors.white),
                        ),
                        errorWidget: (_, __, ___) => const _CarImageFallback(),
                      )
                    : const _CarImageFallback(),
              ),
            ),
            // Car info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${info.brand} ${info.model}',
                          style: AppTextStyles.headlineSmall
                              .copyWith(fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          car.seria,
                          style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _InfoBadge(label: info.year),
                        const SizedBox(width: 6),
                        _InfoBadge(label: info.gearBox),
                        const SizedBox(width: 6),
                        _InfoBadge(label: info.engine),
                      ],
                    ),
                    Text(
                      info.price,
                      style: AppTextStyles.price.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;

  const _InfoBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
      ),
    );
  }
}

class _CarImageFallback extends StatelessWidget {
  const _CarImageFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surfaceVariant,
      child: const Icon(
        Icons.directions_car_rounded,
        color: AppColors.textHint,
        size: 40,
      ),
    );
  }
}
