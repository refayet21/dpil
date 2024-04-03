import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/general_user_model.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddgenuserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      addressController,
      mobileController,
      emailController,
      passwordController;

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<GeneralUserModel> generalusers = RxList<GeneralUserModel>([]);
  RxList<GeneralUserModel> foundgeneraluser = RxList<GeneralUserModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("general_users");
    // generalusers.bindStream(getAllgeneralUsers());
    // foundgeneraluser = generalusers;
    getAllgeneralUsers().listen((genuser) {
      generalusers.assignAll(genuser);
      foundgeneraluser.assignAll(genuser);

      // Print foundProduct after it's assigned
      // print(foundProduct);
    });
  }

  Stream<List<GeneralUserModel>> getAllgeneralUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => GeneralUserModel.fromJson(item)).toList());

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

  void saveUpdategeneralUsers(
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
            title: "General User Added",
            message: "General User added successfully",
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
            title: "General User Updated",
            message: "General User updated successfully",
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

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "General User Deleted",
          message: "General User deleted successfully",
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

  // void searchgeneraluser(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     foundgeneraluser.assignAll(generalusers.toList());
  //   } else {
  //     List<GeneralUserModel> results = generalusers
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     foundgeneraluser.assignAll(results);
  //   }
  // }

  void searchgeneraluser(String searchQuery) {
    List<GeneralUserModel> results;
    if (searchQuery.isEmpty) {
      results = generalusers;
    } else {
      results = generalusers
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    foundgeneraluser.value = results;
  }
}
