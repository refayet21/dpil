import 'package:cloud_firestore/cloud_firestore.dart';

class EmailModel {
  String? docId;
  String? to;
  String? cc;
  String? subject;
  String? body;

  EmailModel({
    this.docId,
    this.to,
    this.cc,
    this.subject,
    this.body,
  });

  EmailModel.fromJson(DocumentSnapshot data) {
    docId = data.id;
    to = data["to"] as String?;
    cc = data["cc"] as String?;
    subject = data["subject"] as String?;
    body = data["body"] as String?;
  }

  // Convert VendorModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'to': to,
      'cc': cc,
      'subject': subject,
      'body': body,
    };
  }
}
