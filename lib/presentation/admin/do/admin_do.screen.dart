import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_do.controller.dart';

class AdminDoScreen extends GetView<AdminDoController> {
  const AdminDoScreen({Key? key}) : super(key: key);
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
      body: const Center(
        child: Text(
          'AdminDoScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
