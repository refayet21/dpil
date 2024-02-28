import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/admin_dashboard.controller.dart';

class AdminDashboardScreen extends GetView<AdminDashboardController> {
  const AdminDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminDashboardScreen'),
        centerTitle: true,
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
