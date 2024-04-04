import 'package:dpil/const/image_constant.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:dpil/presentation/widgets/custom_card.dart';
import 'package:dpil/presentation/widgets/custom_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/admin_dashboard.controller.dart';

class AdminDashboardScreen extends GetView<AdminDashboardController> {
  final box = GetStorage();
  AdminDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                box.remove('adminemail');
                Get.offNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // CustomCard(
            //   logoPath: ImageConstant
            //       .splash_screen_image, // Provide the path to your logo image
            //   title: 'Eco-Friendly Solution',
            //   subtitle: 'Exceptional Quality',
            // ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomShape(
                  imageurl: ImageConstant.adduser,
                  title: 'DO USER',
                  onTap: () {
                    Get.toNamed(
                      Routes.ADMIN_ADDDOUSER,
                    );
                  },
                ),
                CustomShape(
                  imageurl: ImageConstant.generaluser,
                  title: 'GEN USER',
                  onTap: () {
                    Get.toNamed(
                      Routes.ADMIN_ADDGENUSER,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomShape(
                  imageurl: ImageConstant.other,
                  title: 'Stock User',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_ADDSTOCKUSER,
                    );
                  },
                ),
                CustomShape(
                  imageurl: ImageConstant.gmail,
                  title: 'EMAIL',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_EMAIL,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomShape(
                  imageurl: ImageConstant.addcustomer,
                  title: 'CUSTOMER',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_ADDVENDOR,
                    );
                  },
                ),
                CustomShape(
                  imageurl: ImageConstant.addproduct,
                  title: 'PRODUCT',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_ADDPRODUCT,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomShape(
                  imageurl: ImageConstant.attendance,
                  title: 'DO ATTENDANCE',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_ATTENDANCE,
                    );
                  },
                ),
                CustomShape(
                  imageurl: ImageConstant.doorder,
                  title: 'DO',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_DO,
                    );
                  },
                ),
              ],
            ),

            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomShape(
                  imageurl: ImageConstant.genattendance,
                  title: 'GEN ATTENDANCE',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_GENATTENDENCE,
                    );
                  },
                ),
                CustomShape(
                  imageurl: ImageConstant.info,
                  title: 'Info',
                  onTap: () {
                    Get.toNamed(
                      // Routes.ALL_INPUT_FIELD,
                      Routes.ADMIN_INFO,
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
