import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/admin_dashboard.controller.dart';

class AdminDashboardScreen extends GetView<AdminDashboardController> {
  final box = GetStorage();
  AdminDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text('DPIL'),
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
      body: const Center(
        child: Text(
          'AdminDashboardScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
