import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? name;
  String? category;

  int? stock;
  int quantity;

  ProductModel({
    this.docId,
    this.name,
    this.category,
    this.stock,
    this.quantity = 1,
  });

  // Convert DocumentSnapshot to ProductModel object
  ProductModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        category = data["category"] as String?,
        stock = data["stock"] as int?,
        quantity = 1;

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'category': category,
      'stock': stock,
      'quantity': quantity,
    };
  }
}
