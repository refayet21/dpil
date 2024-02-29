import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAdddouserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      addressController,
      mobileController,
      emailController,
      passwordController;
  RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<DoUserModel> dousers = RxList<DoUserModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("do_users");
    dousers.bindStream(getAlldoUsers());
    founddouser = dousers;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name can not be empty";
    }
    return null;
  }

  String? validateaddress(String value) {
    if (value.isEmpty) {
      return "address can not be empty";
    }
    return null;
  }

  String? validatemobile(String value) {
    if (value.isEmpty) {
      return "mobile can not be empty";
    }
    return null;
  }

  void saveUpdatedoUsers(
    String? name,
    String? address,
    String? mobile,
    String? email,
    String? password,
    String? docId,
    int? addEditFlag,
  ) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    formKey.currentState!.save();
    if (addEditFlag == 1) {
      CustomFullScreenDialog.showDialog();
      collectionReference.add({
        'name': name,
        'address': address,
        'mobile': mobile,
        'email': email,
        'password': password,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Do User Added",
            message: "Do User added successfully",
            backgroundColor: Colors.green);
        // ignore: body_might_complete_normally_catch_error
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.green);
      });
    } else if (addEditFlag == 2) {
      //update
      CustomFullScreenDialog.showDialog();
      collectionReference.doc(docId).update({
        'name': name,
        'address': address,
        'mobile': mobile,
        'email': email,
        'password': password,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Do User Updated",
            message: "Do User updated successfully",
            backgroundColor: Colors.green);
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Error",
            message: "Something went wrong",
            backgroundColor: Colors.red);
      });
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    addressController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
    mobileController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Stream<List<DoUserModel>> getAlldoUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => DoUserModel.fromJson(item)).toList());

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Do User Deleted",
          message: "Do User deleted successfully",
          backgroundColor: Colors.green);
    }).catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }

  void searchdouser(String searchQuery) {
    if (searchQuery.isEmpty) {
      founddouser.assignAll(dousers.toList());
    } else {
      List<DoUserModel> results = dousers
          .where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      founddouser.assignAll(results);
    }
  }
}
