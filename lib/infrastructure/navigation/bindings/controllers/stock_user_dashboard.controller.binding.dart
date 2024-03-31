import 'package:get/get.dart';

import '../../../../presentation/stockUser/dashboard/controllers/stock_user_dashboard.controller.dart';

class StockUserDashboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockUserDashboardController>(
      () => StockUserDashboardController(),
    );
  }
}
