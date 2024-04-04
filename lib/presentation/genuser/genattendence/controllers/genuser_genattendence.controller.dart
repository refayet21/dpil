import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class GenuserGenattendenceController extends GetxController {
  final box = GetStorage();

  var employeeName = ''.obs;

  @override
  void onReady() {
    super.onReady();
    getAttendanceRecords();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString selectedMonth = DateFormat('MMMM').format(DateTime.now()).obs;

  Stream<QuerySnapshot> getAttendanceRecords() {
    if (box.read('genemployeeId').isNotEmpty) {
      return _firestore
          .collection("general_users")
          .doc(box.read('genemployeeId'))
          .collection("Record")
          .snapshots();
    } else {
      // print('Employee ID is empty');
      return Stream.empty();
    }
  }

  void updateSelectedMonth(DateTime month) {
    selectedMonth.value = DateFormat('MMMM').format(month);
    // print('Selected month is ${selectedMonth.value}');
  }

  List<DocumentSnapshot>? get attendanceRecordsList =>
      _attendanceRecordsStream.value?.docs;

  final _attendanceRecordsStream = Rxn<QuerySnapshot>();

  @override
  void onInit() {
    super.onInit();
    _attendanceRecordsStream.bindStream(getAttendanceRecords());
  }

  // Define filteredAttendance property here
  List<DocumentSnapshot> get filteredAttendance {
    if (selectedMonth.value.isNotEmpty) {
      final selectedMonthInt =
          DateFormat('MMMM').parse(selectedMonth.value).month;
      return attendanceRecordsList?.where((record) {
            final recordMonth = record['date'].toDate().month;
            return recordMonth == selectedMonthInt;
          }).toList() ??
          [];
    } else {
      return [];
    }
  }
}
