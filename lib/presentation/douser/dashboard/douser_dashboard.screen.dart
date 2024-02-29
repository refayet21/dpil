import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/douser_dashboard.controller.dart';

class DouserDashboardScreen extends GetView<DouserDashboardController> {
  DouserDashboardScreen({Key? key}) : super(key: key);
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: const Text('DouserDashboardScreen'),
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
      body: const Center(
        child: Text(
          'DouserDashboardScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
