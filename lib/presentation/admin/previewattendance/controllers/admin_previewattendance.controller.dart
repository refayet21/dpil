import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AdminPreviewattendanceController extends GetxController {
  var employeeName = ''.obs;
  String? employeeId; // Define employeeId here

  AdminPreviewattendanceController(
      {this.employeeId}); // Constructor to accept employeeId

  @override
  void onReady() {
    super.onReady();
    getAttendanceRecords(employeeId); // Pass employeeId
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString selectedMonth = DateFormat('MMMM').format(DateTime.now()).obs;

  Stream<QuerySnapshot> getAttendanceRecords(String? employeeId) {
    if (employeeId != null && employeeId.isNotEmpty) {
      return _firestore
          .collection("do_users")
          .doc(employeeId)
          .collection("Record")
          .snapshots();
    } else {
      print('Employee ID is empty');
      return Stream.empty();
    }
  }

  void updateSelectedMonth(DateTime month) {
    selectedMonth.value = DateFormat('MMMM').format(month);
    print('Selected month is ${selectedMonth.value}');
  }

  List<DocumentSnapshot>? get attendanceRecordsList =>
      _attendanceRecordsStream.value?.docs;

  final _attendanceRecordsStream = Rxn<QuerySnapshot>();

  @override
  void onInit() {
    super.onInit();
    _attendanceRecordsStream
        .bindStream(getAttendanceRecords(employeeId)); // Pass employeeId
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
