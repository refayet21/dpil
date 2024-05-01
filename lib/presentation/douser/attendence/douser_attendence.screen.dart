import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'controllers/douser_attendence.controller.dart';

class DouserAttendenceScreen extends StatelessWidget {
  final DouserAttendenceController _calendarController =
      Get.put(DouserAttendenceController());
  final box = GetStorage();
  String _formatDateTime(Timestamp timestamp) {
    // Convert the Timestamp object to a DateTime object
    DateTime dateTime = timestamp.toDate();
    // Format the date as desired using DateFormat
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Attendance History",
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Obx(
              () => Padding(
                padding: EdgeInsets.only(top: 32.h, bottom: 32.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _calendarController.selectedMonth.value,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.blue,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final month = await showMonthYearPicker(
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
                          fontSize: 18.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 500.h,
              child: Obx(
                () {
                  final filteredSnap = _calendarController.filteredAttendance;
                  return ListView.builder(
                    itemCount: filteredSnap.length,
                    itemBuilder: (context, index) {
                      var data = filteredSnap[index];
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 12.w),
                        margin: EdgeInsets.symmetric(
                            vertical: 6.h, horizontal: 3.w),
                        height: 220.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.r,
                              offset: Offset(2, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20.r),
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
                                      // fontFamily: "NexaRegular",
                                      fontSize: 16.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    "Check In Info",
                                    style: TextStyle(
                                      // fontFamily: "NexaRegular",
                                      fontSize: 14.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Time : ${data['checkIn']}",
                                    style: TextStyle(
                                      // fontFamily: "NexaRegular",
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Location: ${data['checkInLocation']}",
                                    style: TextStyle(
                                      // fontFamily: "NexaRegular",
                                      fontSize: 10.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  Text(
                                    "Check Out Info",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Time : ${data['checkOut']}",
                                    style: TextStyle(
                                      // fontFamily: "NexaRegular",
                                      fontSize: 12.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Location: ${data['checkOutLocation']}",
                                    style: TextStyle(
                                      // fontFamily: "NexaRegular",
                                      fontSize: 10.sp,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
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
      floatingActionButton:
          ElevatedButton(onPressed: () {}, child: Text('Print Attendance')),
    );
  }
}
