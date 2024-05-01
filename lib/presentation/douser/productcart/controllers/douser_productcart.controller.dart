// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:dpil/model/product.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/admin/addvendor/controllers/admin_addvendor.controller.dart';
import 'package:dpil/presentation/douser/invoicepreview/douser_invoicepreview.screen.dart';
import 'package:dpil/presentation/widgets/number_to_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DouserProductcartController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<ProductModel> cartItems = RxList<ProductModel>([]);
  AdminAddvendorController vendorAddController =
      Get.put(AdminAddvendorController());
  RxList<VendorModel> vendors = RxList<VendorModel>([]);
  RxList<VendorModel> findvendors = RxList<VendorModel>([]);
  late CollectionReference collectionReference;
  late CollectionReference vendorcollectionReference;
  RxList<ProductModel> productModel = RxList<ProductModel>([]);
  RxList<ProductModel> productModel2 = RxList<ProductModel>([]);
  RxList<ProductModel> foundProduct = RxList<ProductModel>([]);
  Rx<VendorModel?> selectedVendor = Rx<VendorModel?>(null);

  // Method to update the selected vendor
  void updateSelectedVendor(VendorModel? value) {
    // print('Updating selected vendor: $value');
    selectedVendor.value = value;
  }

  // var quantity = 0.obs;

  Stream<List<VendorModel>> getAllVendors() =>
      vendorcollectionReference.snapshots().map((query) =>
          query.docs.map((item) => VendorModel.fromJson(item)).toList());

  Stream<List<ProductModel>> getAllProducts() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromJson(item)).toList());
  @override
  void onInit() {
    super.onInit();
    // print('oninit called');
    collectionReference = firebaseFirestore.collection("products");
    vendorcollectionReference = firebaseFirestore.collection("Vendors");
    getAllVendors().listen((vendor) {
      vendors.assignAll(vendor);
      findvendors.assignAll(vendors);
      // print(findvendors);
    });

    getAllProducts().listen((products) {
      productModel2.assignAll(products);
      foundProduct.assignAll(productModel2);

      // Print foundProduct after it's assigned
      // print(foundProduct);
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

  void addToCart(ProductModel product) {
    bool alreadyInCart = cartItems.any((item) => item.docId == product.docId);

    if (!alreadyInCart) {
      cartItems.add(product);
    } else {
      // print('Product is already in the cart');
    }
  }

  bool isProductInCart(ProductModel product) {
    return cartItems.any((item) => item.docId == product.docId);
  }

  // void removeFromCart(ProductModel product) {
  //   cartItems.remove(product);
  // }

  // void increaseQuantity(ProductModel product) {
  //   final index = cartItems.indexWhere((item) => item.docId == product.docId);
  //   if (index != -1) {
  //     cartItems[index].quantity++;
  //   }
  // }

  // void decreaseQuantity(ProductModel product) {
  //   final index = cartItems.indexWhere((item) => item.docId == product.docId);
  //   if (index != -1 && cartItems[index].quantity > 1) {
  //     cartItems[index].quantity--;
  //   } else {
  //     cartItems.remove(product);
  //   }
  // }

  // void updateQuantity(ProductModel product, int newQuantity) {
  //   final index = cartItems.indexWhere((item) => item.docId == product.docId);
  //   if (index != -1) {
  //     if (newQuantity > 0) {
  //       cartItems[index].quantity = newQuantity;
  //     } else {
  //       cartItems.remove(product);
  //     }
  //   }
  // }

  selectdate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // print(pickedDate);
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      return formattedDate;
    }
  }

  Future<DoUserModel?> getDoUserById(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('do_users')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        return DoUserModel.fromJson(snapshot);
      } else {
        // print('User not found for ID: $userId');
        return null;
      }
    } catch (e) {
      // print('Error fetching user: $e');
      return null;
    }
  }

  String generateddate = DateFormat('dd.MM.yyyy').format(DateTime.now());
  // var docounter = 0;

  Future<void> generateInvoicePdf(
      String doNo,
      String date,
      String userId,
      String marketingperson,
      String vendorName,
      String vendorAddress,
      String contactPerson,
      String vendorMobile,
      List<List<dynamic>> data,
      // List<List<dynamic>> stockdata,
      // List<dynamic> data,
      var totalinword,
      String? deliveryDate) async {
    final doc = pw.Document();

    try {
      // Load fonts
      final fontData = await rootBundle.load("assets/fonts/robotoregular.ttf");
      final ttf = pw.Font.ttf(fontData);

      final header = (await rootBundle.load('assets/images/headerpad.png'))
          .buffer
          .asUint8List();
      final footer = (await rootBundle.load('assets/images/footerpad.png'))
          .buffer
          .asUint8List();

      final tableHeaders = [
        'S.L',
        'Description',
        'Roll/PCS/Bag',
        'Per Roll/PCS/Bag',
        'Unit',
        'Per Unit Price',
        'Total Unit',
        'Amount(Tk)',
        'Remarks',
      ];

      doc.addPage(
        pw.MultiPage(
          margin:
              pw.EdgeInsets.only(top: 3, right: 10.w, bottom: 6, left: 10.w),
          pageFormat: PdfPageFormat.a4,
          build: (context) {
            return [
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        // crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Image(
                            pw.MemoryImage(header),
                            // height: 72,
                            // width: 72,
                          ),
                          pw.Text(
                            'Delivery Order',
                            style: pw.TextStyle(
                              fontSize: 20.sp,
                              fontWeight: pw.FontWeight.bold,
                              decoration: pw.TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      // flex: 2,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [pw.Text('Date: $date')],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("Do : $doNo"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Marketing Person : ${marketingperson}"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("DO Type : Non Package"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Suppliar : Dynamic Polymer Industries Ltd."),
                    pw.SizedBox(height: 1.h),
                    pw.Text(
                        "Suppliar Address : West Dugri, Vawal Mirzapur, Gazipur"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Customer Name : $vendorName"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Customer Address : $vendorAddress"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Contact Person : $contactPerson"),
                    pw.SizedBox(height: 1.h),
                    pw.Text("Contact Person Mobile : $vendorMobile"),
                    pw.SizedBox(height: 1.h),
                  ]),
              pw.SizedBox(height: 10),
              pw.Table.fromTextArray(
                headers: tableHeaders,
                data: data,
                cellStyle: pw.TextStyle(
                  fontSize: 7.sp,
                ),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(
                  fontSize: 7.sp,
                ),
              ),
              pw.SizedBox(height: 10.h),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    'In words: ${NumberToWords.convert(totalinword)} taka',
                    style: pw.TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Delivery Date: $deliveryDate',
                style: pw.TextStyle(
                  fontSize: 11.0,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Note: In case of failure in taking delivery within due time, beneficiary may cancel the D.O offered to the customer.',
                style: pw.TextStyle(
                  fontSize: 11.0,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 20.h),
              pw.Container(
                // alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'This is a system-generated delivery order, no signature required',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10.h),
                    pw.Text(
                      'Copy to:',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '01 Honorable Chairrman (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '02 Controller Accounts (Head Office)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '03 Head Of Operation (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '04 Head Of HR & Admin (DPIL)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                    pw.SizedBox(height: 5.h),
                    pw.Text(
                      '05 In-Charge (Store)',
                      style: pw.TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          footer: (context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 20.0),

              // uncoment it
              child: pw.Image(
                pw.MemoryImage(footer),
                // height: 72,
                // width: 72,
              ),
            );
          },
        ),
      );

      Get.to(() => DouserInvoicepreviewScreen(
            doc: doc,
            pdfname: doNo,
            deliveryOrder: DeliveryOrder(
              doNo: doNo,
              date: date,
              userId: userId,
              marketingPerson: marketingperson,
              vendorName: vendorName,
              vendorAddress: vendorAddress,
              contactPerson: contactPerson,
              vendorMobile: vendorMobile,
              data: data,
              totalInWord: totalinword,
              deliveryDate: deliveryDate,
            ),
            // stockdata: stockdata,
          ));
    } catch (e) {
      // print('Error: $e');
    }
  }

  // void searchProduct(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     foundProduct.assignAll(productModel2.toList());
  //   } else {
  //     List<ProductModel> results = productModel2
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(searchQuery.toLowerCase()))
  //         .toList();
  //     foundProduct.assignAll(results);
  //   }
  // }
  // void searchProduct(String searchQuery) {
  //   if (searchQuery.isEmpty) {
  //     // Corrected the typo here
  //     foundProduct.assignAll(productModel2.toList());
  //   } else {
  //     List<ProductModel> results = productModel2
  //         .where((element) => element.category!
  //             .toLowerCase()
  //             .contains(searchQuery.toLowerCase()))
  //         .toList();
  //     foundProduct.assignAll(results);
  //   }
  // }

  void searchProduct(String productName) {
    List<ProductModel> results;
    if (productName.isEmpty) {
      results = productModel2;
    } else {
      results = productModel2
          .where((element) => element.name
              .toString()
              .toLowerCase()
              .contains(productName.toLowerCase()))
          .toList();
    }
    foundProduct.value = results;
  }
}
