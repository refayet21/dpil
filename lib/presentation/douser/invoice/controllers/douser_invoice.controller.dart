import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DouserInvoiceController extends GetxController {
  RxList<String> attachments = <String>[].obs;
  int pdfCount = 0;
  Rx<Uint8List?> pdfBytes = Rx<Uint8List?>(null);

  Future<void> sendEmail(
      List<String> recipients, String subject, String body) async {
    if (attachments.isEmpty) {
      await generatePdf();
    }

    final Email email = Email(
      recipients: recipients,
      subject: subject,
      body: body,
      attachmentPaths: attachments,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      print('Error sending email: $error');
    }
  }

  Future<void> generatePdf() async {
    // Increment the PDF count for each generation
    pdfCount++;

    // Generate invoice number
    final String currentDate = DateTime.now().day.toString().padLeft(2, '0');
    final String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
    final String currentYear = DateTime.now().year.toString();
    final String invoiceNumber =
        'DPLC/$currentDate/$currentMonth/$currentYear/S-$pdfCount';

    // Create a new PDF document
    final pdf = pw.Document();

    // Add content to the PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Invoice Number: $invoiceNumber',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Recipient: refayet21@gmail.com\n'
              'Subject: subject\n'
              'Body: body',
            ),
          ],
        ),
      ),
    );

    final Uint8List bytes = await pdf.save();

    pdfBytes.value = bytes;

    final tempDir = await getTemporaryDirectory();
    final pdfFile = File('${tempDir.path}/example.pdf');
    await pdfFile.writeAsBytes(bytes);

    attachments.add(pdfFile.path);
  }
}
