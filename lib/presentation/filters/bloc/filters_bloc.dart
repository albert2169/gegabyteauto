import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gegabyteauto/app_constants.dart';
import 'package:gegabyteauto/models/car_brand_view_model.dart';
import 'package:gegabyteauto/models/car_model_view_model.dart';

import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  late final List<CarBrandViewModel> _allBrandModels;

  static const _gearBoxes = ['Automatic', 'Manual', 'CVT'];
  static const _engines = ['Gasoline', 'Diesel', 'Hybrid', 'Electric'];

  FiltersBloc() : super(const FiltersState.initial()) {
    on<FiltersLoadRequested>(_onLoadRequested);
    on<FiltersBrandChanged>(_onBrandChanged);
    on<FiltersModelChanged>(_onModelChanged);
    on<FiltersSeriesChanged>(_onSeriesChanged);
    on<FiltersGearBoxChanged>(_onGearBoxChanged);
    on<FiltersEngineChanged>(_onEngineChanged);
    on<FiltersPriceRangeChanged>(_onPriceRangeChanged);
    on<FiltersYearRangeChanged>(_onYearRangeChanged);
    on<FiltersApplyRequested>(_onApplyRequested);
    on<FiltersResetRequested>(_onResetRequested);
  }

  List<CarModelViewModel> _modelsForBrand(String brandName) {
    final brand = _allBrandModels.firstWhere(
      (b) => b.name == brandName,
      orElse: () => const CarBrandViewModel(
        name: '',
        logoAssetPath: '',
        models: [],
      ),
    );
    return brand.models;
  }

  void _onLoadRequested(
    FiltersLoadRequested event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(loadState: LoadState.loading));

    try {
      // Build full brand→model→series hierarchy from AppConstants
      _allBrandModels = _buildBrandModels();

      final brands = _allBrandModels.map((b) => b.name).toSet().toList()
        ..sort();

      final models = _allBrandModels
          .expand((b) => b.models)
          .map((m) => m.name)
          .toSet()
          .toList()
        ..sort();

      final series = _allBrandModels
          .expand((b) => b.models)
          .expand((m) => m.serias)
          .toSet()
          .toList()
        ..sort();

      emit(state.copyWith(
        loadState: LoadState.loaded,
        availableBrands: brands,
        availableModels: models,
        availableSeries: series,
        availableGearBoxes: List<String>.from(_gearBoxes),
        availableEngines: List<String>.from(_engines),
        allBrands: brands,
        allModels: models,
        allSeries: series,
      ));
    } catch (e) {
      emit(state.copyWith(
        loadState: LoadState.error,
        errorMessage: 'Failed to load filter options',
      ));
    }
  }

  /// Build the full brand→model→series data from AppConstants,
  /// filling in models for brands that have empty model lists.
  List<CarBrandViewModel> _buildBrandModels() {
    return AppConstants.mockCarBrandViewModels.map((brand) {
      if (brand.models.isNotEmpty) return brand;
      // Use the same fallback logic as AppConstants._availableModelsForBrand
      final models = _fallbackModels(brand.name);
      return CarBrandViewModel(
        name: brand.name,
        logoAssetPath: brand.logoAssetPath,
        models: models,
      );
    }).toList();
  }

  List<CarModelViewModel> _fallbackModels(String brandName) {
    switch (brandName) {
      case 'Rolls-Royce':
        return const [
          CarModelViewModel(name: 'Ghost', serias: ['Base', 'Black Badge']),
          CarModelViewModel(name: 'Cullinan', serias: ['SUV', 'Black Badge']),
        ];
      case 'Audi':
        return const [
          CarModelViewModel(name: 'A6', serias: ['Premium', 'S line']),
          CarModelViewModel(name: 'Q7', serias: ['Quattro', 'S line']),
        ];
      case 'Ferrari':
        return const [
          CarModelViewModel(name: 'Roma', serias: ['Coupe', 'Spider']),
          CarModelViewModel(name: '296', serias: ['GTB', 'GTS']),
        ];
      case 'Ford':
        return const [
          CarModelViewModel(name: 'Mustang', serias: ['GT', 'EcoBoost']),
          CarModelViewModel(name: 'Explorer', serias: ['XLT', 'Limited']),
        ];
      case 'Honda':
        return const [
          CarModelViewModel(name: 'Civic', serias: ['Sedan', 'Type R']),
          CarModelViewModel(name: 'CR-V', serias: ['EX', 'Touring']),
        ];
      case 'Hyundai':
        return const [
          CarModelViewModel(name: 'Elantra', serias: ['SEL', 'N Line']),
          CarModelViewModel(
              name: 'Santa Fe', serias: ['Premium', 'Calligraphy']),
        ];
      case 'Jaguar':
        return const [
          CarModelViewModel(name: 'F-PACE', serias: ['R-Dynamic', 'SVR']),
          CarModelViewModel(name: 'XE', serias: ['Standard', 'R-Dynamic']),
        ];
      case 'Jeep':
        return const [
          CarModelViewModel(name: 'Wrangler', serias: ['Sport', 'Rubicon']),
          CarModelViewModel(
              name: 'Grand Cherokee', serias: ['Limited', 'Summit']),
        ];
      case 'Kia':
        return const [
          CarModelViewModel(name: 'Sportage', serias: ['EX', 'GT Line']),
          CarModelViewModel(name: 'Sorento', serias: ['Prestige', 'X-Line']),
        ];
      case 'Lexus':
        return const [
          CarModelViewModel(name: 'RX', serias: ['350', '500h']),
          CarModelViewModel(name: 'NX', serias: ['250', '350 F Sport']),
        ];
      case 'Mazda':
        return const [
          CarModelViewModel(name: 'CX-5', serias: ['Touring', 'Signature']),
          CarModelViewModel(
              name: 'Mazda 6', serias: ['Sport', 'Grand Touring']),
        ];
      case 'Tesla':
        return const [
          CarModelViewModel(
              name: 'Model 3', serias: ['Long Range', 'Performance']),
          CarModelViewModel(
              name: 'Model Y', serias: ['Standard', 'Long Range']),
        ];
      case 'Toyota':
        return const [
          CarModelViewModel(name: 'Camry', serias: ['LE', 'XSE']),
          CarModelViewModel(name: 'RAV4', serias: ['Adventure', 'Limited']),
        ];
      case 'BMW':
        return const [
          CarModelViewModel(name: 'X5', serias: ['xDrive40i', 'M60i']),
          CarModelViewModel(name: '5 Series', serias: ['530i', '540i']),
        ];
      case 'Bentley':
        return const [
          CarModelViewModel(name: 'Bentayga', serias: ['V8', 'Azure']),
          CarModelViewModel(name: 'Continental GT', serias: ['Coupe', 'Speed']),
        ];
      case 'Porche':
        return const [
          CarModelViewModel(name: 'Cayenne', serias: ['Base', 'Turbo']),
          CarModelViewModel(name: '911', serias: ['Carrera', 'Turbo S']),
        ];
      default:
        return const [
          CarModelViewModel(name: 'Default', serias: ['Standard']),
        ];
    }
  }

  void _onBrandChanged(
    FiltersBrandChanged event,
    Emitter<FiltersState> emit,
  ) {
    List<String> filteredModels = [];
    if (event.brand != null) {
      filteredModels = _modelsForBrand(event.brand!)
          .map((m) => m.name)
          .toSet()
          .toList()
        ..sort();
    } else {
      filteredModels = _allBrandModels
          .expand((b) => b.models)
          .map((m) => m.name)
          .toSet()
          .toList()
        ..sort();
    }

    emit(state.copyWith(
      selectedBrand: event.brand,
      clearSelectedBrand: event.brand == null,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      availableModels: filteredModels,
      availableSeries: const [],
    ));
  }

  void _onModelChanged(
    FiltersModelChanged event,
    Emitter<FiltersState> emit,
  ) {
    List<String> filteredSeries = [];
    if (event.model != null && state.selectedBrand != null) {
      final models = _modelsForBrand(state.selectedBrand!);
      final model = models.where((m) => m.name == event.model);
      if (model.isNotEmpty) {
        filteredSeries = model.first.serias.toList()..sort();
      }
    } else if (state.selectedBrand != null) {
      filteredSeries = _modelsForBrand(state.selectedBrand!)
          .expand((m) => m.serias)
          .toSet()
          .toList()
        ..sort();
    }

    emit(state.copyWith(
      selectedModel: event.model,
      clearSelectedModel: event.model == null,
      clearSelectedSeries: true,
      availableSeries: filteredSeries,
    ));
  }

  void _onSeriesChanged(
    FiltersSeriesChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedSeries: event.series,
      clearSelectedSeries: event.series == null,
    ));
  }

  void _onGearBoxChanged(
    FiltersGearBoxChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedGearBox: event.gearBox,
      clearSelectedGearBox: event.gearBox == null,
    ));
  }

  void _onEngineChanged(
    FiltersEngineChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(
      selectedEngine: event.engine,
      clearSelectedEngine: event.engine == null,
    ));
  }

  void _onPriceRangeChanged(
    FiltersPriceRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(priceRange: event.range));
  }

  void _onYearRangeChanged(
    FiltersYearRangeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(yearRange: event.range));
  }

  void _onApplyRequested(
    FiltersApplyRequested event,
    Emitter<FiltersState> emit,
  ) {}

  void _onResetRequested(
    FiltersResetRequested event,
    Emitter<FiltersState> emit,
  ) {
    final allModels = _allBrandModels
        .expand((b) => b.models)
        .map((m) => m.name)
        .toSet()
        .toList()
      ..sort();
    final allSeries = _allBrandModels
        .expand((b) => b.models)
        .expand((m) => m.serias)
        .toSet()
        .toList()
      ..sort();

    emit(state.copyWith(
      clearSelectedBrand: true,
      clearSelectedModel: true,
      clearSelectedSeries: true,
      clearSelectedGearBox: true,
      clearSelectedEngine: true,
      priceRange: FiltersState.defaultPriceRange,
      yearRange: FiltersState.defaultYearRange,
      availableModels: allModels,
      availableSeries: allSeries,
    ));
  }
}
