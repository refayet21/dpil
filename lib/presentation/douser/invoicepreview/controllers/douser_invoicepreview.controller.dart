import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/email_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DouserInvoicepreviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference collectionReference;
  final box = GetStorage();
  RxList<EmailModel> emailModel = RxList<EmailModel>([]);
  RxList<EmailModel> email = RxList<EmailModel>([]);

  @override
  void onInit() {
    super.onInit();
    collectionReference = _firestore.collection("email");
    emailModel.bindStream(getEmail());
    email = emailModel;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> sendEmail(List<String> to, List<String> cc, List<String> bcc,
      String subject, String body, List<String>? attachmentPaths) async {
    final Email email = Email(
        recipients: to,
        cc: cc,
        bcc: bcc,
        subject: subject,
        body: body,
        attachmentPaths: attachmentPaths);

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error sending email: $error');
    }
  }

  Future<bool> saveDeliveryOrder(DeliveryOrder? deliveryOrder) async {
    try {
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(box.read('employeeId'))
          .collection("deliveryOrders")
          .doc(deliveryOrder!.doNo)
          .set(deliveryOrder.toMap());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  // Stream<List<EmailModel>> getEmail() => collectionReference.snapshots().map(
  //     (query) => query.docs.map((item) => EmailModel.fromJson(item)).toList());

  Stream<List<EmailModel>> getEmail() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => EmailModel.fromJson(item)).toList());
}
