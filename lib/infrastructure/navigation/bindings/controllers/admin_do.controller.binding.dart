import 'package:get/get.dart';

import '../../../../presentation/admin/do/controllers/admin_do.controller.dart';

class AdminDoControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDoController>(
      () => AdminDoController(),
    );
  }
}
