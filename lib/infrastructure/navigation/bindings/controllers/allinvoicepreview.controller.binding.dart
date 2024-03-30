import 'package:get/get.dart';

import '../../../../presentation/allinvoicepreview/controllers/allinvoicepreview.controller.dart';

class AllinvoicepreviewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllinvoicepreviewController>(
      () => AllinvoicepreviewController(),
    );
  }
}
