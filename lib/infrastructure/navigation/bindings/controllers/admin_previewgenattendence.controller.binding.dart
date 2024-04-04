import 'package:get/get.dart';

import '../../../../presentation/admin/previewgenattendence/controllers/admin_previewgenattendence.controller.dart';

class AdminPreviewgenattendenceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPreviewgenattendenceController>(
      () => AdminPreviewgenattendenceController(),
    );
  }
}
