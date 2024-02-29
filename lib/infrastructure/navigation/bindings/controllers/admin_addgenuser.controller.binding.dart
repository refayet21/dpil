import 'package:get/get.dart';

import '../../../../presentation/admin/addgenuser/controllers/admin_addgenuser.controller.dart';

class AdminAddgenuserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddgenuserController>(
      () => AdminAddgenuserController(),
    );
  }
}
