import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/email_model.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminEmailController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController toController,
      ccController,
      subjectController,
      bodyController;
  RxList<EmailModel> foundVendor = RxList<EmailModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<EmailModel> vendors = RxList<EmailModel>([]);

  @override
  void onInit() {
    super.onInit();
    toController = TextEditingController();
    ccController = TextEditingController();
    subjectController = TextEditingController();
    bodyController = TextEditingController();
    collectionReference = firebaseFirestore.collection("email");
    vendors.bindStream(getAllVendors());
    foundVendor = vendors;
  }

  String? validateto(String value) {
    if (value.isEmpty) {
      return "to can not be empty";
    }
    return null;
  }

  String? validatecc(String value) {
    if (value.isEmpty) {
      return "cc can not be empty";
    }
    return null;
  }

  String? validatebody(String value) {
    if (value.isEmpty) {
      return "body can not be empty";
    }
    return null;
  }

  void saveUpdateVendor(
    String? to,
    String? cc,
    String? subject,
    String? body,
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
        'to': to,
        'cc': cc,
        'subject': subject,
        'body': body,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Email Added",
            message: "Email added successfully",
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
        'to': to,
        'cc': cc,
        'subject': subject,
        'body': body,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Email Updated",
            message: "Email updated successfully",
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
    toController.dispose();
    ccController.dispose();
    subjectController.dispose();
    bodyController.dispose();
  }

  void clearEditingControllers() {
    toController.clear();
    ccController.clear();
    subjectController.clear();
    bodyController.clear();
  }

  Stream<List<EmailModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => EmailModel.fromJson(item)).toList());

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Email Deleted",
          message: "Email deleted successfully",
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

  void searchVendor(String searchQuery) {
    if (searchQuery.isEmpty) {
      foundVendor.assignAll(vendors.toList());
    } else {
      List<EmailModel> results = vendors
          .where((element) =>
              element.to!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      foundVendor.assignAll(results);
    }
  }
}
