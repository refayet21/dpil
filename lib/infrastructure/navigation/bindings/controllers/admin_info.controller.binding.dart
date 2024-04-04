import 'package:get/get.dart';

import '../../../../presentation/admin/info/controllers/admin_info.controller.dart';

class AdminInfoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminInfoController>(
      () => AdminInfoController(),
    );
  }
}
