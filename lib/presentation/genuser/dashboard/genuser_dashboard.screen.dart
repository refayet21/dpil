import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/genuser_dashboard.controller.dart';

class GenuserDashboardScreen extends GetView<GenuserDashboardController> {
  GenuserDashboardScreen({Key? key}) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenuserDashboardScreen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                box.remove('generalemail');
                Get.offNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text(
          'GenuserDashboardScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
