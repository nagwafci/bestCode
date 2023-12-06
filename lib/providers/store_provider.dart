import 'package:bestcode2023/models/store_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class StoreProvider with ChangeNotifier {
  final List<StoreModel> _products = [];

  List<StoreModel> get getProducts {
    return _products;
  }

  StoreModel? findByName(String storeName) {
    if (_products
        .where((element) =>
            element.name.toLowerCase().contains(storeName.toLowerCase()))
        .isEmpty) {
      return null;
    }
    return _products.firstWhere((element) => element.name == storeName);
  }

  List<StoreModel> findByCategory(name, {required String ctgName}) {
    List<StoreModel> ctgList = _products
        .where((element) =>
            element.name.toLowerCase().contains(ctgName.toLowerCase()))
        .toList();
    return ctgList;
  }

  final productDB = FirebaseFirestore.instance.collection("stores");

  Future<List<StoreModel>> fetchProducts() async {
    try {
      await productDB.get().then((productsSnapshot) {
        _products.clear();
        for (var element in productsSnapshot.docs) {
          _products.insert(0, StoreModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return _products;
    } catch (error) {
      rethrow;
    }
  }

  Stream<List<StoreModel>> fetchProductsStream() {
    try {
      return productDB.snapshots().map((snapshot) {
        _products.clear();
        // _products = [];
        for (var element in snapshot.docs) {
          _products.insert(0, StoreModel.fromFirestore(element));
        }
        return _products;
      });
    } catch (e) {
      rethrow;
    }
  }
}
