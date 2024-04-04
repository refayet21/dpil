import 'package:get/get.dart';

import '../../../../presentation/admin/genattendence/controllers/admin_genattendence.controller.dart';

class AdminGenattendenceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminGenattendenceController>(
      () => AdminGenattendenceController(),
    );
  }
}
