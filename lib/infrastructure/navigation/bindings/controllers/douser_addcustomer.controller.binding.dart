import 'package:get/get.dart';

import '../../../../presentation/douser/addcustomer/controllers/douser_addcustomer.controller.dart';

class DouserAddcustomerControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserAddcustomerController>(
      () => DouserAddcustomerController(),
    );
  }
}
