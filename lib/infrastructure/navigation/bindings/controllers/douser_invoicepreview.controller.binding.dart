import 'package:get/get.dart';

import '../../../../presentation/douser/invoicepreview/controllers/douser_invoicepreview.controller.dart';

class DouserInvoicepreviewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserInvoicepreviewController>(
      () => DouserInvoicepreviewController(),
    );
  }
}
