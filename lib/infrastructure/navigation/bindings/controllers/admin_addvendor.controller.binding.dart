import 'package:get/get.dart';

import '../../../../presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';

class AdminAddvendorControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddvendorController>(
      () => AdminAddvendorController(),
    );
  }
}
