import 'package:dpil/presentation/widgets/reuseable_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/drawer_menu.dart';

class DoDrawer extends StatelessWidget {
  final List<DrawerMenuItem> drawerItems = [
    DrawerMenuItem(
        title: 'Home',
        routeName: Routes.DOUSER_DASHBOARD,
        icon: Icons.dashboard),
    DrawerMenuItem(
        title: 'Attendence History',
        routeName: Routes.DOUSER_ATTENDENCE,
        icon: Icons.attribution),
    DrawerMenuItem(
        title: 'Customer Add',
        routeName: Routes.DOUSER_ADDCUSTOMER,
        icon: Icons.add),
    DrawerMenuItem(
        title: 'Product Add',
        routeName: Routes.DOUSER_ADDPRODUCT,
        icon: Icons.add_box),
    DrawerMenuItem(
        title: 'Delivery Order',
        routeName: Routes.DOUSER_PRODUCTCART,
        icon: Icons.delivery_dining),
    DrawerMenuItem(
        title: 'DO History',
        routeName: Routes.DOUSER_INVOICE,
        icon: Icons.history),
  ];
  DoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ReuseAbleDrawer(
        header: DrawerHeader(
          child: Row(
            children: [
              // Your app logo or image
              // Image.asset(
              //   'assets/images/app_logo.png',
              //   width: 50,
              //   height: 50,
              // ),
              SizedBox(width: 16.w),
              // Your app name or title
              Text(
                'DPIL',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue, // Change this to your desired color
          ),
        ),
        menuItems: drawerItems);
  }
}
