import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_dashboard.controller.dart';

class DouserDashboardScreen extends GetView<DouserDashboardController> {
  const DouserDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DouserDashboardScreen'),
        centerTitle: true,
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
