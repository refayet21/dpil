import 'package:dpil/infrastructure/navigation/routes.dart';
import 'package:dpil/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers/stock_user_dashboard.controller.dart';

class StockUserDashboardScreen extends GetView<StockUserDashboardController> {
  StockUserDashboardScreen({Key? key}) : super(key: key);
  final box = GetStorage();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         'Update Stock',
  //         style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
  //       ),
  //       centerTitle: true,
  //       actions: [
  //         IconButton(
  //             onPressed: () {
  //               box.remove('stockemail');

  //               Get.offNamed(Routes.LOGIN);
  //             },
  //             icon: Icon(Icons.logout))
  //       ],
  //     ),
  //     body: StreamBuilder<Map<String, List<ProductModel>>>(
  //       stream: controller.getAllProductsGroupedByCategory(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return Center(child: Text("No products found."));
  //         } else {
  //           return ListView.builder(
  //             itemCount: snapshot.data!.length,
  //             itemBuilder: (context, index) {
  //               String category = snapshot.data!.keys.toList()[index];
  //               List<ProductModel> products = snapshot.data![category]!;
  //               return Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.all(8.0.r),
  //                     child: Text(
  //                       category,
  //                       style: TextStyle(
  //                         fontSize: 20.sp,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ),
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     itemCount: products.length,
  //                     itemBuilder: (context, index) {
  //                       ProductModel product = products[index];
  //                       return Card(
  //                         color: Colors.grey.shade200,
  //                         child: ListTile(
  //                           title: Text(
  //                             'Name : ${product.name!}',
  //                             style: TextStyle(
  //                               fontSize: 16.sp,
  //                               fontWeight: FontWeight.w600,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                           subtitle: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               SizedBox(height: 7.h),
  //                               Text(
  //                                 'Category : ${product.category!}',
  //                                 style: TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               SizedBox(height: 7.h),
  //                               Text(
  //                                 'Checkin : ${product.checkin!}',
  //                                 style: TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               SizedBox(height: 7.h),
  //                               Text(
  //                                 'Checkout : ${product.checkout!}',
  //                                 style: TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                               SizedBox(height: 7.h),
  //                               Text(
  //                                 'Booked : ${product.booked!}',
  //                                 style: TextStyle(
  //                                   fontSize: 14.sp,
  //                                   fontWeight: FontWeight.w600,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           leading: CircleAvatar(
  //                             child: Text(
  //                               product.name!.substring(0, 1).toUpperCase(),
  //                               style: TextStyle(
  //                                 fontWeight: FontWeight.w700,
  //                                 color: Colors.black,
  //                               ),
  //                             ),
  //                             backgroundColor: Colors.blue.shade200,
  //                           ),
  //                           // trailing: IconButton(
  //                           //   icon: Icon(
  //                           //     Icons.delete_forever,
  //                           //     color: Colors.red,
  //                           //   ),
  //                           //   onPressed: () {
  //                           //     displayDeleteDialog(product.docId!);
  //                           //   },
  //                           // ),
  //                           onTap: () {
  //                             controller.nameController.text = product.name!;
  //                             controller.categoryController.text =
  //                                 product.category!;
  //                             controller.checkinController.text =
  //                                 product.checkin!.toString();
  //                             controller.checkoutController.text =
  //                                 product.checkout!.toString();
  //                             controller.bookedController.text =
  //                                 product.booked!.toString();
  //                             _buildAddEditProductView(
  //                               text: 'UPDATE',
  //                               addEditFlag: 2,
  //                               docId: product.docId!,
  //                             );
  //                           },
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ],
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Stock',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.logout();
                box.remove('stockemail');

                Get.offNamed(Routes.LOGIN);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchProduct(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //       itemCount: controller.foundProduct.length,
          //       itemBuilder: (context, index) => Card(
          //         color: Colors.grey.shade200,
          //         child: ListTile(
          //           title: Text(
          //             'Name : ${controller.foundProduct[index].name!}',
          //             style: TextStyle(
          //                 fontSize: 16.sp,
          //                 fontWeight: FontWeight.w600,
          //                 color: Colors.black),
          //           ),
          //           subtitle: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               SizedBox(
          //                 height: 7.h,
          //               ),
          //               Text(
          //                 'category : ${controller.foundProduct[index].category!}',
          //                 style: TextStyle(
          //                     fontSize: 14.sp,
          //                     fontWeight: FontWeight.w600,
          //                     color: Colors.black),
          //               ),
          //               SizedBox(
          //                 height: 7.h,
          //               ),
          //               Text(
          //                 'Checkin : ${controller.foundProduct[index].checkin!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 7.h),
          //               Text(
          //                 'Checkout : ${controller.foundProduct[index].checkout!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(height: 7.h),
          //               Text(
          //                 'Booked : ${controller.foundProduct[index].booked!}',
          //                 style: TextStyle(
          //                   fontSize: 14.sp,
          //                   fontWeight: FontWeight.w600,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           leading: CircleAvatar(
          //             child: Text(
          //               controller.foundProduct[index].name!
          //                   .substring(0, 1)
          //                   .capitalize!,
          //               style: TextStyle(
          //                   fontWeight: FontWeight.w700, color: Colors.black),
          //             ),
          //             backgroundColor: Colors.blue.shade200,
          //           ),
          //           // trailing: IconButton(
          //           //   icon: Icon(
          //           //     Icons.delete_forever,
          //           //     color: Colors.red,
          //           //   ),
          //           //   onPressed: () {
          //           //     displayDeleteDialog(
          //           //         controller.foundProduct[index].docId!);
          //           //   },
          //           // ),
          //           onTap: () {
          //             controller.nameController.text =
          //                 controller.foundProduct[index].name!;
          //             controller.categoryController.text =
          //                 controller.foundProduct[index].category!;

          //             controller.checkinController.text =
          //                 controller.foundProduct[index].checkin!.toString();
          //             controller.checkoutController.text =
          //                 controller.foundProduct[index].checkout!.toString();
          //             controller.bookedController.text =
          //                 controller.foundProduct[index].booked!.toString();
          //             _buildAddEditProductView(
          //                 text: 'UPDATE',
          //                 addEditFlag: 2,
          //                 docId: controller.foundProduct[index].docId!);
          //           },
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(
            child: Obx(
              () {
                // Group products by category
                Map<String, List<ProductModel>> groupedProducts = {};
                for (var product in controller.foundProduct) {
                  if (!groupedProducts.containsKey(product.category)) {
                    groupedProducts[product.category!] = [];
                  }
                  groupedProducts[product.category!]!.add(product);
                }

                // Sort groupedProducts by category
                var sortedEntries = groupedProducts.entries.toList()
                  ..sort((a, b) => a.key.compareTo(b.key));

                return ListView.builder(
                  itemCount: sortedEntries.length,
                  itemBuilder: (context, categoryIndex) {
                    var category = sortedEntries[categoryIndex].key;
                    var products = sortedEntries[categoryIndex].value;

                    // Sort products by name
                    products.sort((a, b) => a.name!.compareTo(b.name!));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.blue.shade200,
                              child: ListTile(
                                title: Text(
                                  'Product Name: ${products[index].name ?? "N/A"}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Text(
                                        'Checkin: ${products[index].checkin ?? "N/A"}'),
                                    Text(
                                        'Checkout: ${products[index].checkout ?? "N/A"}'),
                                    Text(
                                        'Booked: ${products[index].booked ?? "N/A"}'),
                                  ],
                                ),

                                //  add here

                                // leading: CircleAvatar(
                                //   child: Text(
                                //     controller.foundProduct[index].name!
                                //         .substring(0, 1)
                                //         .capitalize!,
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w700,
                                //         color: Colors.black),
                                //   ),
                                //   backgroundColor: Colors.blue.shade200,
                                // ),
                                leading: CircleAvatar(
                                  child: Text(
                                    controller.foundProduct[index].name!
                                        .substring(0, 1)
                                        .capitalize!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  backgroundColor: Colors.blue.shade200,
                                ),
                                // trailing: IconButton(
                                //   icon: Icon(
                                //     Icons.delete_forever,
                                //     color: Colors.red,
                                //   ),
                                //   onPressed: () {
                                //     displayDeleteDialog(
                                //         controller.foundProduct[index].docId!);
                                //   },
                                // ),
                                onTap: () {
                                  controller.nameController.text =
                                      controller.foundProduct[index].name!;
                                  controller.categoryController.text =
                                      controller.foundProduct[index].category!;

                                  controller.checkinController.text = controller
                                      .foundProduct[index].checkin!
                                      .toString();
                                  controller.checkoutController.text =
                                      controller.foundProduct[index].checkout!
                                          .toString();
                                  controller.bookedController.text = controller
                                      .foundProduct[index].booked!
                                      .toString();
                                  _buildAddEditProductView(
                                      text: 'UPDATE',
                                      addEditFlag: 2,
                                      docId: controller
                                          .foundProduct[index].docId!);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: ElevatedButton(
      //   onPressed: () {
      //     _buildAddEditProductView(text: 'ADD', addEditFlag: 1, docId: '');
      //   },
      //   child: Text('Add Product'),
      // ),
    );
  }

  _buildAddEditProductView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.r),
              topLeft: Radius.circular(16.r),
            ),
            color: Colors.blue.shade200),
        child: Padding(
          padding:
              EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Product',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.nameController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.categoryController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Checkin',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.checkinController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Checkout',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.checkoutController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Booked',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.bookedController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: Get.context!.width, height: 45.h),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                      onPressed: () {
                        final productModel = ProductModel(
                          docId: docId,
                          name: controller.nameController.text,
                          category: controller.categoryController.text,
                          checkin:
                              int.tryParse(controller.checkinController.text),
                          checkout:
                              int.tryParse(controller.checkoutController.text),
                          booked:
                              int.tryParse(controller.bookedController.text),
                        );

                        controller.saveUpdateProduct(
                            productModel, docId!, addEditFlag!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  displayDeleteDialog(String docId) {
    Get.defaultDialog(
      title: "Delete Product",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete Product ?',
      textCancel: "Cancel",
      textConfirm: "Confirm",
      confirmTextColor: Colors.black,
      onCancel: () {},
      onConfirm: () {
        controller.deleteData(docId);
      },
    );
  }
}
