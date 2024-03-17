import 'package:get/get.dart';

import '../../../../presentation/admin/previewattendance/controllers/admin_previewattendance.controller.dart';

class AdminPreviewattendanceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminPreviewattendanceController>(
      () => AdminPreviewattendanceController(),
    );
  }
}
