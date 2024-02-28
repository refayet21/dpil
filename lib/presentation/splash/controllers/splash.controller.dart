import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  static const int splashDurationSeconds = 3;

  @override
  void onInit() {
    super.onInit();
    print('oninit called');
    // Start the delayed Future after the controller initializes
    startDelayedFuture();
  }

  Future<void> startDelayedFuture() async {
    // Delay execution using Future.delayed
    await Future.delayed(Duration(seconds: splashDurationSeconds));
    // After the delay, call checkLoggedIn() to handle navigation
    await checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    var adminemail = box.read('adminemail');
    var douseremail = box.read('douseremail');
    var generalemail = box.read('generalemail');

    if (adminemail != null && adminemail.isNotEmpty) {
      print('Admin called');
      Get.offNamed(Routes.ADMIN_DASHBOARD);
    } else if (douseremail != null && douseremail.isNotEmpty) {
      print('douseremail called');
      Get.offNamed(Routes.DOUSER_DASHBOARD);
    } else if (generalemail != null && generalemail.isNotEmpty) {
      print('generalemail called');
      Get.offNamed(Routes.GENUSER_DASHBOARD);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
