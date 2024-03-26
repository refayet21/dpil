import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DouserInvoicepreviewController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
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

  // Future<bool> saveDeliveryOrder(DeliveryOrder deliveryOrder) async {
  //   try {
  //     await _firestore.collection('deliveryOrders').add(deliveryOrder.toMap());
  //     print('Delivery order added to Firestore');
  //     return true; // Return true if the operation is successful
  //   } catch (e) {
  //     print('Error adding delivery order to Firestore: $e');
  //     return false; // Return false if the operation fails
  //   }
  // }

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
}
