import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  DouserInvoicepreviewController controller =
      Get.put(DouserInvoicepreviewController());
  final pw.Document? doc;
  String? pdfname;
  DeliveryOrder? deliveryOrder;
  final List<List<dynamic>>? stockdata;
  DouserInvoicepreviewScreen(
      {Key? key, this.doc, this.pdfname, this.deliveryOrder, this.stockdata})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
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
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          Future<void> sendEmail() async {
            List<EmailModel> emails = await controller.getEmail().first;
            List<String> toEmails = emails.map((e) => e.to!).toList();
            List<String> ccEmails = emails.map((e) => e.cc!).toList();
            List<String> subjectEmail = emails.map((e) => e.subject!).toList();
            List<String> bodyEmail = emails.map((e) => e.body!).toList();
            // // print('to email ${ccEmails[0]}');

            // // List<String> to = toEmails;
            // // List<String> cc = ccEmails;
            List<String> bcc = [];

            String subject = '${subjectEmail[0]} $pdfname';
            String body = '${bodyEmail[0]} $pdfname';
            String dir = (await getApplicationDocumentsDirectory()).path;
            String pdfPath = '$dir/$pdfname.pdf';
            final File file = File(pdfPath);
            await file.writeAsBytes(await doc!.save());

            controller
                .sendEmail(toEmails, ccEmails, bcc, subject, body, [pdfPath]);
          }

          // updateStock();
          bool updateSuccessfully = await updateStock();
          if (updateSuccessfully) {
            bool savedSuccessfully =
                await controller.saveDeliveryOrder(deliveryOrder!);
            if (savedSuccessfully) {
              sendEmail();
            }
          }

          // Iterate over inoutdata
        },
        child: Text(
          'Send Email',
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }

  Future<bool> updateStock() async {
    List<List<dynamic>> stocdata = stockdata!;
    List<List<dynamic>> inoutdata = deliveryOrder!.data;
    print('stocdata $stocdata');
    print('inoutdata $inoutdata');
    Map<String, double> resultMapping = {};

    for (List<dynamic> inoutEntry in inoutdata) {
      // Extract description and value from inoutEntry
      String inoutDescription = inoutEntry[1].toString();
      double valueToSubtract = double.tryParse(inoutEntry[2].toString()) ?? 0.0;

      // Search for a matching description in stocdata
      for (List<dynamic> stockEntry in stocdata) {
        String stockDescription = stockEntry[1].toString();

        // If descriptions match, update the stock value
        if (inoutDescription == stockDescription) {
          // Extract the current stock quantity
          int stockQuantity = stockEntry[2] as int;

          // Subtract stockQuantity from the value to subtract
          double result = stockQuantity.toDouble() - valueToSubtract;

          // Store the result in the map
          resultMapping[inoutDescription] = result;

          // Update the stock value in the database
          await updateStockValue(inoutDescription, result.toInt());

          // Break the inner loop as we found the match
          break;
        }
      }
    }

    // Print the results
    resultMapping.forEach((key, value) {
      print('Result for $key: $value');
    });

    return true;
  }

  Future<void> updateStockValue(String productName, int newStockValue) async {
    collectionReference = firebaseFirestore.collection("products");

    try {
      // Query the stock collection for documents with the given product name
      QuerySnapshot querySnapshot =
          await collectionReference.where('name', isEqualTo: productName).get();

      // Update the stock value for all matching documents
      querySnapshot.docs.forEach((doc) {
        collectionReference.doc(doc.id).update({
          'stock': newStockValue,
        });
      });
    } catch (error) {
      print('Error updating stock value: $error');
    }
  }
}
