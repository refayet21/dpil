import 'package:get/get.dart';

import '../../../../presentation/douser/addproduct/controllers/douser_addproduct.controller.dart';

class DouserAddproductControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserAddproductController>(
      () => DouserAddproductController(),
    );
  }
}
