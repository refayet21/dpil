import 'package:cloud_firestore/cloud_firestore.dart';

class StockUserModel {
  String? docId;
  String? name;
  String? address;
  String? mobile;
  String? email;
  String? password;

  StockUserModel({
    this.docId,
    this.name,
    this.address,
    this.mobile,
    this.email,
    this.password,
  });

  StockUserModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"] as String?;
    address = data["address"] as String?;
    mobile = data["mobile"] as String?;
    email = data["email"] as String?;
    password = data["password"] as String?;
  }

  // Convert VendorModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'address': address,
      'mobile': mobile,
      'email': email,
      'password': password,
    };
  }
}
