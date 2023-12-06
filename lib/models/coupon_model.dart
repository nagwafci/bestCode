import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CouponModel with ChangeNotifier {
  final String couponId,
      couponTitle,
      couponCode,
      couponStore,
      couponDescription,
      couponImage;

  CouponModel( {
    required this.couponTitle,
    required this.couponId,
    required this.couponCode,
    required this.couponStore,
    required this.couponDescription,
    required this.couponImage,
  });

  factory CouponModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return CouponModel(
      couponId: data['couponId'], //doc.get("productId"),
      couponCode: data['couponCode'],
      couponStore: data['couponStore'],
      couponDescription: data['couponDescription'],
      couponImage: data['couponImage'],
      couponTitle: data['couponTitle']

    );
  }
}
