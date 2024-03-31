import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/email_model.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

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

  Future<void> sendFinalEmail(String pdfname, pw.Document? doc) async {
    final List<EmailModel> emails = await getEmail().first;
    final List<String> toEmails = emails.map((e) => e.to!).toList();
    final List<String> ccEmails = emails.map((e) => e.cc!).toList();
    final List<String> subjectEmail = emails.map((e) => e.subject!).toList();
    final List<String> bodyEmail = emails.map((e) => e.body!).toList();

    final String subject = '${subjectEmail[0]} $pdfname';
    final String body = '${bodyEmail[0]} $pdfname';
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String pdfPath = '$dir/$pdfname.pdf';
    final File file = File(pdfPath);
    await file.writeAsBytes(await doc!.save());

    sendEmail(toEmails, ccEmails, [], subject, body, [pdfPath]);
  }

// get email
  Stream<List<EmailModel>> getEmail() => collectionReference.snapshots().map(
      (query) => query.docs.map((item) => EmailModel.fromJson(item)).toList());

  // send email

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

  Future<bool> updateBooking(List<List<dynamic>> inputData) async {
    try {
      // Initialize collection reference
      final CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("products");

      // Iterate through each entry in the input data
      for (final List<dynamic> entry in inputData) {
        final String productName =
            entry[1].toString(); // Assuming product name is at index 1
        final double quantityToSubtract =
            double.tryParse(entry[2].toString()) ??
                0.0; // Assuming quantity to subtract is at index 2

        bool success = false;
        int retryCount = 0;
        dynamic lastError;

        // Retry loop for optimistic locking
        while (!success && retryCount < 3) {
          // You can adjust the number of retries as needed
          try {
            // Fetch product document
            final QuerySnapshot querySnapshot = await collectionReference
                .where('name', isEqualTo: productName)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              final DocumentSnapshot doc = querySnapshot.docs.first;
              final int currentbooked = doc['booked'] as int;

              // Calculate new booked quantity after subtraction
              final int newbooked = currentbooked + quantityToSubtract.toInt();

              // Attempt to update booked
              await collectionReference
                  .doc(doc.id)
                  .update({'booked': newbooked});
              print('booked updated for $productName');
              success = true;
            } else {
              print('Product $productName not found');
              success =
                  true; // Mark success even if product not found (optional)
            }
          } catch (error) {
            print('Error updating booked for $productName: $error');
            lastError = error;
            retryCount++;
            await Future.delayed(Duration(seconds: 1)); // Delay before retrying
          }
        }

        if (!success) {
          print(
              'Failed to update booked for $productName after $retryCount attempts');
          if (lastError != null) {
            throw lastError; // Throw the last encountered error if all retries fail
          }
          return false;
        }
      }

      print('All booked updates completed successfully');
      return true;
    } catch (error) {
      print('Error updating booked: $error');
      return false;
    }
  }
}
