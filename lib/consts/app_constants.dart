import '../models/store_model.dart';
import '../services/assets_manager.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static List<StoreModel> categoriesList = [
    StoreModel(
      name: "almall",
      image: AssetsManager.almall,
    ),
    StoreModel(
      name: "centrepoint",
      image: AssetsManager.centrepoint,
    ),
    StoreModel(
      name: "hm",
      image: AssetsManager.hm,
    ),
    StoreModel(
      name: "kul",
      image: AssetsManager.kul,
    ),
    StoreModel(
      name: "lacoste",
      image: AssetsManager.lacoste,
    ),
    StoreModel(
      name: "maxfashion",
      image: AssetsManager.maxfashion,
    ),
    StoreModel(
      name: "mumzworld",
      image: AssetsManager.mumzworld,
    ),
    StoreModel(
      name: "noon",
      image: AssetsManager.noon,
    ),
  ];
}
