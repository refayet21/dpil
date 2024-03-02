import 'package:get/get.dart';

import '../../../../presentation/douser/attendence/controllers/douser_attendence.controller.dart';

class DouserAttendenceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserAttendenceController>(
      () => DouserAttendenceController(),
    );
  }
}
