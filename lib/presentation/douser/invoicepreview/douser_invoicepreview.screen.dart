import 'dart:io';

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
  DouserInvoicepreviewController controller =
      Get.put(DouserInvoicepreviewController());
  final pw.Document? doc;
  String? pdfname;
  DeliveryOrder? deliveryOrder;

  DouserInvoicepreviewScreen(
      {Key? key, this.doc, this.pdfname, this.deliveryOrder})
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
          List<EmailModel> emails = await controller.getEmail().first;

          // Extract email addresses from the email data
          List<String> toEmails = emails.map((e) => e.to!).toList();
          List<String> ccEmails = emails.map((e) => e.cc!).toList();
          List<String> subjectEmail = emails.map((e) => e.subject!).toList();
          List<String> bodyEmail = emails.map((e) => e.body!).toList();
          // print('to email ${ccEmails[0]}');

          List<String> to = toEmails;
          // List<String> to = [
          //   'refayet94@gmail.com',
          // ];
          List<String> cc = ccEmails;
          List<String> bcc = [];

          String subject = '${subjectEmail[0]} $pdfname';
          String body = '${bodyEmail[0]} $pdfname';

          // Get the directory path for documents
          String dir = (await getApplicationDocumentsDirectory()).path;

          // Define the path for the PDF file
          String pdfPath = '$dir/$pdfname.pdf';

          // Write the PDF document to a file
          final File file = File(pdfPath);
          await file.writeAsBytes(await doc!.save());

          // Call the sendEmail method from your controller
// Call the saveDeliveryOrder method to save the delivery order to Firestore
          bool savedSuccessfully =
              await controller.saveDeliveryOrder(deliveryOrder!);

          if (savedSuccessfully) {
            // Delivery order saved successfully, now send the email
            controller.sendEmail(to, cc, bcc, subject, body, [pdfPath]);
          } else {
            // Handle the case where saving the delivery order failed
            // print('Failed to save delivery order');
          }
        },
        child: Text(
          'Send Email',
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }
}
