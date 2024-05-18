import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/presentation/allinvoicepreview/allinvoicepreview.screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class AdminPreviewattendanceController extends GetxController {
  var employeeName = ''.obs;
  String? employeeId;

  // RxList<List<dynamic>>? dataList;

  AdminPreviewattendanceController(
      {this.employeeId}); // Constructor to accept employeeId

  @override
  void onReady() {
    super.onReady();
    getAttendanceRecords(employeeId);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString selectedMonth = DateFormat('MMMM').format(DateTime.now()).obs;

  Stream<QuerySnapshot> getAttendanceRecords(String? employeeId) {
    if (employeeId != null && employeeId.isNotEmpty) {
      return _firestore
          .collection("do_users")
          .doc(employeeId)
          .collection("Record")
          .snapshots();
    } else {
      // print('Employee ID is empty');
      return Stream.empty();
    }
  }

  void updateSelectedMonth(DateTime month) {
    selectedMonth.value = DateFormat('MMMM').format(month);
    // print('Selected month is ${selectedMonth.value}');
  }

  List<DocumentSnapshot>? get attendanceRecordsList =>
      _attendanceRecordsStream.value?.docs;

  final _attendanceRecordsStream = Rxn<QuerySnapshot>();

  @override
  void onInit() {
    super.onInit();
    _attendanceRecordsStream
        .bindStream(getAttendanceRecords(employeeId)); // Pass employeeId
  }

  // Define filteredAttendance property here
  List<DocumentSnapshot> get filteredAttendance {
    if (selectedMonth.value.isNotEmpty) {
      final selectedMonthInt =
          DateFormat('MMMM').parse(selectedMonth.value).month;
      return attendanceRecordsList?.where((record) {
            final recordMonth = record['date'].toDate().month;
            return recordMonth == selectedMonthInt;
          }).toList() ??
          [];
    } else {
      return [];
    }
  }

  Future<void> generateSingleAttendencePdf(
    String employeeName,
    List<List<dynamic>> data,
  ) async {
    final doc = pw.Document();

    try {
      // Load fonts
      // final fontData = await rootBundle.load("assets/fonts/robotoregular.ttf");
      // final ttf = pw.Font.ttf(fontData);

      // final fallbackfontData =
      //     await rootBundle.load("assets/fonts/siyamrupali.ttf");

      final header = (await rootBundle.load('assets/images/headerpad.png'))
          .buffer
          .asUint8List();
      final footer = (await rootBundle.load('assets/images/footerpad.png'))
          .buffer
          .asUint8List();

      final tableHeaders = [
        'Date',
        'Check In',
        'Location',
        'Check Out',
        'Location',
      ];

      doc.addPage(
        pw.MultiPage(
          // theme: pw.ThemeData.withFont(
          //   base: ttf,
          // ),
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
                            'Attendance Of $employeeName ',
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
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.SizedBox(height: 8.h),
                          pw.Text(
                            'Month: ${selectedMonth.value}',
                            style: pw.TextStyle(
                              fontSize: 15.sp,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                          pw.SizedBox(height: 8.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: data,

                // data: dataList,
                cellStyle: pw.TextStyle(
                  fontSize: 7,
                  // font: ttf,
                  // fontFallback: [pw.Font.ttf(fallbackfontData)]
                ),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                  fontSize: 7,
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
            pdfname: 'AttendanceOf$employeeName Month:${selectedMonth.value}',
          ));
    } catch (e) {}
  }
}
