import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class WishlistModel with ChangeNotifier {
  final String id, storeName;

  WishlistModel({
    required this.id,
    required this.storeName,
  });

  factory WishlistModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return WishlistModel(
      id: data['wishlistId'], //doc.get("productId"),
      storeName: data['store'],
    );
  }
}
