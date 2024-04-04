import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/general_user_model.dart';
import 'package:get/get.dart';

class AdminGenattendenceController extends GetxController {
  RxList<GeneralUserModel> foundGenuser = RxList<GeneralUserModel>([]);

  // Firestore operation
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<GeneralUserModel> genusers = RxList<GeneralUserModel>([]);
  Stream<List<GeneralUserModel>> getAllGenUsers() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => GeneralUserModel.fromJson(item)).toList());

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("general_users");
    getAllGenUsers().listen((gen) {
      genusers.assignAll(gen);
      foundGenuser.assignAll(genusers);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void searchGenuser(String searchQuery) {
    if (searchQuery.isEmpty) {
      foundGenuser.assignAll(genusers.toList());
    } else {
      List<GeneralUserModel> results = genusers
          .where((element) =>
              element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
      foundGenuser.clear();
      foundGenuser.addAll(results);
    }
  }
}
