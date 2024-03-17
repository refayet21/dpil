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

import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/admin/previewattendance/admin_previewattendance.screen.dart';
import 'package:dpil/presentation/douser/attendence/douser_attendence.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controllers/admin_attendance.controller.dart';

class AdminAttendanceScreen extends GetView<AdminAttendanceController> {
  const AdminAttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchdouser(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.founddouser.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.founddouser[index].name!}',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Address :${controller.founddouser[index].address!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Mobile : ${controller.founddouser[index].mobile!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Email : ${controller.founddouser[index].email!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
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
                          ));
                      print(
                          'Doc Id is : ${controller.founddouser[index].docId!}');
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
