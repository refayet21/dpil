import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:get/get.dart';

class AdminAttendanceController extends GetxController {
  RxList<DoUserModel> founddouser = RxList<DoUserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<DoUserModel> dousers = RxList<DoUserModel>([]);
  Stream<List<DoUserModel>> getAlldoUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => DoUserModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("do_users");
    dousers.bindStream(getAlldoUsers());
    founddouser = dousers;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void searchdouser(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     founddouser.assignAll(dousers.toList());
  //   } else {
  //     List<DoUserModel> results = dousers
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     founddouser.assignAll(results);
  //   }
  // }
  void searchdouser(String searchQuery) {
    if (searchQuery.isEmpty) {
      founddouser.assignAll(dousers.toList());
    } else {
      List<DoUserModel> results = dousers
          .where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      founddouser.clear(); // Clear the previous search results
      founddouser.addAll(results); // Add new search results
    }
  }
}
