import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final box = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // void login() {
  //   if (emailController.text == 'admin@gmail.com') {
  //     box.write('adminemail', emailController.text);
  //     Get.offNamed(Routes.ADMIN_DASHBOARD);
  //   } else if (emailController.text == 'douser@gmail.com') {
  //     box.write('douseremail', emailController.text);
  //     Get.offNamed(Routes.DOUSER_DASHBOARD);
  //   } else if (emailController.text == 'general@gmail.com') {
  //     box.write('generalemail', emailController.text);
  //     Get.offNamed(Routes.GENUSER_DASHBOARD);
  //   }
  // }
  var isLoading = false.obs; // Observable to track loading state

  Future<User?> login(String email, String password) async {
    try {
      isLoading.value = true; // Set loading state to true

      bool isAdmin = await checkAdminAuthentication(email, password);

      if (isAdmin) {
        // Admin user authenticated via Firebase Authentication
        box.write('adminemail', email);
        Get.offNamed(Routes.ADMIN_DASHBOARD);
        return null; // No need to return User object for admin
      } else {
        // Check if the user exists in other collections
        bool isDoUser = await checkUserCredentials('do_users', email, password);
        bool isGeneralUser =
            await checkUserCredentials('general_users', email, password);

        if (isDoUser) {
          // DoUser, redirect to DoUser dashboard
          box.write('douseremail', email);
          Get.offNamed(Routes.DOUSER_DASHBOARD);
          // Get.offNamed(Routes.DOUSER_INVOICE);
          return null; // No need to return User object for DoUser
        } else if (isGeneralUser) {
          // General user, redirect to General user dashboard
          box.write('generalemail', email);
          Get.offNamed(Routes.GENUSER_DASHBOARD);
          return null; // No need to return User object for General user
        } else {
          // User not found in any collection
          Get.snackbar(
            'Error',
            'User does not exist.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: Icon(Icons.error),
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    } catch (e) {
      // Handle any unexpected errors
      print('Error: $e');
    } finally {
      isLoading.value =
          false; // Set loading state to false after login process completes
    }

    return null;
  }

  Future<bool> checkAdminAuthentication(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user != null;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkUserCredentials(
      String collection, String email, String password) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
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
