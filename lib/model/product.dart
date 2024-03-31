import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? docId;
  String? name;
  String? category;
  int? checkin;
  int? checkout;
  int? booked;
  int quantity;

  ProductModel({
    this.docId,
    this.name,
    this.category,
    this.checkin,
    this.checkout,
    this.booked,
    this.quantity = 1,
  });

  // Convert DocumentSnapshot to ProductModel object
  ProductModel.fromJson(DocumentSnapshot data)
      : docId = data.id,
        name = data["name"] as String?,
        category = data["category"] as String?,
        checkin = data["checkin"] as int?,
        checkout = data["checkout"] as int?,
        booked = data["booked"] as int?,
        quantity = 1;

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'category': category,
      'checkin': checkin,
      'checkout': checkout,
      'booked': booked,
      'quantity': quantity,
    };
  }
}
