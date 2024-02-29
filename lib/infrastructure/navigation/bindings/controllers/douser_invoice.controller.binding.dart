import 'package:get/get.dart';

import '../../../../presentation/douser/invoice/controllers/douser_invoice.controller.dart';

class DouserInvoiceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserInvoiceController>(
      () => DouserInvoiceController(),
    );
  }
}
