// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dpil/model/douser_model.dart';
// import 'package:get/get.dart';

// class AdminAttendanceController extends GetxController {
//   RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);

//   // Firestore operation
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   late CollectionReference collectionReference;

//   RxList<DoUserModel> dousers = RxList<DoUserModel>([]);
//   Stream<List<DoUserModel>> getAlldoUsers() =>
//       collectionReference.snapshots().map((query) =>
//           query.docs.map((item) => DoUserModel.fromJson(item)).toList());

//   @override
//   void onInit() {
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("do_users");
//     getAlldoUsers().listen((vendor) {
//       dousers.assignAll(vendor);
//       founddouser.assignAll(dousers);
//     });
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     super.onClose();
//   }

//   Future<List<Map<String, dynamic>>> getAllSubcollectionData(
//       List<String> docIds) async {
//     List<Map<String, dynamic>> allSubcollectionData = [];
//     try {
//       for (String docId in docIds) {
//         CollectionReference subCollectionRef = FirebaseFirestore.instance
//             .collection('do_users')
//             .doc(docId)
//             .collection('Record');

//         QuerySnapshot querySnapshot = await subCollectionRef.get();
//         for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//           allSubcollectionData.add(doc.data() as Map<String, dynamic>);
//         }
//       }
//       print('All subcollection data: $allSubcollectionData');
//     } catch (e) {
//       print(e);
//     }
//     return allSubcollectionData;
//   }

//   void searchdouser(String searchQuery) {
//     if (searchQuery.isEmpty) {
//       founddouser.assignAll(dousers.toList());
//     } else {
//       List<DoUserModel> results = dousers
//           .where((element) =>
//               element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
//           .toList();
//       founddouser.clear(); // Clear the previous search results
//       founddouser.addAll(results); // Add new search results
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:dpil/model/douser_model.dart';

// class AdminAttendanceController extends GetxController {
//   RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);
//   RxList<Map<String, dynamic>> allSubcollectionData =
//       RxList<Map<String, dynamic>>();

//   // Firestore operation
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late CollectionReference collectionReference;
//   RxList<DoUserModel> dousers = RxList<DoUserModel>([]);

//   Stream<List<DoUserModel>> getAlldoUsers() =>
//       collectionReference.snapshots().map((query) =>
//           query.docs.map((item) => DoUserModel.fromJson(item)).toList());

//   @override
//   void onInit() {
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("do_users");
//     getAlldoUsers().listen((vendor) {
//       dousers.assignAll(vendor);
//       founddouser.assignAll(dousers);
//     });
//   }

//   // Future<void> getAllSubcollectionData() async {
//   //   List<Map<String, dynamic>> allData = [];
//   //   try {
//   //     for (var user in founddouser) {
//   //       CollectionReference subCollectionRef = firebaseFirestore
//   //           .collection('do_users')
//   //           .doc(user.docId)
//   //           .collection('Record');

//   //       QuerySnapshot querySnapshot = await subCollectionRef.get();
//   //       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//   //         allData.add(doc.data() as Map<String, dynamic>);
//   //       }
//   //     }
//   //     allSubcollectionData.assignAll(allData);
//   //     print('All subcollection data: $allData');
//   //   } catch (e) {
//   //     print(e);
//   //   }
//   // }

//   Future<void> getAllSubcollectionData() async {
//     List<Map<String, dynamic>> allData = [];
//     try {
//       for (var user in founddouser) {
//         CollectionReference subCollectionRef = firebaseFirestore
//             .collection('do_users')
//             .doc(user.docId)
//             .collection('Record');

//         QuerySnapshot querySnapshot = await subCollectionRef.get();
//         for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//           Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//           data['name'] =
//               user.name; // Include user name in the subcollection data
//           allData.add(data);
//         }
//       }
//       allSubcollectionData.assignAll(allData);
//       print('All subcollection data: $allData');
//     } catch (e) {
//       print(e);
//     }
//   }

//   void searchdouser(String searchQuery) {
//     if (searchQuery.isEmpty) {
//       founddouser.assignAll(dousers.toList());
//     } else {
//       List<DoUserModel> results = dousers
//           .where((element) =>
//               element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
//           .toList();
//       founddouser.clear(); // Clear the previous search results
//       founddouser.addAll(results); // Add new search results
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/presentation/allinvoicepreview/allinvoicepreview.screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

// class AdminAttendanceController extends GetxController {
//   RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);
//   RxMap<String, List<Map<String, dynamic>>> groupedSubcollectionData =
//       RxMap<String, List<Map<String, dynamic>>>();

//   // Firestore operation
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   late CollectionReference collectionReference;
//   RxList<DoUserModel> dousers = RxList<DoUserModel>([]);

//   Stream<List<DoUserModel>> getAlldoUsers() =>
//       collectionReference.snapshots().map((query) =>
//           query.docs.map((item) => DoUserModel.fromJson(item)).toList());

//   @override
//   void onInit() {
//     super.onInit();
//     collectionReference = firebaseFirestore.collection("do_users");
//     getAlldoUsers().listen((vendor) {
//       dousers.assignAll(vendor);
//       founddouser.assignAll(dousers);
//     });
//   }

//   Future<void> getAllSubcollectionData() async {
//     Map<String, List<Map<String, dynamic>>> allData = {};
//     try {
//       for (var user in founddouser) {
//         CollectionReference subCollectionRef = firebaseFirestore
//             .collection('do_users')
//             .doc(user.docId)
//             .collection('Record');

//         QuerySnapshot querySnapshot = await subCollectionRef.get();
//         for (QueryDocumentSnapshot doc in querySnapshot.docs) {
//           Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//           data['userName'] =
//               user.name; // Include user name in the subcollection data

//           if (!allData.containsKey(user.name)) {
//             allData[user.name!] = [];
//           }
//           allData[user.name]!.add(data);
//         }
//       }
//       groupedSubcollectionData.assignAll(allData);
//       print('Grouped subcollection data: $allData');
//     } catch (e) {
//       print(e);
//     }
//   }

//   void searchdouser(String searchQuery) {
//     if (searchQuery.isEmpty) {
//       founddouser.assignAll(dousers.toList());
//     } else {
//       List<DoUserModel> results = dousers
//           .where((element) =>
//               element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
//           .toList();
//       founddouser.clear(); // Clear the previous search results
//       founddouser.addAll(results); // Add new search results
//     }
//   }

//   Future<void> generateAttendancePdfForAll(
//     Map<String, List<List<dynamic>>> allData,
//   ) async {
//     final doc = pw.Document();

//     try {
//       final tableHeaders = [
//         'S.No.',
//         'Date',
//         'Check In',
//         'Check Out',
//         // Add other headers if needed
//       ];

//       allData.forEach((employeeName, data) {
//         doc.addPage(
//           pw.MultiPage(
//             margin: pw.EdgeInsets.all(10),
//             pageFormat: PdfPageFormat.a4,
//             build: (context) {
//               return [
//                 pw.Header(
//                   level: 0,
//                   child: pw.Text('Attendance Report: $employeeName',
//                       style: pw.TextStyle(
//                           fontSize: 24, fontWeight: pw.FontWeight.bold)),
//                 ),
//                 pw.SizedBox(height: 20),
//                 pw.Table.fromTextArray(
//                   headers: tableHeaders,
//                   data: List<List<dynamic>>.generate(
//                     data.length,
//                     (index) => [index + 1, ...data[index]],
//                   ),
//                   border: pw.TableBorder.all(),
//                   cellStyle: pw.TextStyle(fontSize: 12),
//                   headerStyle: pw.TextStyle(
//                     fontSize: 14,
//                     fontWeight: pw.FontWeight.bold,
//                   ),
//                   headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
//                 ),
//                 pw.SizedBox(height: 40), // Add space between employee sections
//               ];
//             },
//           ),
//         );
//       });

//       Get.to(() => AllinvoicepreviewScreen(
//             doc: doc,
//           ));
//     } catch (e) {
//       print(e);
//     }
//   }
// }

class AdminAttendanceController extends GetxController {
  RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);
  RxMap<String, List<Map<String, dynamic>>> groupedSubcollectionData =
      RxMap<String, List<Map<String, dynamic>>>();

  RxBool isGeneratingPdf = false.obs;

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
    getAlldoUsers().listen((vendor) {
      dousers.assignAll(vendor);
      founddouser.assignAll(dousers);
    });
  }

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

  // Future<void> getAllSubcollectionData() async {
  //   Map<String, List<Map<String, dynamic>>> allData = {};
  //   try {
  //     isGeneratingPdf.value = true;
  //     for (var user in founddouser) {
  //       CollectionReference subCollectionRef = firebaseFirestore
  //           .collection('do_users')
  //           .doc(user.docId)
  //           .collection('Record');

  //       QuerySnapshot querySnapshot = await subCollectionRef.get();
  //       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         data['userName'] =
  //             user.name; // Include user name in the subcollection data

  //         if (!allData.containsKey(user.name)) {
  //           allData[user.name!] = [];
  //         }
  //         allData[user.name]!.add(data);
  //       }
  //     }
  //     groupedSubcollectionData.assignAll(allData);
  //     print('Grouped subcollection data: $allData');
  //     isGeneratingPdf.value = false;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> generateAttendancePdfForAll() async {
  //   Map<String, List<List<dynamic>>> allData = {};
  //   groupedSubcollectionData.forEach((employeeName, records) {
  //     List<List<dynamic>> data = records.map((record) {
  //       return [
  //         _formatDateTime(record['date']),
  //         record['checkIn'],
  //         record['checkOut'],
  //         // Add other fields if needed
  //       ];
  //     }).toList();
  //     allData[employeeName] = data;
  //   });

  //   await generateAttendancePdf(allData);
  // }

  // Future<void> generateAttendancePdf(
  //   Map<String, List<List<dynamic>>> allData,
  // ) async {
  //   final doc = pw.Document();

  //   try {
  //     final tableHeaders = [
  //       'S.No.',
  //       'Date',
  //       'Check In',
  //       'Check Out',
  //       // Add other headers if needed
  //     ];

  //     allData.forEach((employeeName, data) {
  //       doc.addPage(
  //         pw.MultiPage(
  //           margin: pw.EdgeInsets.all(10),
  //           pageFormat: PdfPageFormat.a4,
  //           build: (context) {
  //             return [
  //               pw.Header(
  //                 level: 0,
  //                 child: pw.Text('Attendance Report: $employeeName',
  //                     style: pw.TextStyle(
  //                         fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //               ),
  //               pw.SizedBox(height: 20),
  //               pw.Table.fromTextArray(
  //                 headers: tableHeaders,
  //                 data: List<List<dynamic>>.generate(
  //                   data.length,
  //                   (index) => [index + 1, ...data[index]],
  //                 ),
  //                 border: pw.TableBorder.all(),
  //                 cellStyle: pw.TextStyle(fontSize: 12),
  //                 headerStyle: pw.TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: pw.FontWeight.bold,
  //                 ),
  //                 headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
  //               ),
  //               pw.SizedBox(height: 40), // Add space between employee sections
  //             ];
  //           },
  //         ),
  //       );
  //     });

  //     Get.to(() => AllinvoicepreviewScreen(doc: doc));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<Map<String, List<Map<String, dynamic>>>>
      getAllSubcollectionData() async {
    try {
      Map<String, List<Map<String, dynamic>>> allData = {};
      for (var user in founddouser) {
        CollectionReference subCollectionRef = firebaseFirestore
            .collection('do_users')
            .doc(user.docId)
            .collection('Record');

        QuerySnapshot querySnapshot = await subCollectionRef.get();
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['userName'] =
              user.name; // Include user name in the subcollection data

          if (!allData.containsKey(user.name)) {
            allData[user.name!] = [];
          }
          allData[user.name]!.add(data);
        }
      }
      print('Grouped subcollection data: $allData');
      return allData;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<void> generateAttendancePdfForAll() async {
    try {
      isGeneratingPdf.value = true;
      Map<String, List<Map<String, dynamic>>> allData =
          await getAllSubcollectionData();
      Map<String, List<List<dynamic>>> formattedData = {};

      allData.forEach((employeeName, records) {
        List<List<dynamic>> data = records.map((record) {
          return [
            _formatDateTime(record['date']),
            record['checkIn'],
            record['checkOut'],
            // Add other fields if needed
          ];
        }).toList();
        formattedData[employeeName] = data;
      });

      await generateAttendancePdf(formattedData);
      isGeneratingPdf.value = false;
    } catch (e) {
      print(e);
    }
  }

  // Future<void> generateAttendancePdf(
  //   Map<String, List<List<dynamic>>> allData,
  // ) async {
  //   final doc = pw.Document();

  //   try {
  //     final tableHeaders = [
  //       'Date',
  //       'Check In',
  //       'Check Out',

  //     ];

  //     allData.forEach((employeeName, data) {
  //       doc.addPage(
  //         pw.MultiPage(
  //           margin: pw.EdgeInsets.all(10),
  //           pageFormat: PdfPageFormat.a4,
  //           orientation: PageOrientation.landscape,
  //           build: (context) {
  //             return [
  //               pw.Header(
  //                 level: 0,
  //                 child: pw.Text('Attendance Report: $employeeName',
  //                     style: pw.TextStyle(
  //                         fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //               ),
  //               pw.SizedBox(height: 20),
  //               pw.Table.fromTextArray(
  //                 headers: tableHeaders,
  //                 data: data, // Data already formatted without serial number
  //                 border: pw.TableBorder.all(),
  //                 cellStyle: pw.TextStyle(fontSize: 12),
  //                 headerStyle: pw.TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: pw.FontWeight.bold,
  //                 ),
  //                 headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
  //               ),
  //               pw.SizedBox(height: 40), // Add space between employee sections
  //             ];
  //           },
  //         ),
  //       );
  //     });

  //     Get.to(() => AllinvoicepreviewScreen(doc: doc));
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> generateAttendancePdf(
    Map<String, List<List<dynamic>>> allData,
  ) async {
    final doc = pw.Document();

    try {
      // Extract all unique dates
      Set<String> allDates = allData.values
          .expand((data) => data.map((item) => item[0] as String))
          .toSet();

      // Build table headers with unique dates
      final tableHeaders = [
        'Date',
        ...allData.keys.toList(), // User names as column headers
      ];

      List<List<dynamic>> tableData = [];

      // Initialize tableData with empty lists for each user
      allData.keys.forEach((_) {
        tableData.add([]);
      });

      // Iterate through each date
      for (String date in allDates) {
        List<dynamic> rowData = [date];

        // Iterate through each user
        for (String userName in allData.keys) {
          var userData;
          try {
            // Find corresponding data for user and date
            userData = allData[userName]!.firstWhere(
              (data) => data[0] == date,
            );
          } catch (e) {
            // Handle the error, e.g., by providing a default value
            userData = null;
          }

          // Add check-in and check-out data if available, else add empty strings
          if (userData != null) {
            rowData.add('${userData[1]} - ${userData[2]}');
          } else {
            rowData.add('');
          }
        }

        // Add row data to table data
        tableData.add(rowData);
      }

      doc.addPage(
        pw.MultiPage(
          margin: pw.EdgeInsets.all(10),
          pageFormat: PdfPageFormat.a4,
          orientation: PageOrientation.landscape,
          build: (context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text('DPIL ALL Employee Attendance',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: tableData,
                border: pw.TableBorder.all(),
                cellStyle: pw.TextStyle(fontSize: 12),
                headerStyle: pw.TextStyle(
                  fontSize: 14,
                  fontWeight: pw.FontWeight.bold,
                ),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
              ),
            ];
          },
        ),
      );

      Get.to(() => AllinvoicepreviewScreen(doc: doc));
    } catch (e) {
      print(e);
    }
  }

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
}
