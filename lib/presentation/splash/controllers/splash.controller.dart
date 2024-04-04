import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  static const int splashDurationSeconds = 2;

  @override
  void onInit() {
    super.onInit();
    startDelayedFuture();
  }

  Future<void> startDelayedFuture() async {
    await Future.delayed(Duration(seconds: splashDurationSeconds));
    await checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    var adminemail = box.read('adminemail');
    var douseremail = box.read('douseremail');
    var generalemail = box.read('generalemail');
    var stockemail = box.read('stockemail');

    if (adminemail != null && adminemail.isNotEmpty) {
      Get.offNamed(Routes.ADMIN_DASHBOARD);
    } else if (douseremail != null && douseremail.isNotEmpty) {
      Get.offNamed(Routes.DOUSER_DASHBOARD);
    } else if (generalemail != null && generalemail.isNotEmpty) {
      Get.offNamed(Routes.GENUSER_DASHBOARD);
    } else if (stockemail != null && stockemail.isNotEmpty) {
      Get.offNamed(Routes.STOCK_USER_DASHBOARD);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
