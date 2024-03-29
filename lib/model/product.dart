import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? name;
  String? category;
  // String? totalcategory;
  // int? categoryqty;
  // double? rate;
  int? stock;
  int quantity;

  ProductModel({
    this.docId,
    this.name,
    this.category,
    // this.totalcategory,
    // this.categoryqty,
    // this.rate,
    this.stock,
    this.quantity = 1,
  });

  // Convert DocumentSnapshot to ProductModel object
  ProductModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        category = data["category"] as String?,
        // totalcategory = data["totalcategory"] as String?,
        // categoryqty = data["categoryqty"] as int?,
        // rate = data["rate"] as double?,
        stock = data["stock"] as int?,
        quantity = 1;

  // Convert ProductModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'category': category,
      // 'totalcategory': totalcategory,
      // 'categoryqty': categoryqty,
      // 'rate': rate,
      'stock': stock,
      'quantity': quantity,
    };
  }
}
