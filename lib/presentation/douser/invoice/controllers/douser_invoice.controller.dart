import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';
import 'package:dpil/presentation/douser/invoicepreview/douser_invoicepreview.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dpil/model/vendor.dart';

class DouserInvoiceController extends GetxController {
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  AdminAddvendorController vendorAddController =
      Get.put(AdminAddvendorController());
  late CollectionReference collectionReference;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> logout() {
    return _auth.signOut();
  }

  Stream<List<VendorModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => VendorModel.fromJson(item)).toList());

  // Dropdown options
  List<String> dropdownOptions = ['Product 1', 'Product 2', 'Product 3'];

  // Getter method for dropdown options
  List<String> getDropdownOptions() {
    return dropdownOptions;
  }

  Future<void> generateInvoicePdf(String vendorName, String date,
      String productName, double productPrice, int productQuantity) async {
    final doc = pw.Document();
    try {
      // Load fonts
      final fontData = await rootBundle.load("assets/fonts/robotoregular.ttf");
      final ttf = pw.Font.ttf(fontData);

      // Invoice Header
      final header = pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Column(
          children: [
            pw.Text(
              'Invoice',
              style: pw.TextStyle(
                fontSize: 20.0,
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
            pw.SizedBox(height: 10.0),
            pw.Text(
              '$vendorName',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
            pw.Text(
              'Date: $date',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
          ],
        ),
      );

      // Invoice Body
      final body = pw.Container(
        child: pw.Table.fromTextArray(
          context: null,
          cellAlignment: pw.Alignment.centerLeft,
          headerAlignment: pw.Alignment.centerLeft,
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            font: ttf,
          ),
          cellStyle: pw.TextStyle(),
          headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
          headers: <String>['Product Name', 'Price', 'Quantity'],
          data: <List<String>>[
            [productName, productPrice.toString(), productQuantity.toString()],
          ],
        ),
      );

      // Calculate total price
      final totalPrice = productPrice * productQuantity;

      // Invoice Footer
      final footer = pw.Container(
        alignment: pw.Alignment.centerRight,
        child: pw.Column(
          children: [
            pw.Text(
              'Total Price: $totalPrice',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                font: ttf,
              ),
            ),
          ],
        ),
      );

      // Add pages to the PDF document
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (pw.Context context) {
            return pw.Expanded(
              child: pw.Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    header,
                    body,
                    footer,
                  ],
                ),
              ),
            );
          },
        ),
      );

      Get.to(() => DouserInvoicepreviewScreen(doc: doc));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();

    vendors = vendorAddController.vendors;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
