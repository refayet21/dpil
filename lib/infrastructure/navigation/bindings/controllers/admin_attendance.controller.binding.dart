import 'package:get/get.dart';

import '../../../../presentation/admin/attendance/controllers/admin_attendance.controller.dart';

class AdminAttendanceControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminAttendanceController>(
      () => AdminAttendanceController(),
    );
  }
}
