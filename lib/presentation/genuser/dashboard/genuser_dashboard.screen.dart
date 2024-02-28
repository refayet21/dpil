import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/genuser_dashboard.controller.dart';

class GenuserDashboardScreen extends GetView<GenuserDashboardController> {
  const GenuserDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenuserDashboardScreen'),
        centerTitle: true,
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
