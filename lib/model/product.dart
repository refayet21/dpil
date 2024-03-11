import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? name;
  String? unit;
    String? totalunit;
  int? unitqty;
  int? rate;
  int? stock;
  int quantity;

  ProductModel({
    this.docId,
    this.name,
    this.unit,
     this.totalunit,
    this.unitqty,
    this.rate,
    this.stock,
    this.quantity = 1,
  });

  // Convert DocumentSnapshot to ProductModel object
  ProductModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        unit = data["unit"] as String?,
            totalunit = data["totalunit"] as String?,
        unitqty = data["unitqty"] as int?,
        rate = data["s_price"] as int?,
        stock = data["stock"] as int?,
        quantity = 1;

  // Convert ProductModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'unit': unit,
        'totalunit': totalunit,
      'unitqty': unitqty,
      's_price': rate,
      'stock': stock,
      'quantity': quantity,
    };
  }
}
