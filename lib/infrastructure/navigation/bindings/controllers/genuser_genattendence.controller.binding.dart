import 'package:get/get.dart';

import '../../../../presentation/genuser/genattendence/controllers/genuser_genattendence.controller.dart';

class GenuserGenattendenceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenuserGenattendenceController>(
      () => GenuserGenattendenceController(),
    );
  }
}
