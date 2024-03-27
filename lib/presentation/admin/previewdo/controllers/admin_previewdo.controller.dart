import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminPreviewdoController extends GetxController {
  var employeeName = ''.obs;
  String? employeeId; // Define employeeId here

  AdminPreviewdoController({this.employeeId});
  // final box = GetStorage();
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
            .doc(employeeId)
            .collection('deliveryOrders')
            .get();
    dousers.value = questionsQuery.docs.map((doc) => doc.data()).toList();
    print('dousers is $dousers');
  }

  // Getter method to retrieve dousers
  RxList<Map<String, dynamic>> getDousers() {
    return dousers;
  }
}
