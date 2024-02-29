import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/admin_addvendor.controller.dart';

class AdminAddvendorScreen extends GetView<AdminAddvendorController> {
  AdminAddvendorScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text('DPIL'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminAddvendorScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
