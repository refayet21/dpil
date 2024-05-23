import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DouserInvoiceController extends GetxController {
  final box = GetStorage();
  RxBool isSendingEmail = false.obs;
  RxList<Map<String, dynamic>> dousers = RxList<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    getUserDo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUserDo() async {
    final QuerySnapshot<Map<String, dynamic>> questionsQuery =
        await FirebaseFirestore.instance
            .collection("do_users")
            .doc(box.read('employeeId'))
            .collection('deliveryOrders')
            .get();
    dousers.value = questionsQuery.docs.map((doc) => doc.data()).toList();
    // print('dousers is $dousers');
  }

  // Getter method to retrieve dousers
  RxList<Map<String, dynamic>> getDousers() {
    return dousers;
  }

  Future<bool> removepreviousBooking(List<List<dynamic>> inputData) async {
    isSendingEmail.value = true;
    try {
      // Initialize collection reference
      final CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("products");

      // Iterate through each entry in the input data
      for (final List<dynamic> entry in inputData) {
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
              final int newbooked = currentbooked - quantityToSubtract.toInt();

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
      return true;
    } catch (error) {
      // print('Error updating booked: $error');
      return false;
    }
  }

  Future<bool> updateBooking(List<List<dynamic>> inputData) async {
    isSendingEmail.value = true;
    try {
      // Initialize collection reference
      final CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection("products");

      // Iterate through each entry in the input data
      for (final List<dynamic> entry in inputData) {
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
      return true;
    } catch (error) {
      // print('Error updating booked: $error');
      return false;
    }
  }

  Future<bool> updateDeliveryOrder(DeliveryOrder deliveryOrder) async {
    isSendingEmail.value = true;

    try {
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(box.read('employeeId'))
          .collection("deliveryOrders")
          .doc(deliveryOrder.doNo)
          .update(deliveryOrder.toMap());
      isSendingEmail.value =
          false; // Update this according to your state management
      return true;
    } catch (e) {
      // Handle error as needed
      isSendingEmail.value =
          false; // Update this according to your state management
      return false;
    }
  }
}
