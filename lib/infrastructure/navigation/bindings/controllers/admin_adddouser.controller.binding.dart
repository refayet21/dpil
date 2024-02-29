import 'package:get/get.dart';

import '../../../../presentation/admin/adddouser/controllers/admin_adddouser.controller.dart';

class AdminAdddouserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAdddouserController>(
      () => AdminAdddouserController(),
    );
  }
}
