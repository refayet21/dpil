// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/product.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';
import 'package:dpil/presentation/douser/invoicepreview/douser_invoicepreview.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DouserProductcartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<ProductModel> cartItems = RxList<ProductModel>([]);
  AdminAddvendorController vendorAddController =
      Get.put(AdminAddvendorController());
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  late CollectionReference collectionReference;
  RxList<ProductModel> productModel = RxList<ProductModel>([]);
  var quantity = 0.obs;

  Stream<List<ProductModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    print('oninit called');
    collectionReference = firebaseFirestore.collection("products");
    productModel.bindStream(getAllVendors());
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

  void addToCart(ProductModel product) {
    bool alreadyInCart = cartItems.any((item) => item.docId == product.docId);

    if (!alreadyInCart) {
      cartItems.add(product);
    } else {
      print('Product is already in the cart');
    }
  }

  bool isProductInCart(ProductModel product) {
    return cartItems.any((item) => item.docId == product.docId);
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
  }

  void increaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1) {
      cartItems[index].quantity++;
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.remove(product);
    }
  }

  void updateQuantity(ProductModel product, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1) {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.remove(product);
      }
    }
  }

  selectdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      // print(formattedDate);

      // dateinput.text = formattedDate;
      return formattedDate;
    }
  }

  // add purchase product

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> addPurchaseData({
  //   String? vendorDocId,
  //   required String date,
  //   required List<Map<String, dynamic>> cartItems,
  // }) async {
  //   try {
  //     CollectionReference purchasesCollection =
  //         _firestore.collection('purchases');

  //     // Add a new document with a generated ID
  //     await purchasesCollection.add({
  //       'vendorDocId': vendorDocId,
  //       'date': date,
  //       'cartItems': cartItems,
  //     });

  //     print('Purchase data added to Firestore');
  //   } catch (e) {
  //     print('Error adding purchase data: $e');
  //   }
  // }

  // Future<void> addPurchaseData({
  //   String? vendorDocId,
  //   required String date,
  //   required List<Map<String, dynamic>> cartItems,
  //   String? purchaseInfo, // Add this parameter
  // }) async {
  //   try {
  //     CollectionReference purchasesCollection =
  //         _firestore.collection('purchases');

  //     // Add a new document with a generated ID
  //     await purchasesCollection.add({
  //       'vendorDocId': vendorDocId,
  //       'date': date,
  //       'cartItems': cartItems,
  //       'purchaseInfo': purchaseInfo, // Add purchaseInfo to the document
  //     });

  //     print('Purchase data added to Firestore');
  //   } catch (e) {
  //     print('Error adding purchase data: $e');
  //   }
  // }

  Future<void> addPurchaseData({
    String? vendorDocId,
    required String date,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    try {
      CollectionReference purchasesCollection =
          _firestore.collection('purchases');

      // Add a new document with a generated ID
      await purchasesCollection.add({
        'vendorDocId': vendorDocId,
        'date': date,
        'cartItems': cartItems,
      });

      print('Purchase data added to Firestore');
    } catch (e) {
      print('Error adding purchase data: $e');
    }
  }

  String generateddate = DateFormat('dd.MM.yyyy').format(DateTime.now());

  Future<void> generateInvoicePdf(
      String marketingperson,
      String vendorName,
      String vendorAddress,
      String contactPerson,
      String vendorMobile,
      String? Roll,
      String? Meter,
      List<List<dynamic>> data,
      double? totalAmount,
      String? deliveryDate) async {
    final doc = pw.Document();

    final String currentDate = DateTime.now().day.toString().padLeft(2, '0');
    final String currentMonth = DateTime.now().month.toString().padLeft(2, '0');
    final String currentYear = DateTime.now().year.toString();
    final String doNo =
        'DPIL-$currentDate-$currentMonth-$currentYear-S-pdfCount';
    try {
      // Load fonts
      final fontData = await rootBundle.load("assets/fonts/robotoregular.ttf");
      final ttf = pw.Font.ttf(fontData);

      final header = (await rootBundle.load('assets/images/headerpad.png'))
          .buffer
          .asUint8List();
      final footer = (await rootBundle.load('assets/images/footerpad.png'))
          .buffer
          .asUint8List();

      final tableHeaders = [
        'S.L',
        'Description',
        '$Roll',
        '$Meter',
        'Total $Meter',
        'Rate(Tk)',
        'Amount(Tk)',
        'Remarks',
      ];

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Container(
                margin: pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        // crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
// uncoment it
                          pw.Image(
                            pw.MemoryImage(header),
                            // height: 72,
                            // width: 72,
                          ),
                          pw.Text(
                            'Delivery Order',
                            style: pw.TextStyle(
                              fontSize: 20.sp,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw
                                  .TextDecoration.underline, // Adding underline
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              pw.Container(
                margin: pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                              'Date: $currentDate-$currentMonth-$currentYear')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Do : $doNo"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Marketing Person : $marketingperson"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("DO Type : Non Package"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Suppliar : Dynamic Polymer Industries Ltd."),
                    pw.SizedBox(height: 1.h),
                    pw.Text(
                        "Suppliar Address : West Dugri, Vawal Mirzapur, Gazipur"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Customer Name : $vendorName"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Customer Address : $vendorAddress"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Contact Person : $contactPerson"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Contact Person Mobile : $vendorMobile"),
                    pw.SizedBox(height: 1.h),
                  ]),

// Rest of the content...
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: data,
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                  fontSize: 9.0,
                  fontWeight: pw.FontWeight.bold,
                ),
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center,
                  4: pw.Alignment.center,
                  5: pw.Alignment.center,
                  6: pw.Alignment.center,
                  7: pw.Alignment.center,
                },
              ),

              // pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'Total : $totalAmount',
                    style: pw.TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'IN WORDS BDT: FourtyEight Thousand Six Hundred Taka Only',
                    style: pw.TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Delivery Date: $deliveryDate',
                style: pw.TextStyle(
                  fontSize: 11.0,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Note: In case of failure in taking delivery within due time, beneficiary may cancel the D.O offered to the customer.',
                style: pw.TextStyle(
                  fontSize: 11.0,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Container(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Authorized Signature',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          footer: (context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 20.0),

              // uncoment it
              child: pw.Image(
                pw.MemoryImage(footer),
                // height: 72,
                // width: 72,
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
}
