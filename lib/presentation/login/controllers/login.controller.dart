import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final box = GetStorage();

  void login() {
    if (emailController.text == 'admin@gmail.com') {
      box.write('adminemail', emailController.text);
      Get.offNamed(Routes.ADMIN_DASHBOARD);
    } else if (emailController.text == 'douser@gmail.com') {
      box.write('douseremail', emailController.text);
      Get.offNamed(Routes.DOUSER_DASHBOARD);
    } else if (emailController.text == 'general@gmail.com') {
      box.write('generalemail', emailController.text);
      Get.offNamed(Routes.GENUSER_DASHBOARD);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    emailController.dispose();
    passwordController.dispose();
  }
}
