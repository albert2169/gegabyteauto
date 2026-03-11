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
  List<CarViewModel> _allCars = [];
  List<CarViewModel> _filteredCars = [];
  _ViewMode _viewMode = _ViewMode.list;

  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;

  // Filter state
  String? _selectedBrand;
  String? _selectedGearBox;
  String? _selectedEngine;
  RangeValues _priceRange = const RangeValues(0, 250000);
  RangeValues _yearRange = const RangeValues(2015, 2025);

  late final List<String> _brands;
  late final List<String> _gearBoxes;
  late final List<String> _engines;

  @override
  void initState() {
    super.initState();
    _allCars = [...AppConstants.mockCarViewModels];
    _filteredCars = _allCars;
    _searchController.addListener(_applyFilters);

    _brands = _allCars
        .map((c) => c.singleCarInfoViewModel.brand)
        .toSet()
        .toList()
      ..sort();
    _gearBoxes =
        _allCars.map((c) => c.singleCarInfoViewModel.gearBox).toSet().toList();
    _engines =
        _allCars.map((c) => c.singleCarInfoViewModel.engine).toSet().toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  double _parsePriceValue(String price) {
    final cleaned = price.replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  int _parseYear(String year) {
    return int.tryParse(year) ?? 2020;
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredCars = _allCars.where((car) {
        final info = car.singleCarInfoViewModel;

        // Search text
        if (query.isNotEmpty) {
          final searchable =
              '${info.brand} ${info.model} ${car.seria} ${info.color} ${info.engine}'
                  .toLowerCase();
          if (!searchable.contains(query)) return false;
        }

        // Brand filter
        if (_selectedBrand != null && info.brand != _selectedBrand) {
          return false;
        }

        // GearBox filter
        if (_selectedGearBox != null && info.gearBox != _selectedGearBox) {
          return false;
        }

        // Engine filter
        if (_selectedEngine != null && info.engine != _selectedEngine) {
          return false;
        }

        // Price filter
        final price = _parsePriceValue(info.price);
        if (price < _priceRange.start || price > _priceRange.end) {
          return false;
        }

        // Year filter
        final year = _parseYear(info.year);
        if (year < _yearRange.start || year > _yearRange.end) {
          return false;
        }

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
      _filteredCars = _allCars;
    });
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
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),

          // Filter chips & panel
          if (_showFilters) _buildFilterPanel(),

          // Active filter chips
          if (_hasActiveFilters) _buildActiveFilterChips(),

          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${_filteredCars.length} cars found',
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                if (_hasActiveFilters)
                  GestureDetector(
                    onTap: _resetFilters,
                    child: const Text(
                      'Clear all',
                      style: TextStyle(
                        color: Color(0xFF3255ED),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Car list / grid / reels
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _filteredCars.isEmpty ? _buildEmptyState() : _buildBody(),
            ),
          ),
        ],
      ),
    );
  }

  bool get _hasActiveFilters =>
      _selectedBrand != null ||
      _selectedGearBox != null ||
      _selectedEngine != null ||
      _priceRange != const RangeValues(0, 250000) ||
      _yearRange != const RangeValues(2015, 2025);

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
                style: const TextStyle(color: Colors.white, fontSize: 15),
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
                            _applyFilters();
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
                    ? const Color(0xFF3255ED)
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
            // Brand dropdown
            _filterDropdown(
              label: 'Brand',
              value: _selectedBrand,
              items: _brands,
              onChanged: (v) {
                _selectedBrand = v;
                _applyFilters();
              },
            ),
            const SizedBox(height: 12),

            // Gearbox + Engine row
            Row(
              children: [
                Expanded(
                  child: _filterDropdown(
                    label: 'Gearbox',
                    value: _selectedGearBox,
                    items: _gearBoxes,
                    onChanged: (v) {
                      _selectedGearBox = v;
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
                      _selectedEngine = v;
                      _applyFilters();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Price range
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

            // Year range
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
              '$prefix${values.start.round()} - $prefix${values.end.round()}',
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
            activeTrackColor: const Color(0xFF3255ED),
            inactiveTrackColor: Colors.white.withValues(alpha: 0.1),
            thumbColor: Colors.white,
            overlayColor: const Color(0xFF3255ED).withValues(alpha: 0.15),
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
      chips.add(_chip(_selectedBrand!, () {
        _selectedBrand = null;
        _applyFilters();
      }));
    }
    if (_selectedGearBox != null) {
      chips.add(_chip(_selectedGearBox!, () {
        _selectedGearBox = null;
        _applyFilters();
      }));
    }
    if (_selectedEngine != null) {
      chips.add(_chip(_selectedEngine!, () {
        _selectedEngine = null;
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

  Widget _chip(String label, VoidCallback onRemove) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3255ED).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: const Color(0xFF3255ED).withValues(alpha: 0.4)),
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

  Widget _buildEmptyState() {
    return Center(
      key: const ValueKey('empty'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_off,
            color: Colors.white.withValues(alpha: 0.15),
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'No cars found',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _resetFilters,
            child: const Text(
              'Reset filters',
              style: TextStyle(
                color: Color(0xFF3255ED),
                fontSize: 14,
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
        return CarListView(key: const ValueKey('list'), cars: _filteredCars);
      case _ViewMode.grid:
        return CarGridView(key: const ValueKey('grid'), cars: _filteredCars);
      case _ViewMode.reels:
        return CarReelsView(key: const ValueKey('reels'), cars: _filteredCars);
    }
  }
}
