import 'package:bestcode2023/models/coupon_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CouponProvider with ChangeNotifier {
  final List<CouponModel> _products = [];

  List<CouponModel> get getProducts {
    return _products;
  }

  CouponModel? findByProdId(String productId) {
    if (_products
        .where((element) => element.couponId == productId)
        .isEmpty) {
      return null;
    }
    return _products.firstWhere((element) => element.couponId == productId);
  }

   List<CouponModel> findByCategory({required String ctgName}) {
    List<CouponModel> ctgList = _products
        .where((element) => element.couponStore
        .toLowerCase()
        .contains(ctgName.toLowerCase()))
        .toList();
    return ctgList;
  }

  List<CouponModel> searchQuery(
      {required String searchText, required List<CouponModel> passedList}) {
    List<CouponModel> searchList = passedList
        .where((element) =>
        element.couponStore
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final productDB = FirebaseFirestore.instance.collection("coupons");

  Future<List<CouponModel>> fetchProducts() async {
    try {
      await productDB
          .get()
          .then((productsSnapshot) {
        _products.clear();
        for (var element in productsSnapshot.docs) {
          _products.insert(0, CouponModel.fromFirestore(element));
        }
      });
      notifyListeners();
      return _products;
    } catch (error) {
      rethrow;
    }
  }

  Stream<List<CouponModel>> fetchProductsStream() {
    try {
      return productDB.snapshots().map((snapshot) {
        _products.clear();
        // _products = [];
        for (var element in snapshot.docs) {
          _products.insert(0, CouponModel.fromFirestore(element));
        }
        return _products;
      });
    } catch (e) {
      rethrow;
    }
  }
}