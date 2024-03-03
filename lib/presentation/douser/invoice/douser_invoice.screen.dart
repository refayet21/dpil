import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'controllers/douser_invoice.controller.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  DouserInvoiceScreen({Key? key}) : super(key: key);
  DouserInvoiceController homeController = Get.put(DouserInvoiceController());
  TextEditingController dateController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  VendorModel? selectedVendor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Sender App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              onPressed: controller.generatePdf,
              child: Text('Generate PDF'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                return controller.pdfBytes.value != null
                    ? PdfPreview(
                        build: (PdfPageFormat format) =>
                            controller.pdfBytes.value!,
                        initialPageFormat: PdfPageFormat.a4,
                        allowPrinting: false,
                        onPrinted: (_) {},
                      )
                    : Container();
              }),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller
                    .sendEmail(['refayet21@gmail.com'], 'subject', 'body');
              },
              child: Text('Send Email with PDF Attachment'),
            ),
          ],
        ),
      ),
    );
  }
}
