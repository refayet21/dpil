import 'package:dpil/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_genattendence.controller.dart';

class AdminGenattendenceScreen extends GetView<AdminGenattendenceController> {
  const AdminGenattendenceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'General User Attendence',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.all(8.0.r),
          //   child: TextField(
          //     onChanged: (value) => controller.searchGenuser(value),
          //     decoration: InputDecoration(
          //       hintText: "Search",
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(
              () {
                // Sort founddouser list by name
                controller.foundGenuser
                    .sort((a, b) => a.name!.compareTo(b.name!));

                return ListView.builder(
                  itemCount: controller.foundGenuser.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.grey.shade200,
                    child: ListTile(
                      title: Text(
                        'Name : ${controller.foundGenuser[index].name!}',
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
                            'Address :${controller.foundGenuser[index].address!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Mobile : ${controller.foundGenuser[index].mobile!}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Text(
                            'Email : ${controller.foundGenuser[index].email!}',
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
                          controller.foundGenuser[index].name!
                              .substring(0, 1)
                              .capitalize!,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                        ),
                        backgroundColor: Colors.blue.shade200,
                      ),
                      onTap: () {
                        Get.to(() => AdminPreviewgenattendenceScreen(
                              employeeId: controller.foundGenuser[index].docId!,
                              employeeName:
                                  controller.foundGenuser[index].name!,
                            ));
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
