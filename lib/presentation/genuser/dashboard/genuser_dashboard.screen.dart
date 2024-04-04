import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/ge_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'controllers/genuser_dashboard.controller.dart';

class GenuserDashboardScreen extends GetView<GenuserDashboardController> {
  GenuserDashboardScreen({Key? key}) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GenDrawer(),
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
                box.remove('generalemail');
                box.remove('genemployeeId');
                Get.offNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(() => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ${controller.employeeName.value}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Address: ${controller.employeeaddress.value}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Mobile : ${controller.employeemobile.value}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      "Email: ${controller.employeeemail.value}",
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 32.h),
            Text(
              "Today's Status",
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 170.h,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Check In",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                      Obx(() => Text(
                            controller.checkIn.value,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Check Out",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700),
                      ),
                      Obx(() => Text(
                            controller.checkOut.value,
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              "${DateFormat('d MMMM yyyy').format(DateTime.now())}",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 22.sp,
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black54,
                  ),
                );
              },
            ),
            SizedBox(height: 24.h),
            Obx(
              () => controller.checkOut.value == "--/--"
                  ? Obx(() => SlideAction(
                        key: controller.slideActionKey,
                        text: controller.checkIn.value == "--/--"
                            ? "Slide to Check In"
                            : "Slide to Check Out",
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 20.h,
                        ),
                        outerColor: Colors.white,
                        innerColor: Colors.blue,
                        onSubmit: () {
                          if (controller.checkIn.value == "--/--") {
                            controller.handleSlideAction(true);
                          } else {
                            controller.handleSlideAction(false);
                          }
                        },
                      ))
                  : Obx(() => controller.checkOut.value != "--/--"
                      ? Text(
                          "You have completed this day!",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox()),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() =>
                    // controller.locations.value != " " &&
                    //         (controller.checkIn.value != "--/--" ||
                    //             controller.checkOut.value != "--/--")
                    //     ?
                    Text(
                      "Location: ${controller.locations.value}",
                    )
                // : SizedBox()
                ),
          ],
        ),
      ),
    );
  }
}
