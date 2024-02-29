import 'package:get/get.dart';

import '../../../../presentation/admin/addproduct/controllers/admin_addproduct.controller.dart';

class AdminAddproductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAddproductController>(
      () => AdminAddproductController(),
    );
  }
}
