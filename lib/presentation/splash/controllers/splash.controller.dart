import 'dart:async';

import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final box = GetStorage();
  RxBool alreadyLoggedIn = false.obs;
  RxBool displaySplashImage = true.obs;
  static const int splashDurationSeconds = 5;
  @override
  void onInit() {
    super.onInit();
    checkLoggedIn();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void checkLoggedIn() {
    var adminemail = box.read('adminemail');
    var douseremail = box.read('douseremail');
    var generalemail = box.read('generalemail');

    Timer(
      Duration(seconds: splashDurationSeconds),
      () {
        if (adminemail != null && adminemail.isNotEmpty) {
          Get.offNamed(Routes.ADMIN_DASHBOARD);
        } else if (douseremail != null && douseremail.isNotEmpty) {
          Get.offNamed(Routes.DOUSER_DASHBOARD);
        } else if (generalemail != null && generalemail.isNotEmpty) {
          Get.offNamed(Routes.GENUSER_DASHBOARD);
        } else {
          Get.offNamed(Routes.LOGIN);
        }
      },
    );
  }
}
