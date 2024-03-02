import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DouserAttendenceController extends GetxController {
  final box = GetStorage();
  // var employeeId = box.read(
  //   'employeeId',
  // );
  var employeeName = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    getAttendanceRecords();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString selectedMonth = DateFormat('MMMM').format(DateTime.now()).obs;

  Stream<QuerySnapshot> getAttendanceRecords() {
    if (box
        .read(
          'employeeId',
        )
        .isNotEmpty) {
      return _firestore
          .collection("do_users")
          .doc(box.read(
            'employeeId',
          ))
          .collection("Record")
          .snapshots();
    } else {
      print('Employee ID is empty');
      return Stream.empty(); // Return an empty stream if employeeId is empty
    }
  }

  void updateSelectedMonth(DateTime month) {
    selectedMonth.value = DateFormat('MMMM').format(month);
  }
}
