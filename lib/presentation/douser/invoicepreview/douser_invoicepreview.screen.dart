// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/do_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
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
      floatingActionButton: ElevatedButton(
        // style: ElevatedButton.styleFrom(
        //   primary: Colors.amber,
        // ),
        onPressed: () async {
          // bool bookedSuccessfully =
          //     await controller.updateBooking(deliveryOrder!.data);

          // if (bookedSuccessfully) {
          //   bool savedSuccessfully =
          //       await controller.saveDeliveryOrder(deliveryOrder!);
          //   if (savedSuccessfully) {
          //     controller.sendFinalEmail(pdfname!, doc);
          //   }
          // }
        },
        // child: Obx(
        //   () => controller.isSendingEmail.value
        //       ? CircularProgressIndicator(
        //           color: Colors.white,
        //         )
        child: Text('Send Email'),
      ),
    );
    //   );
  }
}
