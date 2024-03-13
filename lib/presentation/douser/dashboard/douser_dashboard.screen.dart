import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'controllers/douser_dashboard.controller.dart';

class DouserDashboardScreen extends StatelessWidget {
  final DouserDashboardController controller =
      Get.put(DouserDashboardController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                box.remove('douseremail');
                Get.offNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            ),
            Obx(() => Text(
                  "Employee : ${controller.employeeName.value}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(height: 32),
            Text(
              "Today's Status",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 170,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Check In",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(() => Text(
                            controller.checkIn.value,
                            style: TextStyle(
                              fontSize: 18,
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
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      Obx(() => Text(
                            controller.checkOut.value,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "${DateFormat('d MMMM yyyy').format(DateTime.now())}",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Text(
                  DateFormat('hh:mm:ss a').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Obx(
              () => controller.checkOut.value == "--/--"
                  ? Obx(() => SlideAction(
                        key: controller.slideActionKey,
                        text: controller.checkIn.value == "--/--"
                            ? "Slide to Check In"
                            : "Slide to Check Out",
                        textStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
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
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        )
                      : SizedBox()),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() => controller.locations.value != " " &&
                    (controller.checkIn.value != "--/--" ||
                        controller.checkOut.value != "--/--")
                ? Text(
                    "Location: ${controller.locations.value}",
                  )
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
