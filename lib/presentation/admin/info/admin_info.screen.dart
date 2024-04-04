import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/admin_info.controller.dart';

class AdminInfoScreen extends GetView<AdminInfoController> {
  const AdminInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminInfoScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminInfoScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
