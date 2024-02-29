import 'package:dpil/presentation/widgets/reuseable_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/drawer_menu.dart';

class AdminDrawer extends StatelessWidget {
  final List<DrawerMenuItem> drawerItems = [
    DrawerMenuItem(
        title: 'Home',
        routeName: Routes.ADMIN_DASHBOARD,
        icon: Icons.dashboard),
    DrawerMenuItem(
        title: 'Add Do User',
        routeName: Routes.ADMIN_ADDDOUSER,
        icon: Icons.print),
    DrawerMenuItem(
        title: 'Add General User',
        routeName: Routes.ADMIN_ADDGENUSER,
        icon: Icons.inventory),
    DrawerMenuItem(
        title: 'Add Product ',
        routeName: Routes.ADMIN_ADDPRODUCT,
        icon: Icons.production_quantity_limits_outlined),
    DrawerMenuItem(
        title: 'Add Vendor ',
        routeName: Routes.ADMIN_ADDVENDOR,
        icon: Icons.production_quantity_limits),
    // DrawerMenuItem(
    //   title: 'Version No',
    // ),
  ];
  AdminDrawer({
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
