import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/email_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'controllers/allinvoicepreview.controller.dart';
import 'package:pdf/widgets.dart' as pw;

class AllinvoicepreviewScreen extends GetView<AllinvoicepreviewController> {
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final AllinvoicepreviewController controller =
      Get.put(AllinvoicepreviewController());
  final pw.Document? doc;
  final String? pdfname;
  final DeliveryOrder? deliveryOrder;

  AllinvoicepreviewScreen({
    Key? key,
    this.doc,
    this.pdfname,
    this.deliveryOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   onPressed: () => Get.off(),
          //   icon: Icon(Icons.arrow_back_outlined),
          // ),
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
                    allowSharing: true,
                    allowPrinting: false,
                    dynamicLayout: false,
                    useActions: true,
                    canChangeOrientation: false,
                    canChangePageFormat: false,
                    canDebug: true,
                    shouldRepaint: true,
                    enableScrollToPage: true,
                    initialPageFormat: PdfPageFormat.a4,
                    pdfFileName: "$pdfname.pdf",
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            sendEmail();
          },
          child: Icon(Icons.email),
        ));
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
}
