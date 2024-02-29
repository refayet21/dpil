import 'package:cloud_firestore/cloud_firestore.dart';

class VendorModel {
  String? docId;
  String? name;
  String? address;
  String? mobile;

  VendorModel({
    this.docId,
    this.name,
    this.address,
    this.mobile,
  });

  VendorModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    name = data["name"] as String?;
    address = data["address"] as String?;
    mobile = data["mobile"] as String?;
  }

  // Convert VendorModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'name': name,
      'address': address,
      'mobile': mobile,
    };
  }
}
