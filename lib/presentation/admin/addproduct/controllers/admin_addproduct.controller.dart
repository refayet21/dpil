// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dpil/model/product.dart';
// import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
// import 'package:dpil/presentation/widgets/customSnackBar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminAddproductController extends GetxController {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   late TextEditingController nameController,
//       categoryController,

//       stockController;
//   RxList<ProductModel> foundProduct = RxList<ProductModel>([]);

//   // Firestore operation
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//   late CollectionReference collectionReference;

//   RxList<ProductModel> Products = RxList<ProductModel>([]);

//   @override
//   void onInit() {
//     super.onInit();
//     nameController = TextEditingController();
//     categoryController = TextEditingController();

//     stockController = TextEditingController();
//     collectionReference = firebaseFirestore.collection("products");
//     Products.bindStream(getAllProducts());
//     foundProduct = Products;
//   }

//   String? validateName(String value) {
//     if (value.isEmpty) {
//       return "Name can not be empty";
//     }
//     return null;
//   }

//   String? validatecategory(String value) {
//     if (value.isEmpty) {
//       return "category can not be empty";
//     }
//     return null;
//   }
//   // void saveUpdateProduct(
//   //     ProductModel productModel, String docId, int addEditFlag) {
//   //   final currentState = formKey.currentState;
//   //   if (currentState == null) return;

//   //   final isValid = currentState.validate();
//   //   if (!isValid) return;

//   //   currentState.save();

//   //   final isAdding = addEditFlag == 1;
//   //   final isUpdating = addEditFlag == 2;

//   //   if (isAdding || isUpdating) {
//   //     final dialogMessage = isAdding ? "Product Added" : "Product Updated";
//   //     final successMessage = isAdding
//   //         ? "Product added successfully"
//   //         : "Product updated successfully";

//   //     CustomFullScreenDialog.showDialog();

//   //     Future<void> operation;
//   //     if (isAdding) {
//   //       operation = collectionReference.add(productModel.toJson());
//   //     } else {
//   //       operation =
//   //           collectionReference.doc(docId).update(productModel.toJson());
//   //     }

//   //     operation.then((_) {
//   //       CustomFullScreenDialog.cancelDialog();
//   //       clearEditingControllers();
//   //       Get.back();
//   //       CustomSnackBar.showSnackBar(
//   //         context: Get.context,
//   //         title: dialogMessage,
//   //         message: successMessage,
//   //         backgroundColor: Colors.green,
//   //       );
//   //     }).catchError((error) {
//   //       CustomFullScreenDialog.cancelDialog();
//   //       CustomSnackBar.showSnackBar(
//   //         context: Get.context,
//   //         title: "Error",
//   //         message: "Something went wrong: $error",
//   //         backgroundColor: Colors.red,
//   //       );
//   //     });
//   //   }
//   // }

//   void saveUpdateProduct(
//       ProductModel productModel, String docId, int addEditFlag) {
//     final currentState = formKey.currentState;
//     if (currentState == null) return;

//     final isValid = currentState.validate();
//     if (!isValid) return;

//     currentState.save();

//     final isAdding = addEditFlag == 1;
//     final isUpdating = addEditFlag == 2;

//     if (isAdding || isUpdating) {
//       final dialogMessage = isAdding ? "Product Added" : "Product Updated";
//       final successMessage = isAdding
//           ? "Product added successfully"
//           : "Product updated successfully";

//       CustomFullScreenDialog.showDialog();

//       Future<void> operation;
//       if (isAdding) {
//         // For adding, simply add the new product
//         operation = collectionReference.add(productModel.toJson());
//       } else {
//         // For updating, fetch the current document and update its stock value
//         operation = collectionReference.doc(docId).get().then((docSnapshot) {
//           if (docSnapshot.exists) {
//             // Fetch previous stock value
//             final data = docSnapshot.data()
//                 as Map<String, dynamic>?; // Cast to Map<String, dynamic>
//             int previousStock = data?['stock'] as int? ?? 0;
//             // Calculate new stock value
//             int newStock = previousStock + (productModel.stock ?? 0);
//             // Update the stock value in the productModel
//             productModel.stock = newStock;
//             // Update the document with the updated productModel
//             return collectionReference.doc(docId).update(productModel.toJson());
//           } else {
//             // Handle case where document doesn't exist
//             return Future.error("Document does not exist");
//           }
//         });
//       }

//       operation.then((_) {
//         CustomFullScreenDialog.cancelDialog();
//         clearEditingControllers();
//         Get.back();
//         CustomSnackBar.showSnackBar(
//           context: Get.context,
//           title: dialogMessage,
//           message: successMessage,
//           backgroundColor: Colors.green,
//         );
//       }).catchError((error) {
//         CustomFullScreenDialog.cancelDialog();
//         CustomSnackBar.showSnackBar(
//           context: Get.context,
//           title: "Error",
//           message: "Something went wrong: $error",
//           backgroundColor: Colors.red,
//         );
//       });
//     }
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     nameController.dispose();
//     categoryController.dispose();
//     //   totalcategoryController.dispose();
//     //   categoryqtyController.dispose();
//     //  rateController.dispose();
//     stockController.dispose();
//   }

//   void clearEditingControllers() {
//     nameController.clear();
//     categoryController.clear();
//     //      totalcategoryController.clear();
//     //   categoryqtyController.clear();
//     //  rateController.clear();
//     stockController.clear();
//   }

//   Stream<List<ProductModel>> getAllProducts() =>
//       collectionReference.snapshots().map((query) =>
//           query.docs.map((item) => ProductModel.fromJson(item)).toList());

//   void deleteData(String docId) {
//     CustomFullScreenDialog.showDialog();
//     collectionReference.doc(docId).delete().whenComplete(() {
//       CustomFullScreenDialog.cancelDialog();
//       Get.back();
//       CustomSnackBar.showSnackBar(
//           context: Get.context,
//           title: "Product Deleted",
//           message: "Product deleted successfully",
//           backgroundColor: Colors.green);
//     }).catchError((error) {
//       CustomFullScreenDialog.cancelDialog();
//       CustomSnackBar.showSnackBar(
//           context: Get.context,
//           title: "Error",
//           message: "Something went wrong",
//           backgroundColor: Colors.red);
//     });
//   }

//   void searchProduct(String searchQuery) {
//     if (searchQuery.isEmpty) {
//       foundProduct.assignAll(Products.toList());
//     } else {
//       List<ProductModel> results = Products.where((element) =>
//               element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
//           .toList();
//       foundProduct.assignAll(results);
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/product.dart';
import 'package:dpil/presentation/widgets/customFullScreenDialog.dart';
import 'package:dpil/presentation/widgets/customSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminAddproductController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      categoryController,
      checkinController,
      checkoutController,
      bookedController;
  RxList<ProductModel> foundProduct = RxList<ProductModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<ProductModel> Products = RxList<ProductModel>([]);

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    categoryController = TextEditingController();

    checkinController = TextEditingController();
    checkoutController = TextEditingController();
    bookedController = TextEditingController();
    collectionReference = firebaseFirestore.collection("products");
    // Products.bindStream(getAllProducts());
    // foundProduct = Products;
    getAllProducts().listen((products) {
      Products.assignAll(products);
      foundProduct.assignAll(Products);

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

  String? validatecategory(String value) {
    if (value.isEmpty) {
      return "category can not be empty";
    }
    return null;
  }

  // void saveUpdateProduct(
  //     ProductModel productModel, String docId, int addEditFlag) {
  //   final currentState = formKey.currentState;
  //   if (currentState == null) return;

  //   final isValid = currentState.validate();
  //   if (!isValid) return;

  //   currentState.save();

  //   final isAdding = addEditFlag == 1;
  //   final isUpdating = addEditFlag == 2;

  //   if (isAdding || isUpdating) {
  //     final dialogMessage = isAdding ? "Product Added" : "Product Updated";
  //     final successMessage = isAdding
  //         ? "Product added successfully"
  //         : "Product updated successfully";

  //     CustomFullScreenDialog.showDialog();

  //     Future<void> operation;
  //     if (isAdding) {
  //       // For adding, simply add the new product
  //       operation = collectionReference.add(productModel.toJson());
  //     } else {
  //       // For updating, fetch the current document and update its stock value
  //       operation = collectionReference.doc(docId).get().then((docSnapshot) {
  //         if (docSnapshot.exists) {
  //           // Fetch previous stock value
  //           final data = docSnapshot.data()
  //               as Map<String, dynamic>?; // Cast to Map<String, dynamic>
  //           int previousStock = data?['stock'] as int? ?? 0;
  //           // Calculate new stock value
  //           int newStock = previousStock + (productModel.stock ?? 0);
  //           // Update the stock value in the productModel
  //           productModel.stock = newStock;
  //           // Update the document with the updated productModel
  //           return collectionReference.doc(docId).update(productModel.toJson());
  //         } else {
  //           // Handle case where document doesn't exist
  //           return Future.error("Document does not exist");
  //         }
  //       });
  //     }

  //     operation.then((_) {
  //       CustomFullScreenDialog.cancelDialog();
  //       clearEditingControllers();
  //       Get.back();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: dialogMessage,
  //         message: successMessage,
  //         backgroundColor: Colors.green,
  //       );
  //     }).catchError((error) {
  //       CustomFullScreenDialog.cancelDialog();
  //       CustomSnackBar.showSnackBar(
  //         context: Get.context,
  //         title: "Error",
  //         message: "Something went wrong: $error",
  //         backgroundColor: Colors.red,
  //       );
  //     });
  //   }
  // }

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
    categoryController.dispose();

    checkinController.dispose();
    checkoutController.dispose();
    bookedController.dispose();
  }

  void clearEditingControllers() {
    nameController.clear();
    categoryController.clear();

    checkinController.clear();
    checkoutController.clear();
    bookedController.clear();
  }

  Stream<List<ProductModel>> getAllProducts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromJson(item)).toList());

  Stream<Map<String, List<ProductModel>>> getAllProductsGroupedByCategory() =>
      collectionReference.snapshots().map((query) {
        Map<String, List<ProductModel>> groupedProducts = {};
        query.docs.forEach((doc) {
          ProductModel product = ProductModel.fromJson(doc);
          String category = product.category ?? "Other";
          if (!groupedProducts.containsKey(category)) {
            groupedProducts[category] = [];
          }
          groupedProducts[category]!.add(product);
        });
        return groupedProducts;
      });

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

  // void searchProduct(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     foundProduct.assignAll(Products.toList());
  //   } else {
  //     List<ProductModel> results = Products.where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     foundProduct.assignAll(results);
  //   }
  // }
  void searchProduct(String productName) {
    List<ProductModel> results;
    if (productName.isEmpty) {
      results = Products;
    } else {
      results = Products.where((element) => element.name
          .toString()
          .toLowerCase()
          .contains(productName.toLowerCase())).toList();
    }
    foundProduct.value = results;
  }
}
