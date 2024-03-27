import 'dart:io';

import 'package:dpil/model/do_model.dart';
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
          // Fetch your recipients, subject, and body as needed
          List<String> to = ['mosarof.del@gmail.com', 'sanzid.dpil@gmail.com'];
          // List<String> to = [
          //   'refayet94@gmail.com',
          // ];
          List<String> cc = [];
          List<String> bcc = [];

          String subject = '$pdfname';
          String body = 'Delivery Order Send by $pdfname';

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
