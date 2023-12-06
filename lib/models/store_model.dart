import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String image, name;

  StoreModel({
    required this.image,
    required this.name,
  });

  factory StoreModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StoreModel(
      name: data['storeTitle'], //doc.get("productId"),
      image: data['storeImage'],
    );
  }
}
