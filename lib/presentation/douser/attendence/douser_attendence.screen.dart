import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_attendence.controller.dart';

class DouserAttendenceScreen extends GetView<DouserAttendenceController> {
  const DouserAttendenceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: const Text('DouserAttendenceScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DouserAttendenceScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
