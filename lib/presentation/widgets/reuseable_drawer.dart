import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dpil/model/drawer_menu.dart';

class ReuseAbleDrawer extends StatelessWidget {
  final Widget header;
  final List<DrawerMenuItem> menuItems;

  const ReuseAbleDrawer({
    super.key,
    required this.header,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header,
            Column(
              children: menuItems.map((item) {
                final bool isSelected = Get.currentRoute == item.routeName;
                return Column(
                  children: [
                    const Divider(color: Colors.grey),
                    ListTile(
                      title: Text(
                        item.title!,
                        style: TextStyle(
                          fontSize: isSelected ? 16.sp : 14.sp,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w200,
                          color: isSelected ? Colors.black : null,
                        ),
                      ),
                      onTap: () {
                        Get.back();
                        Get.offNamed(item.routeName!);
                      },
                      trailing: Icon(
                        item.icon,
                        color: isSelected ? Colors.black : null,
                        size: isSelected ? 22.sp : 14.sp,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
