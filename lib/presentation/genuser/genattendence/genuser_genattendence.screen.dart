import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/genuser_genattendence.controller.dart';

class GenuserGenattendenceScreen
    extends GetView<GenuserGenattendenceController> {
  const GenuserGenattendenceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenuserGenattendenceScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GenuserGenattendenceScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
