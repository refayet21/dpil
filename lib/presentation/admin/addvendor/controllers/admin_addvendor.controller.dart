import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddvendorController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      addressController,
      contactpersonController,
      mobileController;
  RxList<VendorModel> foundVendor = RxList<VendorModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<VendorModel> vendors = RxList<VendorModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    addressController = TextEditingController();
    contactpersonController = TextEditingController();
    mobileController = TextEditingController();
    collectionReference = firebaseFirestore.collection("Vendors");
    vendors.bindStream(getAllVendors());
    foundVendor = vendors;
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

  void saveUpdateVendor(
    String? name,
    String? address,
    String? contactperson,
    String? mobile,
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
        'contactperson': contactperson,
        'mobile': mobile,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Vendor Added",
            message: "Vendor added successfully",
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
        'contactperson': contactperson,
        'mobile': mobile,
      }).whenComplete(() {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
            context: Get.context,
            title: "Vendor Updated",
            message: "Vendor updated successfully",
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
    contactpersonController.dispose();
    mobileController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    addressController.clear();
    contactpersonController.clear();
    mobileController.clear();
  }

  Stream<List<VendorModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => VendorModel.fromJson(item)).toList());

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Vendor Deleted",
          message: "Vendor deleted successfully",
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
      List<VendorModel> results = vendors
          .where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      foundVendor.assignAll(results);
    }
  }
}
