import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';

import 'controllers/douser_dashboard.controller.dart';

class DouserDashboardScreen extends StatelessWidget {
  final DouserDashboardController controller =
      Get.put(DouserDashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DPIL'),
        centerTitle: true,
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
                  "Employee : ${controller.employeeId.value}",
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
            Obx(() => controller.checkOut.value == "--/--"
                ? SlideAction(
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
                        controller.checkInAction();
                      } else {
                        controller.checkOutAction();
                      }
                    },
                  )
                : Text(
                    "You have completed this day!",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black54,
                    ),
                  )),
            Obx(() => controller.locations.value != " "
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
