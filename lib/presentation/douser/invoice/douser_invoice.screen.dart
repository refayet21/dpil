import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_invoice.controller.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  const DouserInvoiceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DouserInvoiceScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DouserInvoiceScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
