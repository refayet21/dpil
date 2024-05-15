import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'controllers/admin_previewattendance.controller.dart';

class AdminPreviewattendanceScreen
    extends GetView<AdminPreviewattendanceController> {
  // const AdminPreviewattendanceScreen({Key? key}) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('AdminPreviewattendanceScreen'),
  //       centerTitle: true,
  //     ),
  //     body: const Center(
  //       child: Text(
  //         'AdminPreviewattendanceScreen is working',
  //         style: TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // }

  final String? employeeId;
  final String? employeeName;
  final AdminPreviewattendanceController _calendarController;

  AdminPreviewattendanceScreen({this.employeeId, this.employeeName})
      : _calendarController =
            Get.put(AdminPreviewattendanceController(employeeId: employeeId));

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  var month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monthly Attendance"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: 32, bottom: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _calendarController.selectedMonth.value,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        month = await showMonthYearPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2099),
                        );

                        if (month != null) {
                          _calendarController.updateSelectedMonth(month);
                        }
                      },
                      child: Text(
                        "Pick a Month",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: Obx(
                () {
                  final filteredSnap = _calendarController.filteredAttendance;
                  return ListView.builder(
                    itemCount: filteredSnap.length,
                    itemBuilder: (context, index) {
                      var data = filteredSnap[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        margin:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 3),
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Date: ${_formatDateTime(data['date'])}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Check In Info",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Time : ${data['checkIn']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Location: ${data['checkInLocation']}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Check Out Info",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Time : ${data['checkOut']}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "Location: ${data['checkOutLocation']}",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _calendarController.generateSingleAttendencePdf(
      //       employeeName!,
      //       _calendarController.filteredAttendance
      //           .map((snapshot) =>
      //               (snapshot.data() as Map<String, dynamic>).values.toList())
      //           .toList(),
      //     );
      //   },
      //   child: Icon(Icons.picture_as_pdf),
      // ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _calendarController.generateSingleAttendencePdf(
            employeeName!,
            _calendarController.filteredAttendance
                .map((snapshot) => [
                      _formatDateTime(snapshot['date']),
                      snapshot['checkIn'],
                      snapshot['checkInLocation'],
                      snapshot['checkOut'],
                      snapshot['checkOutLocation'],
                    ])
                .toList(),
          );
        },
        child: Text('Generate PDF'),
      ),
    );
  }
}
