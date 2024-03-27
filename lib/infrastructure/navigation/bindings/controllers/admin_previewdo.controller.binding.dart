import 'package:get/get.dart';

import '../../../../presentation/admin/previewdo/controllers/admin_previewdo.controller.dart';

class AdminPreviewdoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPreviewdoController>(
      () => AdminPreviewdoController(),
    );
  }
}
