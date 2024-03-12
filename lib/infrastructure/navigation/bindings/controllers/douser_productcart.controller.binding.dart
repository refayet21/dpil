import 'package:get/get.dart';

import '../../../../presentation/douser/productcart/controllers/douser_productcart.controller.dart';

class DouserProductcartControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserProductcartController>(
      () => DouserProductcartController(),
    );
  }
}
