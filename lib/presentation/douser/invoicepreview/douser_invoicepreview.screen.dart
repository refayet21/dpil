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
  // final List<List<dynamic>>? stockdata;

  DouserInvoicepreviewScreen({
    Key? key,
    this.doc,
    this.pdfname,
    this.deliveryOrder,
    // this.stockdata
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
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          bool updateSuccessfully = await updateStock(deliveryOrder!.data);
          if (updateSuccessfully) {
            bool savedSuccessfully =
                await controller.saveDeliveryOrder(deliveryOrder!);
            if (savedSuccessfully) {
              sendEmail();
            }
          }
        },
        child: Text(
          'Send Email',
          style: TextStyle(fontSize: 14.sp),
        ),
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

  // Future<bool> updateStock() async {
  //   // final List<List<dynamic>> stocdata = stockdata!;
  //   final List<List<dynamic>> inoutdata = deliveryOrder!.data;
  //   // print('stocdata $stocdata');
  //   print('inoutdata $inoutdata');
  //   final Map<String, double> resultMapping = {};

  //   for (final List<dynamic> inoutEntry in inoutdata) {
  //     final String inoutDescription = inoutEntry[1].toString();
  //     final double valueToSubtract =
  //         double.tryParse(inoutEntry[2].toString()) ?? 0.0;

  //     for (final List<dynamic> stockEntry in stocdata) {
  //       final String stockDescription = stockEntry[1].toString();

  //       if (inoutDescription == stockDescription) {
  //         final int stockQuantity = stockEntry[2] as int;
  //         final double result = stockQuantity.toDouble() - valueToSubtract;

  //         resultMapping[inoutDescription] = result;

  //         await updateStockValue(inoutDescription, result.toInt());
  //         break;
  //       }
  //     }
  //   }

  //   resultMapping.forEach((key, value) {
  //     print('Result for $key: $value');
  //   });

  //   return true;
  // }

  // Future<void> updateStockValue(String productName, ) async {
  //   collectionReference = firebaseFirestore.collection("products");

  //   try {
  //     final QuerySnapshot querySnapshot =
  //         await collectionReference.where('name', isEqualTo: productName).get();

  //     querySnapshot.docs.forEach((doc) {
  //       collectionReference.doc(doc.id).update({
  //         'stock': newStockValue,
  //       });
  //     });
  //   } catch (error) {
  //     print('Error updating stock value: $error');
  //   }
  // }
  Future<bool> updateStock(List<List<dynamic>> inputData) async {
    // Initialize collectionReference
    final CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection("products");

    // Iterate through each entry in the input data
    for (final List<dynamic> entry in inputData) {
      final String productName =
          entry[1].toString(); // Assuming product name is at index 1
      final double quantityToSubtract = double.tryParse(entry[2].toString()) ??
          0.0; // Assuming quantity to subtract is at index 2

      print(
          'Input Data: Product Name: $productName, Quantity to Subtract: $quantityToSubtract');

      try {
        // Fetch product data from Firebase
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("products")
            .where('name', isEqualTo: productName)
            .get();

        // Iterate through each document (product) fetched
        querySnapshot.docs.forEach((doc) async {
          // Get the current stock quantity
          final int currentStock = doc['stock'] as int;
          print('Current Stock for $productName: $currentStock');

          // Calculate new stock quantity after subtraction
          final int newStock = currentStock - quantityToSubtract.toInt();
          print('New Stock for $productName: $newStock');

          // Update the stock value in Firebase using initialized collectionReference
          await collectionReference.doc(doc.id).update({
            'stock': newStock,
          });
          print('Stock updated for $productName');
        });
      } catch (error) {
        print('Error updating stock for product $productName: $error');
      }
    }

    return true; // Return true after all updates are done
  }
}
