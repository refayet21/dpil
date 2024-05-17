// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:get/get.dart';

// import 'controllers/admin_attendance.controller.dart';

// class AdminAttendanceScreen extends GetView<AdminAttendanceController> {
//   const AdminAttendanceScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // drawer: AdminDrawer(),
//       appBar: AppBar(
//         title: Text(
//           'DPIL',
//           style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               onChanged: (value) => controller.searchdouser(value),
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: controller.founddouser.length,
//                 itemBuilder: (context, index) => Card(
//                   color: Colors.grey.shade200,
//                   child: ListTile(
//                     title: Text(
//                       'Name : ${controller.founddouser[index].name!}',
//                       style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black),
//                     ),
//                     subtitle: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                         Text(
//                           'Address :${controller.founddouser[index].address!}',
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                         Text(
//                           'Mobile : ${controller.founddouser[index].mobile!}',
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                         Text(
//                           'Email : ${controller.founddouser[index].email!}',
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black),
//                         ),
//                         SizedBox(
//                           height: 3.h,
//                         ),
//                       ],
//                     ),
//                     leading: CircleAvatar(
//                       child: Text(
//                         controller.founddouser[index].name!
//                             .substring(0, 1)
//                             .capitalize!,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, color: Colors.black),
//                       ),
//                       backgroundColor: Colors.blue.shade200,
//                     ),
//                     onTap: () {
//                       print(
//                           'Doc Id is : ${controller.founddouser[index].docId!}');
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/admin/previewattendance/admin_previewattendance.screen.dart';
import 'package:dpil/presentation/douser/attendence/douser_attendence.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controllers/admin_attendance.controller.dart';

// class AdminAttendanceScreen extends GetView<AdminAttendanceController> {
//   const AdminAttendanceScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DO User Attendence',
//           style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0.r),
//             child: TextField(
//               onChanged: (value) => controller.searchdouser(value),
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           // Expanded(
//           //   child: Obx(
//           //     () => ListView.builder(
//           //       itemCount: controller.founddouser.length,
//           //       itemBuilder: (context, index) => Card(
//           //         color: Colors.grey.shade200,
//           //         child: ListTile(
//           //           title: Text(
//           //             'Name : ${controller.founddouser[index].name!}',
//           //             style: TextStyle(
//           //                 fontSize: 16.sp,
//           //                 fontWeight: FontWeight.w600,
//           //                 color: Colors.black),
//           //           ),
//           //           subtitle: Column(
//           //             mainAxisAlignment: MainAxisAlignment.start,
//           //             crossAxisAlignment: CrossAxisAlignment.start,
//           //             children: [
//           //               SizedBox(
//           //                 height: 3.h,
//           //               ),
//           //               Text(
//           //                 'Address :${controller.founddouser[index].address!}',
//           //                 style: TextStyle(
//           //                     fontSize: 14.sp,
//           //                     fontWeight: FontWeight.w600,
//           //                     color: Colors.black),
//           //               ),
//           //               SizedBox(
//           //                 height: 3.h,
//           //               ),
//           //               Text(
//           //                 'Mobile : ${controller.founddouser[index].mobile!}',
//           //                 style: TextStyle(
//           //                     fontSize: 14.sp,
//           //                     fontWeight: FontWeight.w600,
//           //                     color: Colors.black),
//           //               ),
//           //               SizedBox(
//           //                 height: 3.h,
//           //               ),
//           //               Text(
//           //                 'Email : ${controller.founddouser[index].email!}',
//           //                 style: TextStyle(
//           //                     fontSize: 14.sp,
//           //                     fontWeight: FontWeight.w600,
//           //                     color: Colors.black),
//           //               ),
//           //               SizedBox(
//           //                 height: 3.h,
//           //               ),
//           //             ],
//           //           ),
//           //           leading: CircleAvatar(
//           //             child: Text(
//           //               controller.founddouser[index].name!
//           //                   .substring(0, 1)
//           //                   .capitalize!,
//           //               style: TextStyle(
//           //                   fontWeight: FontWeight.w700, color: Colors.black),
//           //             ),
//           //             backgroundColor: Colors.blue.shade200,
//           //           ),
//           //           onTap: () {
//           //             Get.to(() => AdminPreviewattendanceScreen(
//           //                   employeeId: controller.founddouser[index].docId!,
//           //                 ));
//           //             print(
//           //                 'Doc Id is : ${controller.founddouser[index].docId!}');
//           //           },
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           Expanded(
//             child: Obx(
//               () {
//                 // Sort founddouser list by name
//                 controller.founddouser
//                     .sort((a, b) => a.name!.compareTo(b.name!));

//                 return ListView.builder(
//                   itemCount: controller.founddouser.length,
//                   itemBuilder: (context, index) => Card(
//                     color: Colors.grey.shade200,
//                     child: ListTile(
//                       title: Text(
//                         'Name : ${controller.founddouser[index].name!}',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black,
//                         ),
//                       ),
//                       subtitle: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 3.h),
//                           Text(
//                             'Address :${controller.founddouser[index].address!}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             'Mobile : ${controller.founddouser[index].mobile!}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                           SizedBox(height: 3.h),
//                           Text(
//                             'Email : ${controller.founddouser[index].email!}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black,
//                             ),
//                           ),
//                           // SizedBox(height: 3.h),
//                           // Text(
//                           //   'Password : ${controller.founddouser[index].password!}',
//                           //   style: TextStyle(
//                           //     fontSize: 14.sp,
//                           //     fontWeight: FontWeight.w600,
//                           //     color: Colors.black,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       leading: CircleAvatar(
//                         child: Text(
//                           controller.founddouser[index].name!
//                               .substring(0, 1)
//                               .capitalize!,
//                           style: TextStyle(
//                               fontWeight: FontWeight.w700, color: Colors.black),
//                         ),
//                         backgroundColor: Colors.blue.shade200,
//                       ),
//                       onTap: () {
//                         Get.to(() => AdminPreviewattendanceScreen(
//                               employeeId: controller.founddouser[index].docId!,
//                               employeeName: controller.founddouser[index].name!,
//                             ));
//                         // print(
//                         //     'Doc Id is : ${controller.founddouser[index].docId!}');
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           controller.getAllSubcollectionData;
//         },
//         child: Text('Generate PDF'),
//       ),
//     );
//   }
// }

// class AdminAttendanceScreen extends GetView<AdminAttendanceController> {
//   const AdminAttendanceScreen({Key? key}) : super(key: key);

//   String _formatDateTime(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('dd-MM-yyyy').format(dateTime);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'DO User Attendance',
//           style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0.r),
//             child: TextField(
//               onChanged: (value) => controller.searchdouser(value),
//               decoration: InputDecoration(
//                 hintText: "Search",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 10.h),
//           Expanded(
//             child: Obx(() {
//               // Sort founddouser list by name
//               controller.founddouser.sort((a, b) => a.name!.compareTo(b.name!));

//               return ListView.builder(
//                 itemCount: controller.founddouser.length,
//                 itemBuilder: (context, index) => Card(
//                   color: Colors.grey.shade200,
//                   child: ListTile(
//                     title: Text(
//                       'Name : ${controller.founddouser[index].name!}',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     subtitle: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 3.h),
//                         Text(
//                           'Address :${controller.founddouser[index].address!}',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 3.h),
//                         Text(
//                           'Mobile : ${controller.founddouser[index].mobile!}',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 3.h),
//                         Text(
//                           'Email : ${controller.founddouser[index].email!}',
//                           style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     leading: CircleAvatar(
//                       child: Text(
//                         controller.founddouser[index].name!
//                             .substring(0, 1)
//                             .capitalize!,
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, color: Colors.black),
//                       ),
//                       backgroundColor: Colors.blue.shade200,
//                     ),
//                     onTap: () {
//                       Get.to(() => AdminPreviewattendanceScreen(
//                             employeeId: controller.founddouser[index].docId!,
//                             employeeName: controller.founddouser[index].name!,
//                           ));
//                     },
//                   ),
//                 ),
//               );
//             }),
//           ),
//           // Obx(() {
//           //   if (controller.allSubcollectionData.isEmpty) {
//           //     return Container();
//           //   }
//           //   return Expanded(
//           //     child: ListView.builder(
//           //       itemCount: controller.allSubcollectionData.length,
//           //       itemBuilder: (context, index) {
//           //         var data = controller.allSubcollectionData[index];
//           //         return ListTile(
//           //           title: Text(
//           //               'date: ${_formatDateTime(data['date'])}'), // Adjust according to your data structure
//           //           subtitle: Column(
//           //             children: [
//           //               Text('checkIn: ${data['checkIn']}'),
//           //               Text('checkOut: ${data['checkOut']}'),
//           //             ],
//           //           ), // Adjust according to your data structure
//           //         );
//           //       },
//           //     ),
//           //   );
//           // }),
//           //     Obx(() {
//           //       if (controller.allSubcollectionData.isEmpty) {
//           //         return Container();
//           //       }
//           //       return Expanded(
//           //         child: ListView.builder(
//           //           itemCount: controller.allSubcollectionData.length,
//           //           itemBuilder: (context, index) {
//           //             var data = controller.allSubcollectionData[index];
//           //             return ListTile(
//           //               title: Text('Name: ${data['name']}'), // Show the user name
//           //               subtitle: Column(
//           //                 crossAxisAlignment: CrossAxisAlignment.start,
//           //                 children: [
//           //                   Text('Date: ${_formatDateTime(data['date'])}'),
//           //                   Text('CheckIn: ${data['checkIn']}'),
//           //                   Text('CheckOut: ${data['checkOut']}'),
//           //                 ],
//           //               ),
//           //             );
//           //           },
//           //         ),
//           //       );
//           //     }),
//           //   ],
//           // ),

//           Obx(() {
//             if (controller.groupedSubcollectionData.isEmpty) {
//               return Container();
//             }
//             return Expanded(
//               child: ListView.builder(
//                 itemCount: controller.groupedSubcollectionData.keys.length,
//                 itemBuilder: (context, index) {
//                   String userName =
//                       controller.groupedSubcollectionData.keys.elementAt(index);
//                   List<Map<String, dynamic>> records =
//                       controller.groupedSubcollectionData[userName]!;
//                   return ExpansionTile(
//                     title: Text(userName),
//                     children: records.map((data) {
//                       return ListTile(
//                         title: Text('Date: ${_formatDateTime(data['date'])}'),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('CheckIn: ${data['checkIn']}'),
//                             Text('CheckOut: ${data['checkOut']}'),
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   );
//                 },
//               ),
//             );
//           }),
//         ],
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           controller.getAllSubcollectionData();
//         },
//         child: Text('Generate PDF'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminAttendanceScreen extends GetView<AdminAttendanceController> {
  const AdminAttendanceScreen({Key? key}) : super(key: key);

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DO User Attendance',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchdouser(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: Obx(() {
              // Sort founddouser list by name
              controller.founddouser.sort((a, b) => a.name!.compareTo(b.name!));

              return ListView.builder(
                itemCount: controller.founddouser.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.founddouser[index].name!}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'Address :${controller.founddouser[index].address!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Mobile : ${controller.founddouser[index].mobile!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Email : ${controller.founddouser[index].email!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.founddouser[index].name!
                            .substring(0, 1)
                            .capitalize!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      backgroundColor: Colors.blue.shade200,
                    ),
                    onTap: () {
                      Get.to(() => AdminPreviewattendanceScreen(
                            employeeId: controller.founddouser[index].docId!,
                            employeeName: controller.founddouser[index].name!,
                          ));
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => ElevatedButton(
          onPressed: controller.isGeneratingPdf.value
              ? null
              : () async {
                  await controller.generateAttendancePdfForAll();
                },
          child: controller.isGeneratingPdf.value
              ? CircularProgressIndicator() // Show loading indicator while generating PDF
              : Text('Generate PDF'),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   controller.generateAttendancePdf(allData)
      // },),
    );
  }
}
