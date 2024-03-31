import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/stock_user_dashboard.controller.dart';

class StockUserDashboardScreen extends GetView<StockUserDashboardController> {
  const StockUserDashboardScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StockUserDashboardScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StockUserDashboardScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
