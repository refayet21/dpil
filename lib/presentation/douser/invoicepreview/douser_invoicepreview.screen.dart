import 'dart:io';

import 'package:flutter/material.dart';
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

  DouserInvoicepreviewScreen({Key? key, this.doc, this.pdfname})
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
              child: PdfPreview(
                build: (format) => doc!.save(),
                allowSharing: false,
                allowPrinting: false,
                dynamicLayout: false,
                useActions: false,
                initialPageFormat: PdfPageFormat.a4,
                pdfFileName: "$pdfname.pdf",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          // Fetch your recipients, subject, and body as needed
          List<String> to = ['mosarof.del@gmail.com', 'sanzid.dpil@gmail.com'];
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
          controller.sendEmail(to, cc, bcc, subject, body, [pdfPath]);
        },
        child: Text('Send Email'),
      ),
    );
  }
}
