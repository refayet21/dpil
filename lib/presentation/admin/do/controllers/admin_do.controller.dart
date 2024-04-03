import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:dpil/presentation/screens.dart';
import 'package:dpil/presentation/widgets/number_to_word.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AdminDoController extends GetxController {
  RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<DoUserModel> dousers = RxList<DoUserModel>([]);
  Stream<List<DoUserModel>> getAlldoUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => DoUserModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("do_users");
    dousers.bindStream(getAlldoUsers());
    founddouser = dousers;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void searchdouser(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     founddouser.assignAll(dousers.toList());
  //   } else {
  //     List<DoUserModel> results = dousers
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     founddouser.assignAll(results);
  //   }
  // }
  void searchdouser(String searchQuery) {
    if (searchQuery.isEmpty) {
      founddouser.assignAll(dousers.toList());
    } else {
      List<DoUserModel> results = dousers
          .where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      founddouser.clear(); // Clear the previous search results
      founddouser.addAll(results); // Add new search results
    }
  }

  String generateddate = DateFormat('dd.MM.yyyy').format(DateTime.now());
  // var docounter = 0;

  Future<void> generateInvoicePdf(
      String doNo,
      String date,
      String userId,
      String marketingperson,
      String vendorName,
      String vendorAddress,
      String contactPerson,
      String vendorMobile,
      List<List<dynamic>> data,
      // List<List<dynamic>> stockdata,
      // List<dynamic> data,
      var totalinword,
      String? deliveryDate) async {
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
        'Roll/PCS/Bag',
        'Per Roll/PCS/Bag',
        'Unit',
        'Per Unit Price',
        'Total Unit',
        'Amount(Tk)',
        'Remarks',
      ];

      doc.addPage(
        pw.MultiPage(
          margin:
              pw.EdgeInsets.only(top: 3, right: 10.w, bottom: 6, left: 10.w),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        // crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
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
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [pw.Text('Date: $date')],
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
                    pw.Text("Marketing Person : ${marketingperson}"),
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
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: data,
                cellStyle: pw.TextStyle(
                  fontSize: 7.sp,
                ),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                  fontSize: 7.sp,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'In words: ${NumberToWords.convert(totalinword)}',
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
              pw.SizedBox(height: 20.h),
              pw.Container(
                // alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Authorized Signature',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Text(
                      'Copy to:',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '01 Honorable Chairrman (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '02 Controller Accounts (Head Office)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '03 Head Of Operation (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '04 Head Of HR & Admin (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '05 In-Charge (Store)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
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

      Get.to(() => AllinvoicepreviewScreen(
            doc: doc,
            pdfname: doNo,
            deliveryOrder: DeliveryOrder(
              doNo: doNo,
              date: date,
              userId: userId,
              marketingPerson: marketingperson,
              vendorName: vendorName,
              vendorAddress: vendorAddress,
              contactPerson: contactPerson,
              vendorMobile: vendorMobile,
              data: data,
              totalInWord: totalinword,
              deliveryDate: deliveryDate,
            ),
            // stockdata: stockdata,
          ));
    } catch (e) {
      print('Error: $e');
    }
  }
}
