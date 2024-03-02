import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as location_lib;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

class DouserDashboardController extends GetxController {
  location_lib.Location location = location_lib.Location();
  late location_lib.LocationData _locData;
  final box = GetStorage();
  var checkIn = "--/--".obs;
  var checkOut = "--/--".obs;
  var locations = " ".obs;
  var employeeId = ''.obs;
  var employeeName = ''.obs;

  @override
  void onInit() {
    initialize();
    super.onInit();
    _getUserInfoAndRecord();
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
    List<Placemark> placemark =
        await placemarkFromCoordinates(_locData.latitude!, _locData.longitude!);
    locations.value =
        "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].subAdministrativeArea}, ${placemark[0].country}";
  }

  Future<void> _getUserInfoAndRecord() async {
    try {
      Map<String, dynamic> userInfo = await _getUserInfo();
      employeeId.value = userInfo['docId'];
      employeeName.value = userInfo['name'];
      await _getRecord();
    } catch (e) {
      print("Error getting user info and record: $e");
    }
  }

  Future<Map<String, dynamic>> _getUserInfo() async {
    String email = box.read('douseremail');
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("do_users")
        .where('email', isEqualTo: email)
        .get();
    DocumentSnapshot userDoc = userSnapshot.docs.first;
    return {
      'docId': userDoc.id,
      'name': userDoc['name'],
      'address': userDoc['address'],
      'mobile': userDoc['mobile'],
      'email': userDoc['email'],
      'password': userDoc['password'],
    };
  }

  Future<void> _getRecord() async {
    try {
      DocumentSnapshot recordSnapshot = await FirebaseFirestore.instance
          .collection("do_users")
          .doc(employeeId.value)
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
    } catch (e) {
      print("Error getting record: $e");
      checkIn.value = "--/--";
      checkOut.value = "--/--";
    }
  }

  Future<void> checkInAction() async {
    try {
      String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      String currentLocation = locations.value;
      checkIn.value = currentTime;
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(employeeId.value)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'checkIn': currentTime,
        'checkInLocation': currentLocation,
        'date': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> checkOutAction() async {
    try {
      String currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      String currentLocation = locations.value;
      checkOut.value = currentTime;
      await FirebaseFirestore.instance
          .collection("do_users")
          .doc(employeeId.value)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .set({
        'checkOut': currentTime,
        'checkOutLocation': currentLocation,
        'date': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<double?> getLatitude() async {
    if (_locData == null) {
      _locData = await location.getLocation();
    }
    return _locData.latitude;
  }

  Future<double?> getLongitude() async {
    if (_locData == null) {
      _locData = await location.getLocation();
    }
    return _locData.longitude;
  }
}
