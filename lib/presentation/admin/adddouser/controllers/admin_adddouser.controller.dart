import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAdddouserController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  late String oldPassword;

  late TextEditingController nameController,
      addressController,
      mobileController,
      emailController,
      passwordController;
  RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  // RxList<DoUserModel> dousers = RxList<DoUserModel>([]);
  RxList<DoUserModel> dousers = RxList<DoUserModel>([]);
  Stream<List<DoUserModel>> getAlldoUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => DoUserModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    collectionReference = firebaseFirestore.collection("do_users");
    // dousers.bindStream(getAlldoUsers());
    // founddouser = dousers;
    getAlldoUsers().listen((douser) {
      dousers.assignAll(douser);
      founddouser.assignAll(douser);

      // Print foundProduct after it's assigned
      // print(foundProduct);
    });
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
    String email,
    String password,
    String? docId,
    int? addEditFlag,
  ) async {
    try {
      if (addEditFlag == 1) {
        CustomFullScreenDialog.showDialog();
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await collectionReference.add({
          'name': name,
          'address': address,
          'mobile': mobile,
          'email': email,
          'password': password,
        });
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Do User Added",
          message: "Do User added successfully",
          backgroundColor: Colors.green,
        );
      } else if (addEditFlag == 2) {
        //update
        CustomFullScreenDialog.showDialog();

        // var cred =
        //     EmailAuthProvider.credential(email: email, password: oldPassword);
        // await currentUser!.reauthenticateWithCredential(cred);
        // await currentUser!.updatePassword(password);
        // print('oldPassword is $oldPassword new password is $password');

        await collectionReference.doc(docId).update({
          'name': name,
          'address': address,
          'mobile': mobile,
          'email': email,
          'password': password,
        });
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Do User Updated",
          message: "Do User updated successfully",
          backgroundColor: Colors.green,
        );
      }
    } catch (error) {
      print('error is $error');
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
        context: Get.context,
        title: "Error",
        message: "Something went wrong: $error",
        backgroundColor: Colors.red,
      );
    }
  }

  // void saveUpdatedoUsers(
  //   String? name,
  //   String? address,
  //   String? mobile,
  //   String email,
  //   String password,
  //   String? docId,
  //   int? addEditFlag,
  // ) async {
  //   final isValid = formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   formKey.currentState!.save();

  //   if (addEditFlag == 1) {
  //     // Create new user
  //     CustomFullScreenDialog.showDialog();
  //     try {
  //       await _auth.createUserWithEmailAndPassword(
  //         email: email,
  //         password: password,
  //       );

  //       // Add user info to Firestore
  //       await collectionReference.add({
  //         'name': name,
  //         'address': address,
  //         'mobile': mobile,
  //         'email': email,
  //       });

  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Do User Added",
  //         message: "Do User added successfully",
  //         backgroundColor: Colors.green,
  //       );
  //     } catch (error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: error.toString(),
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   } else if (addEditFlag == 2) {
  //     // Update existing user
  //     CustomFullScreenDialog.showDialog();
  //     try {
  //       // Update authentication email if necessary
  //       currentUser user = _auth.currentUser!;
  //       if (user.email != email) {
  //         await user.updateEmail(email);
  //       }

  //       // Update authentication password if necessary
  //       if (password.isNotEmpty) {
  //         await user.updatePassword(password);
  //       }

  //       // Update user info in Firestore
  //       await collectionReference.doc(docId).update({
  //         'name': name,
  //         'address': address,
  //         'mobile': mobile,
  //         'email': email,
  //       });

  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Do User Updated",
  //         message: "Do User updated successfully",
  //         backgroundColor: Colors.green,
  //       );
  //     } catch (error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: error.toString(),
  //         backgroundColor: Colors.red,
  //       );
  //     }
  //   }
  // }

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

  // Stream<List<DoUserModel>> getAlldoUsers() =>
  //     collectionReference.snapshots().map((query) =>
  //         query.docs.map((item) => DoUserModel.fromJson(item)).toList());

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

  // void searchdouser(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     founddouser.assignAll(dousers.toList());
  //   } else {
  //     List<DoUserModel> results = dousers
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     founddouser.assignAll(results);
  //   }
  // }

  void searchdouser(String searchQuery) {
    List<DoUserModel> results;
    if (searchQuery.isEmpty) {
      results = dousers;
    } else {
      results = dousers
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    founddouser.value = results;
  }
}
