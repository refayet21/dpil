import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/product.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DouserProductcartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<ProductModel> cartItems = RxList<ProductModel>([]);
  AdminAddvendorController vendorAddController =
      Get.put(AdminAddvendorController());
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  late CollectionReference collectionReference;
  RxList<ProductModel> productModel = RxList<ProductModel>([]);
  var quantity = 0.obs;

  Stream<List<ProductModel>> getAllVendors() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    print('oninit called');
    collectionReference = firebaseFirestore.collection("products");
    productModel.bindStream(getAllVendors());
    vendors = vendorAddController.vendors;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addToCart(ProductModel product) {
    bool alreadyInCart = cartItems.any((item) => item.docId == product.docId);

    if (!alreadyInCart) {
      cartItems.add(product);
    } else {
      print('Product is already in the cart');
    }
  }

  bool isProductInCart(ProductModel product) {
    return cartItems.any((item) => item.docId == product.docId);
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
  }

  void increaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1) {
      cartItems[index].quantity++;
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      cartItems.remove(product);
    }
  }

  void updateQuantity(ProductModel product, int newQuantity) {
    final index = cartItems.indexWhere((item) => item.docId == product.docId);
    if (index != -1) {
      if (newQuantity > 0) {
        cartItems[index].quantity = newQuantity;
      } else {
        cartItems.remove(product);
      }
    }
  }

  selectdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      // print(formattedDate);

      // dateinput.text = formattedDate;
      return formattedDate;
    }
  }

  // add purchase product

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<void> addPurchaseData({
  //   String? vendorDocId,
  //   required String date,
  //   required List<Map<String, dynamic>> cartItems,
  // }) async {
  //   try {
  //     CollectionReference purchasesCollection =
  //         _firestore.collection('purchases');

  //     // Add a new document with a generated ID
  //     await purchasesCollection.add({
  //       'vendorDocId': vendorDocId,
  //       'date': date,
  //       'cartItems': cartItems,
  //     });

  //     print('Purchase data added to Firestore');
  //   } catch (e) {
  //     print('Error adding purchase data: $e');
  //   }
  // }

  // Future<void> addPurchaseData({
  //   String? vendorDocId,
  //   required String date,
  //   required List<Map<String, dynamic>> cartItems,
  //   String? purchaseInfo, // Add this parameter
  // }) async {
  //   try {
  //     CollectionReference purchasesCollection =
  //         _firestore.collection('purchases');

  //     // Add a new document with a generated ID
  //     await purchasesCollection.add({
  //       'vendorDocId': vendorDocId,
  //       'date': date,
  //       'cartItems': cartItems,
  //       'purchaseInfo': purchaseInfo, // Add purchaseInfo to the document
  //     });

  //     print('Purchase data added to Firestore');
  //   } catch (e) {
  //     print('Error adding purchase data: $e');
  //   }
  // }

  Future<void> addPurchaseData({
    String? vendorDocId,
    required String date,
    required List<Map<String, dynamic>> cartItems,
  }) async {
    try {
      CollectionReference purchasesCollection =
          _firestore.collection('purchases');

      // Add a new document with a generated ID
      await purchasesCollection.add({
        'vendorDocId': vendorDocId,
        'date': date,
        'cartItems': cartItems,
      });

      print('Purchase data added to Firestore');
    } catch (e) {
      print('Error adding purchase data: $e');
    }
  }
}
