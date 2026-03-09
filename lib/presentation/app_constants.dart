import 'models/car_model.dart';

class AppConstants {
  AppConstants._(); // private ctor

  static const String carBrandsAssetDir = 'assets/car_brands/';

  static final List<CarModel> mockCarModels = [
    CarModel(name: 'Rolls-Royce', assetPath: '${carBrandsAssetDir}image1.png'),
    CarModel(name: 'Audi', assetPath: '${carBrandsAssetDir}image2.png'),
    CarModel(name: 'Ferrari', assetPath: '${carBrandsAssetDir}image3.png'),
    CarModel(name: 'Ford', assetPath: '${carBrandsAssetDir}image4.png'),
    CarModel(name: 'Honda', assetPath: '${carBrandsAssetDir}image5.png'),
    CarModel(name: 'Hyundai', assetPath: '${carBrandsAssetDir}image6.png'),
    CarModel(name: 'Infiniti', assetPath: '${carBrandsAssetDir}image7.png'),
    CarModel(name: 'Jaguar', assetPath: '${carBrandsAssetDir}image8.png'),
    CarModel(name: 'Jeep', assetPath: '${carBrandsAssetDir}image9.png'),
    CarModel(name: 'Kia', assetPath: '${carBrandsAssetDir}image10.png'),
    CarModel(name: 'Ferrari', assetPath: '${carBrandsAssetDir}image11.png'),
    CarModel(name: 'Lexus', assetPath: '${carBrandsAssetDir}image12.png'),
    CarModel(name: 'Mazda', assetPath: '${carBrandsAssetDir}image13.png'),
    CarModel(name: 'Tesla', assetPath: '${carBrandsAssetDir}image14.png'),
    CarModel(name: 'Toyota', assetPath: '${carBrandsAssetDir}image15.png'),
    CarModel(name: 'Mercedes', assetPath: '${carBrandsAssetDir}image16.png'),
    CarModel(name: 'BMW', assetPath: '${carBrandsAssetDir}image17.png'),
    CarModel(name: 'Bentley', assetPath: '${carBrandsAssetDir}image18.png'),
    CarModel(name: 'Porche', assetPath: '${carBrandsAssetDir}image19.png'),
  ]..sort((a, b) => a.name.compareTo(b.name));
}
