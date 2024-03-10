// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';
import 'package:dpil/presentation/douser/invoicepreview/douser_invoicepreview.screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  Future<void> generateInvoicePdf( 
  String dono,
  String marketingperson,
  String dotype,
  String supplier,
  String supplieraddress,
  String customername,
  String customeraddress,
  String mobile,     
String Roll,
String Meter,

       
  // String vendorName,
  // String date,
  // String productName,
  // double productPrice, 
  // int productQuantity
  ) async {
    final doc = pw.Document();
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
    style: pw.TextStyle( fontSize: 20, ),
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
                          pw.Text('Date: 27.02.2024')
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
          pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
            pw.Text("Do : $dono"),
            pw.Text("Marketing Person : $marketingperson"),
            pw.Text("DO Type : $dotype"),
            pw.Text("Suppliar : $supplier"),
            pw.Text("Suppliar Address : $supplieraddress"),
            pw.Text("Customer Name : $customername"),
            pw.Text("Customer Address : $customeraddress"),
            pw.Text("Mobile : $mobile"),
            ]),   
 

// Rest of the content...
pw.SizedBox(height: 10),
pw.Table.fromTextArray(
  headers: tableHeaders,
  data: [
    [
      '1',
      '3mm basic Bubble',
      '40',
      '90',
      '3600',
      '13.5',
      '48600',
      ''
    ],
    ['Total', '', '', '', '48600', '', '48600', ''],
  ],
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


              pw.SizedBox(height: 10),
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
                'Delivery Date: 17-02-2023',
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
