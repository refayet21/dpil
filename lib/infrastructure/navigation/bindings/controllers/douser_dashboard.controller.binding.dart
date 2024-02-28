import 'package:get/get.dart';

import '../../../../presentation/douser/dashboard/controllers/douser_dashboard.controller.dart';

class DouserDashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DouserDashboardController>(
      () => DouserDashboardController(),
    );
  }
}
