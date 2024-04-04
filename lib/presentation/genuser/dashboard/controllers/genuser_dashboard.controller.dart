import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart' as location_lib;
import 'package:geocoding/geocoding.dart';
import 'package:slide_to_act/slide_to_act.dart';

class GenuserDashboardController extends GetxController {
  location_lib.Location location = location_lib.Location();
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  late location_lib.LocationData _locData;
  final box = GetStorage();
  var checkIn = "--/--".obs;
  var checkOut = "--/--".obs;
  var locations = " ".obs;
  var employeeId = ''.obs;
  var employeeName = ''.obs;
  var employeeaddress = ''.obs;
  var employeemobile = ''.obs;
  var employeeemail = ''.obs;
  var slideActionKey = GlobalKey<SlideActionState>();

  @override
  void onInit() {
    initialize();
    super.onInit();
    _getUserInfoAndRecord();
  }

  Future<void> logout() {
    return _auth.signOut();
  }

  @override
  void onReady() {
    super.onReady();

    // _getRecord();
  }

  Future<void> initialize() async {
    bool _serviceEnabled;
    location_lib.PermissionStatus _permission;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permission = await location.hasPermission();
    if (_permission == location_lib.PermissionStatus.denied) {
      _permission = await location.requestPermission();
      if (_permission != location_lib.PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged
        .listen((location_lib.LocationData currentLocation) {
      _locData = currentLocation;
      _getLocation();
    });
  }

  Future<void> _getLocation() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _locData.latitude!, _locData.longitude!);
      locations.value =
          "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].subAdministrativeArea}, ${placemark[0].country}";
    } catch (e) {
      // print("Error getting location: $e");
    }
  }

  Future<void> _getUserInfoAndRecord() async {
    try {
      String email = box.read('generalemail');
      QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("general_users")
          .where('email', isEqualTo: email)
          .get();
      DocumentSnapshot userDoc = userSnapshot.docs.first;
      employeeId.value = userDoc.id;
      employeeName.value = userDoc['name'];
      employeeaddress.value = userDoc['address'];
      employeemobile.value = userDoc['mobile'];
      employeeemail.value = userDoc['email'];
      box.write('genemployeeId', userDoc.id);
      _getRecord();
      // print('_getUserInfoAndRecord is called');
    } catch (e) {
      // print("Error getting user info and record: $e");
    }
  }

  Future<void> _getRecord() async {
    try {
      // print("Employee ID: ${employeeId.value}"); // Add this debug statement
      DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
          .collection("general_users")
          .doc(employeeId.value)
          // .doc(box.read(
          //   'employeeId',
          // ))
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();
      if (recordSnapshot.exists) {
        checkIn.value = recordSnapshot['checkIn'] ?? "--/--";
        checkOut.value = recordSnapshot['checkOut'] ?? "--/--";
      } else {
        checkIn.value = "--/--";
        checkOut.value = "--/--";
      }

      // print('_getRecord method is called');
    } catch (e) {
      // print("Error getting record: $e");
      checkIn.value = "--/--";
      checkOut.value = "--/--";
    }
  }

  void handleSlideAction(bool isCheckedIn) async {
    try {
      if (isCheckedIn) {
        await checkInAction();
      } else {
        await checkOutAction();
      }
      slideActionKey.currentState!.reset();
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> checkInAction() async {
    try {
      String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      String currentLocation = locations.value;
      checkIn.value = currentTime;
      await FirebaseFirestore.instance
          .collection("general_users")
          .doc(employeeId.value)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'checkIn': currentTime,
        'checkInLocation': currentLocation,
        'checkOut': "--/--",
        'checkOutLocation': '',
        'date': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<void> checkOutAction() async {
    try {
      String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      String currentLocation = locations.value;
      checkOut.value = currentTime;
      await FirebaseFirestore.instance
          .collection("general_users")
          .doc(employeeId.value)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'checkOut': currentTime,
        'checkOutLocation': currentLocation,
        'date': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      // print(e.toString());
    }
  }
}
