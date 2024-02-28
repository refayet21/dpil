import 'package:get/get.dart';

import '../../../../presentation/genuser/dashboard/controllers/genuser_dashboard.controller.dart';

class GenuserDashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenuserDashboardController>(
      () => GenuserDashboardController(),
    );
  }
}
