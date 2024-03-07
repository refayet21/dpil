// ignore_for_file: deprecated_member_use

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

      final header = (await rootBundle.load('assets/images/headerpad.png'))
          .buffer
          .asUint8List();
      final footer = (await rootBundle.load('assets/images/footerpad.png'))
          .buffer
          .asUint8List();

      final tableHeaders = [
        'S.L',
        'Description',
        'Roll',
        'Meter',
        'Total Meter',
        'Rate(Tk)',
        'Amount(Tk)',
        'Remarks',
      ];

      final tableData = [
        [
          '1'
              'Coffee',
          '7',
          '\$ 5',
          '1 %',
          '\$ 35',
          'Good'
        ],
        [
          '1'
              'Coffee',
          '7',
          '\$ 5',
          '1 %',
          '\$ 35',
          'Good'
        ],
        [
          '1'
              'Coffee',
          '7',
          '\$ 5',
          '1 %',
          '\$ 35',
          'Good'
        ],
        [
          '1'
              'Coffee',
          '7',
          '\$ 5',
          '1 %',
          '\$ 35',
          'Good'
        ],
        [
          '1'
              'Coffee',
          '7',
          '\$ 5',
          '1 %',
          '\$ 35',
          'Good'
        ],
      ];

      // doc.addPage(
      //   pw.MultiPage(
      //     build: (context) {
      //       return [
      //         pw.Row(
      //           children: [
      //             pw.Image(
      //               pw.MemoryImage(iconImage),
      //               height: 72,
      //               width: 72,
      //             ),
      //             pw.SizedBox(width: 1 * PdfPageFormat.mm),
      //             pw.Column(
      //               mainAxisSize: pw.MainAxisSize.min,
      //               crossAxisAlignment: pw.CrossAxisAlignment.start,
      //               children: [
      //                 pw.Text(
      //                   'Dynamic Polymer Industries Ltd.',
      //                   style: pw.TextStyle(
      //                     fontSize: 17.0,
      //                     fontWeight: pw.FontWeight.bold,
      //                     // color: color,
      //                     // font: fontFamily,
      //                   ),
      //                 ),
      //                 pw.Text(
      //                   'Eco-Friendly Solution',
      //                   style: pw.TextStyle(
      //                     fontSize: 15.0,
      //                     // color: color,
      //                     // font: fontFamily,
      //                   ),
      //                 ),
      //                 pw.Text(
      //                   'Exceptional Quality',
      //                   style: pw.TextStyle(
      //                     fontSize: 15.0,
      //                     // color: color,
      //                     // font: fontFamily,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //             pw.Spacer(),

      //           ],
      //         ),
      //         pw.SizedBox(height: 1 * PdfPageFormat.mm),
      //         pw.Divider(),
      //         pw.SizedBox(height: 1 * PdfPageFormat.mm),
      //         pw.Column(
      //           mainAxisSize: pw.MainAxisSize.min,
      //           crossAxisAlignment: pw.CrossAxisAlignment.start,
      //           children: [
      //             pw.Text(
      //               'Delivery Order',
      //               style: pw.TextStyle(
      //                 fontSize: 15.5,
      //                 fontWeight: pw.FontWeight.bold,
      //                 // color: color,
      //                 // font: fontFamily,
      //               ),
      //             ),
      //             pw.Text(
      //               'Date : ${DateTime.now().toString()}',
      //               style: pw.TextStyle(
      //                 fontSize: 14.0,
      //                 // color: color,
      //                 // font: fontFamily,
      //               ),
      //             ),
      //           ],
      //         ),

      //         pw.SizedBox(height: 5 * PdfPageFormat.mm),

      //         ///
      //         /// PDF Table Create
      //         ///
      //         pw.Table.fromTextArray(
      //           headers: tableHeaders,
      //           data: tableData,
      //           border: null,
      //           headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      //           headerDecoration:
      //               const pw.BoxDecoration(color: PdfColors.grey300),
      //           cellHeight: 30.0,
      //           cellAlignments: {
      //             0: pw.Alignment.centerLeft,
      //             1: pw.Alignment.centerRight,
      //             2: pw.Alignment.centerRight,
      //             3: pw.Alignment.centerRight,
      //             4: pw.Alignment.centerRight,
      //           },
      //         ),
      //         pw.Divider(),
      //         pw.Container(
      //           alignment: pw.Alignment.centerRight,
      //           child: pw.Row(
      //             children: [
      //               pw.Spacer(flex: 6),
      //               pw.Expanded(
      //                 flex: 4,
      //                 child: pw.Column(
      //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                   children: [
      //                     pw.Row(
      //                       children: [
      //                         pw.Expanded(
      //                           child: pw.Text(
      //                             'Net total',
      //                             style: pw.TextStyle(
      //                               fontWeight: pw.FontWeight.bold,
      //                               // color: color,
      //                               // font: fontFamily,
      //                             ),
      //                           ),
      //                         ),
      //                         pw.Text(
      //                           '\$ 464',
      //                           style: pw.TextStyle(
      //                             fontWeight: pw.FontWeight.bold,
      //                             // color: color,
      //                             // font: fontFamily,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     pw.Row(
      //                       children: [
      //                         pw.Expanded(
      //                           child: pw.Text(
      //                             'Vat 19.5 %',
      //                             style: pw.TextStyle(
      //                               fontWeight: pw.FontWeight.bold,
      //                               // color: color,
      //                               // font: fontFamily,
      //                             ),
      //                           ),
      //                         ),
      //                         pw.Text(
      //                           '\$ 90.48',
      //                           style: pw.TextStyle(
      //                             fontWeight: pw.FontWeight.bold,
      //                             // color: color,
      //                             // font: fontFamily,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     pw.Divider(),
      //                     pw.Row(
      //                       children: [
      //                         pw.Expanded(
      //                           child: pw.Text(
      //                             'Total amount due',
      //                             style: pw.TextStyle(
      //                               fontSize: 14.0,
      //                               fontWeight: pw.FontWeight.bold,
      //                               // color: color,
      //                               // font: fontFamily,
      //                             ),
      //                           ),
      //                         ),
      //                         pw.Text(
      //                           '\$ 554.48',
      //                           style: pw.TextStyle(
      //                             fontWeight: pw.FontWeight.bold,
      //                             // color: color,
      //                             // font: fontFamily,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     pw.SizedBox(height: 2 * PdfPageFormat.mm),
      //                     pw.Container(height: 1, color: PdfColors.grey400),
      //                     pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
      //                     pw.Container(height: 1, color: PdfColors.grey400),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ];
      //     },
      //     footer: (context) {
      //       return pw.Column(
      //         mainAxisSize: pw.MainAxisSize.min,
      //         children: [
      //           pw.Divider(),
      //           pw.SizedBox(height: 2 * PdfPageFormat.mm),
      //           pw.Text(
      //             'Flutter Approach',
      //             style: pw.TextStyle(
      //               fontWeight: pw.FontWeight.bold,
      //               // color: color,
      //               // font: fontFamily
      //             ),
      //           ),
      //           pw.SizedBox(height: 1 * PdfPageFormat.mm),
      //           pw.Row(
      //             mainAxisAlignment: pw.MainAxisAlignment.center,
      //             children: [
      //               pw.Text(
      //                 'Address: ',
      //                 style: pw.TextStyle(
      //                   fontWeight: pw.FontWeight.bold,
      //                   // color: color,
      //                   // font: fontFamily
      //                 ),
      //               ),
      //               pw.Text(
      //                 'Merul Badda, Anandanagor, Dhaka 1212',
      //                 // style: pw.TextStyle(color: color, font: fontFamily),
      //               ),
      //             ],
      //           ),
      //           pw.SizedBox(height: 1 * PdfPageFormat.mm),
      //           pw.Row(
      //             mainAxisAlignment: pw.MainAxisAlignment.center,
      //             children: [
      //               pw.Text(
      //                 'Email: ',
      //                 // style: pw.TextStyle(
      //                 //     fontWeight: pw.FontWeight.bold,
      //                 //     color: color,
      //                 //     font: fontFamily),
      //               ),
      //               pw.Text(
      //                 'flutterapproach@gmail.com',
      //                 // style:
      //                 //     pw.TextStyle(color: color, font: pw.Font.courier()),
      //               ),
      //             ],
      //           ),
      //         ],
      //       );
      //     },
      //   ),
      // );

      // doc.addPage(
      //   pw.MultiPage(
      //     build: (context) {
      //       return [
      //         pw.Container(
      //           margin: pw.EdgeInsets.only(bottom: 10),
      //           child: pw.Row(
      //             children: [
      //               pw.Expanded(
      //                 flex: 2,
      //                 child: pw.Column(
      //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                   children: [
      //                     pw.Text(
      //                       'Dynamic Polymer Industries Ltd.',
      //                       style: pw.TextStyle(
      //                         fontSize: 17.0,
      //                         fontWeight: pw.FontWeight.bold,
      //                       ),
      //                     ),
      //                     pw.Text(
      //                       'Eco-Friendly Solution',
      //                       style: pw.TextStyle(
      //                         fontSize: 15.0,
      //                       ),
      //                     ),
      //                     pw.Text(
      //                       'Exceptional Quality',
      //                       style: pw.TextStyle(
      //                         fontSize: 15.0,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               pw.Expanded(
      //                 flex: 1,
      //                 child: pw.Column(
      //                   crossAxisAlignment: pw.CrossAxisAlignment.end,
      //                   children: [
      //                     pw.Text(
      //                       'Delivery Order',
      //                       style: pw.TextStyle(
      //                         fontSize: 15.5,
      //                         fontWeight: pw.FontWeight.bold,
      //                       ),
      //                     ),
      //                     pw.Text(
      //                       'Date: 17.02.2024',
      //                       style: pw.TextStyle(
      //                         fontSize: 14.0,
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         pw.SizedBox(height: 10),
      //         pw.Table.fromTextArray(
      //           headers: [
      //             'S.L',
      //             'Description',
      //             'Roll',
      //             'Meter',
      //             'Total Meter',
      //             'Rate (Tk)',
      //             'Amount (Tk)',
      //             'Remarks',
      //           ],
      //           data: [
      //             [
      //               '1',
      //               '3mm basic Bubble',
      //               '40',
      //               '90',
      //               '3600',
      //               '13.5',
      //               '48600',
      //               ''
      //             ],
      //             ['Total', '', '', '', '48600', '', '48600', ''],
      //           ],
      //           border: pw.TableBorder.all(),
      //           headerStyle: pw.TextStyle(
      //             fontSize: 9.0,
      //             fontWeight: pw.FontWeight.bold,
      //           ),
      //           cellAlignments: {
      //             0: pw.Alignment.center,
      //             1: pw.Alignment.centerLeft,
      //             2: pw.Alignment.center,
      //             3: pw.Alignment.center,
      //             4: pw.Alignment.center,
      //             5: pw.Alignment.center,
      //             6: pw.Alignment.center,
      //             7: pw.Alignment.center,
      //           },
      //         ),
      //         pw.SizedBox(height: 10),
      //         pw.Divider(),
      //         pw.SizedBox(height: 10),
      //         pw.Row(
      //           mainAxisAlignment: pw.MainAxisAlignment.end,
      //           children: [
      //             pw.Text(
      //               'IN WORDS BDT: FourtyEight Thousand Six Hundred Taka Only',
      //               style: pw.TextStyle(
      //                 fontSize: 11.0,
      //               ),
      //             ),
      //           ],
      //         ),
      //         pw.SizedBox(height: 10),
      //         pw.Text(
      //           'Delivery Date: 17-02-2023',
      //           style: pw.TextStyle(
      //             fontSize: 11.0,
      //           ),
      //         ),
      //         pw.SizedBox(height: 10),
      //         pw.Text(
      //           'Note: In case of failure in taking delivery within due time, beneficiary may cancel the D.O offered to the customer.',
      //           style: pw.TextStyle(
      //             fontSize: 11.0,
      //           ),
      //         ),
      //         pw.SizedBox(height: 10),
      //         pw.Divider(),
      //         pw.SizedBox(height: 10),
      //         pw.Container(
      //           alignment: pw.Alignment.centerRight,
      //           child: pw.Column(
      //             crossAxisAlignment: pw.CrossAxisAlignment.end,
      //             children: [
      //               pw.Text(
      //                 'Authorized Signature',
      //                 style: pw.TextStyle(
      //                   fontSize: 11.0,
      //                   fontWeight: pw.FontWeight.bold,
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ];
      //     },
      //     footer: (context) {
      //       return pw.Container(
      //         alignment: pw.Alignment.centerRight,
      //         margin: const pw.EdgeInsets.only(top: 20.0),
      //         child: pw.Text(
      //           'Copy to: 01 Honorable Chairman (DPIL) 02 Controller Accounts (Head Office) 03 Head Of Operation (DPIL) 04 Head Of HR& Admin (DPIL) 05 In-Charge (Store)',
      //           style: pw.TextStyle(
      //             fontSize: 11.0,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );

      doc.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              // Header Section

              // Existing content...
              pw.Container(
                margin: pw.EdgeInsets.only(bottom: 10),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        // crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          // pw.Text(
                          //   'Dynamic Polymer Industries Ltd.',
                          //   style: pw.TextStyle(
                          //     fontSize: 17.0,
                          //     fontWeight: pw.FontWeight.bold,
                          //   ),
                          // ),
                          // pw.Text(
                          //   'Eco-Friendly Solution',
                          //   style: pw.TextStyle(
                          //     fontSize: 15.0,
                          //   ),
                          // ),
                          // pw.Text(
                          //   'Exceptional Quality',
                          //   style: pw.TextStyle(
                          //     fontSize: 15.0,
                          //   ),
                          // ),

                          pw.Image(
                            pw.MemoryImage(header),
                            // height: 72,
                            // width: 72,
                          ),
                        ],
                      ),
                    ),
                    // pw.Expanded(
                    //   flex: 1,
                    //   child: pw.Column(
                    //     crossAxisAlignment: pw.CrossAxisAlignment.end,
                    //     children: [
                    //       pw.Text(
                    //         'Delivery Order',
                    //         style: pw.TextStyle(
                    //           fontSize: 15.5,
                    //           fontWeight: pw.FontWeight.bold,
                    //         ),
                    //       ),
                    //       pw.Text(
                    //         'Date: 17.02.2024',
                    //         style: pw.TextStyle(
                    //           fontSize: 14.0,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),

              pw.Container(
                margin: pw.EdgeInsets.only(bottom: 10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'DO#',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Marketing Person: Atik DPIL',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'DO Type: Non Package',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          'Supplier: Dynamic Polymer Industries Ltd.',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Supplier Address: West Dugri, Vawal Mirzapur, Gazipur',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Customer Name: Moin and Brothers | Mobile: 01795-743317',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Customer Address: Bangshal, Dhaka',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Rest of the content...
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: [
                  'S.L',
                  'Description',
                  'Roll',
                  'Meter',
                  'Total Meter',
                  'Rate (Tk)',
                  'Amount (Tk)',
                  'Remarks',
                ],
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
              // child: pw.Text(
              //   'Copy to: 01 Honorable Chairman (DPIL) 02 Controller Accounts (Head Office) 03 Head Of Operation (DPIL) 04 Head Of HR& Admin (DPIL) 05 In-Charge (Store)',
              //   style: pw.TextStyle(
              //     fontSize: 11.0,
              //   ),
              // ),
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
