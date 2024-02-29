import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_invoicepreview.controller.dart';

class DouserInvoicepreviewScreen
    extends GetView<DouserInvoicepreviewController> {
  const DouserInvoicepreviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DouserInvoicepreviewScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DouserInvoicepreviewScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
