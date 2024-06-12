import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/do_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/do_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DouserInvoiceController extends GetxController {
  final box = GetStorage();
  RxBool isSendingEmail = false.obs;
  RxList<Map<String, dynamic>> dousers = RxList<Map<String, dynamic>>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Add observables for start and end dates
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    getUserDo();
  }

  Future<void> getUserDo() async {
    final QuerySnapshot<Map<String, dynamic>> questionsQuery =
        await FirebaseFirestore.instance
            .collection("do_users")
            .doc(box.read('employeeId'))
            .collection('deliveryOrders')
            .get();
    dousers.value = questionsQuery.docs.map((doc) => doc.data()).toList();
  }

  // Method to filter delivery orders based on start and end dates
  List<Map<String, dynamic>> getFilteredDousers() {
    if (startDate.value == null && endDate.value == null) {
      return dousers;
    }

    return dousers.where((douser) {
      DateTime orderDate = DateFormat('dd-MM-yyyy').parse(douser['date']);
      if (startDate.value != null && orderDate.isBefore(startDate.value!)) {
        return false;
      }
      if (endDate.value != null && orderDate.isAfter(endDate.value!)) {
        return false;
      }
      return true;
    }).toList();
  }

  Future<bool> removepreviousBooking(List<dynamic> data) async {
    isSendingEmail.value = true;
    // print('removepreviousBooking  ia called');
    // print('inputData ia $data');

    List<List<dynamic>> itemList = data
        .map((item) => item['items'] as List<dynamic>)
        .where((items) => items[1] != 'Total')
        .toList();

    // print('removepreviousBooking inputData ia $itemList');
    try {
      // Initialize collection reference
      final CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("products");

      // Iterate through each entry in the input data
      for (final List<dynamic> entry in itemList) {
        final String productName = entry[1].toString();
        // print(
        //     'productName is $productName'); // Assuming product name is at index 1
        final double quantityToSubtract =
            double.tryParse(entry[2].toString()) ??
                0.0; // Assuming quantity to subtract is at index 2

        bool success = false;
        int retryCount = 0;
        dynamic lastError;

        // Retry loop for optimistic locking
        while (!success && retryCount < 3) {
          // You can adjust the number of retries as needed
          try {
            // Fetch product document
            final QuerySnapshot querySnapshot = await collectionReference
                .where('name', isEqualTo: productName)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              final DocumentSnapshot doc = querySnapshot.docs.first;
              final int currentbooked = doc['booked'] as int;

              // Calculate new booked quantity after subtraction
              final int newbooked = currentbooked - quantityToSubtract.toInt();
              print(' removepreviousBooking currentbooked is $currentbooked');
              print(
                  ' removepreviousBooking quantityToSubtract.toInt() is ${quantityToSubtract.toInt()}');
              print(' removepreviousBooking newbooked is $newbooked');

              // Attempt to update booked
              await collectionReference
                  .doc(doc.id)
                  .update({'booked': newbooked});
              // print('booked updated for $productName');
              success = true;
            } else {
              // print('Product $productName not found');
              success =
                  true; // Mark success even if product not found (optional)
            }
          } catch (error) {
            // print('Error updating booked for $productName: $error');
            lastError = error;
            retryCount++;
            await Future.delayed(Duration(seconds: 1)); // Delay before retrying
          }
        }

        if (!success) {
          // print(
          //     'Failed to update booked for $productName after $retryCount attempts');
          if (lastError != null) {
            throw lastError; // Throw the last encountered error if all retries fail
          }
          return false;
        }
      }

      // print('All booked updates completed successfully');
      isSendingEmail.value = false;
      return true;
    } catch (error) {
      print('Error updating booked: $error');
      return false;
    }
  }

  Future<bool> updateBooking(List<dynamic> data) async {
    isSendingEmail.value = true;

    // print('update booking data is $data');

    // List<List<dynamic>> itemList = data
    //     .map((item) => item['items'] as List<dynamic>)
    //     .where((items) => items[1] != 'Total')
    //     .toList();

    // print('update booking inputData ia $data');
    try {
      // Initialize collection reference
      final CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("products");

      // Iterate through each entry in the input data
      for (final List<dynamic> entry in data) {
        final String productName =
            entry[1].toString(); // Assuming product name is at index 1
        final double quantityToSubtract =
            double.tryParse(entry[2].toString()) ??
                0.0; // Assuming quantity to subtract is at index 2

        bool success = false;
        int retryCount = 0;
        dynamic lastError;

        // Retry loop for optimistic locking
        while (!success && retryCount < 3) {
          // You can adjust the number of retries as needed
          try {
            // Fetch product document
            final QuerySnapshot querySnapshot = await collectionReference
                .where('name', isEqualTo: productName)
                .get();

            if (querySnapshot.docs.isNotEmpty) {
              final DocumentSnapshot doc = querySnapshot.docs.first;
              final int currentbooked = doc['booked'] as int;

              // Calculate new booked quantity after subtraction
              final int newbooked = currentbooked + quantityToSubtract.toInt();
              print('update newbooked is $newbooked');
              // Attempt to update booked
              await collectionReference
                  .doc(doc.id)
                  .update({'booked': newbooked});
              // print('booked updated for $productName');
              success = true;
            } else {
              // print('Product $productName not found');
              success =
                  true; // Mark success even if product not found (optional)
            }
          } catch (error) {
            // print('Error updating booked for $productName: $error');
            lastError = error;
            retryCount++;
            await Future.delayed(Duration(seconds: 1)); // Delay before retrying
          }
        }

        if (!success) {
          // print(
          //     'Failed to update booked for $productName after $retryCount attempts');
          if (lastError != null) {
            throw lastError; // Throw the last encountered error if all retries fail
          }
          return false;
        }
      }

      return true;
    } catch (error) {
      print('Error updating booked: $error');
      return false;
    }
  }

  Future<bool> updateDeliveryOrderFields(String doNo, List<List<dynamic>>? data,
      dynamic totalInWord, String deliveryDate) async {
    if (doNo.isEmpty) {
      return false;
    }

    isSendingEmail.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(box.read('employeeId'))
          .collection("deliveryOrders")
          .doc(doNo)
          .update({
        'data': data?.map((list) => {'items': list}).toList(),
        'doNo': doNo + '(Revised)',
        'totalInWord': totalInWord,
        'deliveryDate': deliveryDate,
      });
      // isSendingEmail.value = false;
      Get.offAllNamed(Routes.DOUSER_INVOICE);
      return true;
    } catch (e) {
      // Log the error for debugging purposes
      print("Error updating delivery order fields: ${e.toString()}");
      return false;
    } finally {
      isSendingEmail.value = false;
    }
  }

  Future<bool> deleteDeliveryOrder(String doNo) async {
    if (doNo.isEmpty) {
      return false;
    }

    isSendingEmail.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(box.read('employeeId'))
          .collection("deliveryOrders")
          .doc(doNo)
          .delete();
      // isSendingEmail.value = false;
      Get.offAllNamed(Routes.DOUSER_INVOICE);
      return true;
    } catch (e) {
      // Log the error for debugging purposes
      print("Error updating delivery order fields: ${e.toString()}");
      return false;
    } finally {
      isSendingEmail.value = false;
    }
  }

  String? validateDoDate(String value) {
    if (value.isEmpty) {
      return "DoDate can't be empty";
    }
    return null;
  }
}
