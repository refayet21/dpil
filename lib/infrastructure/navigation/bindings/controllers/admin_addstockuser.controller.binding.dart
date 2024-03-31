import 'package:get/get.dart';

import '../../../../presentation/admin/addstockuser/controllers/admin_addstockuser.controller.dart';

class AdminAddstockuserControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddstockuserController>(
      () => AdminAddstockuserController(),
    );
  }
}
