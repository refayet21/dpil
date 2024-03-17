import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/product.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddproductController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      //   unitController,
      //    totalunitController,
      //   unitqtyController,
      //  rateController,
      stockController;
  RxList<ProductModel> foundProduct = RxList<ProductModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<ProductModel> Products = RxList<ProductModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    //   unitController = TextEditingController();
    //   totalunitController = TextEditingController();
    //   unitqtyController = TextEditingController();
    //  rateController = TextEditingController();
    stockController = TextEditingController();
    collectionReference = firebaseFirestore.collection("products");
    Products.bindStream(getAllProducts());
    foundProduct = Products;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "Name can not be empty";
    }
    return null;
  }

  String? validateunit(String value) {
    if (value.isEmpty) {
      return "unit can not be empty";
    }
    return null;
  }

  void saveUpdateProduct(
      ProductModel productModel, String docId, int addEditFlag) {
    final currentState = formKey.currentState;
    if (currentState == null) return;

    final isValid = currentState.validate();
    if (!isValid) return;

    currentState.save();

    final isAdding = addEditFlag == 1;
    final isUpdating = addEditFlag == 2;

    if (isAdding || isUpdating) {
      final dialogMessage = isAdding ? "Product Added" : "Product Updated";
      final successMessage = isAdding
          ? "Product added successfully"
          : "Product updated successfully";

      CustomFullScreenDialog.showDialog();

      Future<void> operation;
      if (isAdding) {
        operation = collectionReference.add(productModel.toJson());
      } else {
        operation =
            collectionReference.doc(docId).update(productModel.toJson());
      }

      operation.then((_) {
        CustomFullScreenDialog.cancelDialog();
        clearEditingControllers();
        Get.back();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: dialogMessage,
          message: successMessage,
          backgroundColor: Colors.green,
        );
      }).catchError((error) {
        CustomFullScreenDialog.cancelDialog();
        CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong: $error",
          backgroundColor: Colors.red,
        );
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
    //   unitController.dispose();
    //   totalunitController.dispose();
    //   unitqtyController.dispose();
    //  rateController.dispose();
    stockController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    //   unitController.clear();
    //      totalunitController.clear();
    //   unitqtyController.clear();
    //  rateController.clear();
    stockController.clear();
  }

  Stream<List<ProductModel>> getAllProducts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromJson(item)).toList());

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Product Deleted",
          message: "Product deleted successfully",
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

  void searchProduct(String searchQuery) {
    if (searchQuery.isEmpty) {
      foundProduct.assignAll(Products.toList());
    } else {
      List<ProductModel> results = Products.where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      foundProduct.assignAll(results);
    }
  }
}
