import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/email_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import 'controllers/douser_invoicepreview.controller.dart';

class DouserInvoicepreviewScreen
    extends GetView<DouserInvoicepreviewController> {
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final DouserInvoicepreviewController controller =
      Get.put(DouserInvoicepreviewController());
  final pw.Document? doc;
  final String? pdfname;
  final DeliveryOrder? deliveryOrder;

  DouserInvoicepreviewScreen({
    Key? key,
    this.doc,
    this.pdfname,
    this.deliveryOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAllNamed(Routes.DOUSER_INVOICE),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Delivery Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(20.r),
                minScale: 0.5,
                maxScale: 3.5,
                child: PdfPreview(
                  build: (format) => doc!.save(),
                  allowSharing: false,
                  allowPrinting: false,
                  dynamicLayout: true,
                  useActions: false,
                  initialPageFormat: PdfPageFormat.a4,
                  pdfFileName: "$pdfname.pdf",
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<bool>(
        future: updateStock(deliveryOrder!.data),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FloatingActionButton(
              onPressed: null,
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.error),
              );
            } else {
              return FloatingActionButton(
                onPressed: () async {
                  bool savedSuccessfully =
                      await controller.saveDeliveryOrder(deliveryOrder!);
                  if (savedSuccessfully) {
                    sendEmail();
                  }
                },
                child: Icon(Icons.email),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> sendEmail() async {
    final List<EmailModel> emails = await controller.getEmail().first;
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

    controller.sendEmail(toEmails, ccEmails, [], subject, body, [pdfPath]);
  }

  Future<bool> updateStock(List<List<dynamic>> inputData) async {
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
              final int currentStock = doc['stock'] as int;

              // Calculate new stock quantity after subtraction
              final int newStock = currentStock - quantityToSubtract.toInt();

              // Attempt to update stock
              await collectionReference.doc(doc.id).update({'stock': newStock});
              print('Stock updated for $productName');
              success = true;
            } else {
              print('Product $productName not found');
              success =
                  true; // Mark success even if product not found (optional)
            }
          } catch (error) {
            print('Error updating stock for $productName: $error');
            lastError = error;
            retryCount++;
            await Future.delayed(Duration(seconds: 1)); // Delay before retrying
          }
        }

        if (!success) {
          print(
              'Failed to update stock for $productName after $retryCount attempts');
          if (lastError != null) {
            throw lastError; // Throw the last encountered error if all retries fail
          }
          return false;
        }
      }

      print('All stock updates completed successfully');
      return true;
    } catch (error) {
      print('Error updating stock: $error');
      return false;
    }
  }
}
