import 'package:get/get.dart';

import '../../../../presentation/admin/email/controllers/admin_email.controller.dart';

class AdminEmailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminEmailController>(
      () => AdminEmailController(),
    );
  }
}
