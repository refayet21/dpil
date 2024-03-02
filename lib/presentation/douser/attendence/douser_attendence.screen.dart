import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'controllers/douser_attendence.controller.dart';

class DouserAttendenceScreen extends StatelessWidget {
  final DouserAttendenceController _calendarController =
      Get.put(DouserAttendenceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() => Stack(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 32),
                      child: Text(
                        _calendarController.selectedMonth.value,
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: MediaQuery.of(context).size.width / 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(top: 32),
                      child: GestureDetector(
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
                            fontFamily: "NexaBold",
                            fontSize: MediaQuery.of(context).size.width / 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.45,
              child: StreamBuilder<QuerySnapshot>(
                stream: _calendarController.getAttendanceRecords(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        DateTime date = snap[index]['date'].toDate();
                        if (DateFormat('MMMM').format(date) ==
                            _calendarController.selectedMonth.value) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: index > 0 ? 12 : 0, left: 6, right: 6),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        DateFormat('EE\ndd').format(date),
                                        style: TextStyle(
                                          fontFamily: "NexaBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Check In",
                                        style: TextStyle(
                                          fontFamily: "NexaRegular",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        snap[index]['checkIn'],
                                        style: TextStyle(
                                          fontFamily: "NexaBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Check Out",
                                        style: TextStyle(
                                          fontFamily: "NexaRegular",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        snap[index]['checkOut'],
                                        style: TextStyle(
                                          fontFamily: "NexaBold",
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
