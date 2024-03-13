import 'package:dpil/model/product.dart';
import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_addproduct.controller.dart';

class AdminAddproductScreen extends GetView<AdminAddproductController> {
  const AdminAddproductScreen({Key? key}) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     drawer: AdminDrawer(),
  //     appBar: AppBar(
  //       // leading: Icon(
  //       //   Icons.medical_information,
  //       //   size: 30.sp,
  //       //   color: Colors.black,
  //       // ),
  //       title: Text(
  //         'DPIL',
  //         style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
  //       ),
  //       centerTitle: true,
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: TextField(
  //             onChanged: (value) => controller.searchProduct(value),
  //             decoration: InputDecoration(
  //               hintText: "Search",
  //               prefixIcon: Icon(Icons.search),
  //               border: OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10.h,
  //         ),
  //         Expanded(
  //           child: Obx(
  //             () => ListView.builder(
  //               itemCount: controller.foundProduct.length,
  //               itemBuilder: (context, index) => Card(
  //                 color: Colors.grey.shade200,
  //                 child: ListTile(
  //                   title: Text(
  //                     'Name : ${controller.foundProduct[index].name!}',
  //                     style: TextStyle(
  //                         fontSize: 16.sp,
  //                         fontWeight: FontWeight.w600,
  //                         color: Colors.black),
  //                   ),
  //                   subtitle: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         height: 7.h,
  //                       ),
  //                       Text(
  //                         'Unit : ${controller.foundProduct[index].unit!}',
  //                         style: TextStyle(
  //                             fontSize: 14.sp,
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.black),
  //                       ),
  //                       SizedBox(
  //                         height: 3.h,
  //                       ),
  //                       Text(
  //                         'Stock : ${controller.foundProduct[index].stock!}',
  //                         style: TextStyle(
  //                             fontSize: 14.sp,
  //                             fontWeight: FontWeight.w600,
  //                             color: Colors.black),
  //                       ),
  //                     ],
  //                   ),
  //                   leading: CircleAvatar(
  //                     child: Text(
  //                       controller.foundProduct[index].name!
  //                           .substring(0, 1)
  //                           .capitalize!,
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w700, color: Colors.black),
  //                     ),
  //                     backgroundColor: Colors.blue.shade200,
  //                   ),
  //                   trailing: IconButton(
  //                     icon: Icon(
  //                       Icons.delete_forever,
  //                       color: Colors.red,
  //                     ),
  //                     onPressed: () {
  //                       displayDeleteDialog(
  //                           controller.foundProduct[index].docId!);
  //                     },
  //                   ),
  //                   onTap: () {
  //                     controller.nameController.text =
  //                         controller.foundProduct[index].name!;
  //                     controller.unitController.text =
  //                         controller.foundProduct[index].unit!;
  //                     controller.stockController.text =
  //                         controller.foundProduct[index].stock!.toString();
  //                     _buildAddEditProductView(
  //                         text: 'UPDATE',
  //                         addEditFlag: 2,
  //                         docId: controller.foundProduct[index].docId!);
  //                   },
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     floatingActionButton: ElevatedButton(
  //         onPressed: () {
  //           _buildAddEditProductView(text: 'ADD', addEditFlag: 1, docId: '');
  //         },
  //         child: Text('Add Product')),
  //   );
  // }

  // _buildAddEditProductView({String? text, int? addEditFlag, String? docId}) {
  //   Get.bottomSheet(
  //     Container(
  //       decoration: BoxDecoration(
  //           borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(16.r),
  //             topLeft: Radius.circular(16.r),
  //           ),
  //           color: Colors.blue.shade200),
  //       child: Padding(
  //         padding:
  //             EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h, bottom: 16.h),
  //         child: Form(
  //           key: controller.formKey,
  //           autovalidateMode: AutovalidateMode.onUserInteraction,
  //           child: SingleChildScrollView(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '${text} Product',
  //                   style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black),
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     hintText: 'Name',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.nameController,
  //                   // validator: (value) {
  //                   //   return controller.validateName(value!);
  //                   // },
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     hintText: 'Unit',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.unitController,
  //                 ),
  //                 SizedBox(
  //                   height: 10.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.number,
  //                   decoration: InputDecoration(
  //                     hintText: 'Stock',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.stockController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 ConstrainedBox(
  //                   constraints: BoxConstraints.tightFor(
  //                       width: Get.context!.width, height: 45.h),
  //                   child: ElevatedButton(
  //                     child: Text(
  //                       text!,
  //                       style: TextStyle(color: Colors.black, fontSize: 16.sp),
  //                     ),
  //                     onPressed: () {
  //                       final productModel = ProductModel(
  //                         docId: docId,
  //                         name: controller.nameController.text,
  //                         unit: controller.unitController.text,
  //                         stock: int.tryParse(controller.stockController.text),
  //                       );

  //                       controller.saveUpdateProduct(
  //                           productModel, docId!, addEditFlag!);
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // displayDeleteDialog(String docId) {
  //   Get.defaultDialog(
  //     title: "Delete Product",
  //     titleStyle: TextStyle(fontSize: 20.sp),
  //     middleText: 'Are you sure to delete Product ?',
  //     textCancel: "Cancel",
  //     textConfirm: "Confirm",
  //     confirmTextColor: Colors.black,
  //     onCancel: () {},
  //     onConfirm: () {
  //       controller.deleteData(docId);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.searchProduct(value),
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.foundProduct.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.foundProduct[index].name!}',
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          'Unit : ${controller.foundProduct[index].unit!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Text(
                          'TotalUnit : ${controller.foundProduct[index].totalunit!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'unitqty : ${controller.foundProduct[index].unitqty!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'rate : ${controller.foundProduct[index].rate!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Stock : ${controller.foundProduct[index].stock!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.foundProduct[index].name!
                            .substring(0, 1)
                            .capitalize!,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      backgroundColor: Colors.blue.shade200,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        displayDeleteDialog(
                            controller.foundProduct[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.foundProduct[index].name!;
                      controller.unitController.text =
                          controller.foundProduct[index].unit!;
                      controller.totalunitController.text =
                          controller.foundProduct[index].totalunit!;
                      controller.unitqtyController.text =
                          controller.foundProduct[index].unitqty!.toString();
                      controller.rateController.text =
                          controller.foundProduct[index].rate!.toString();
                      controller.stockController.text =
                          controller.foundProduct[index].stock!.toString();
                      _buildAddEditProductView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.foundProduct[index].docId!);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _buildAddEditProductView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add Product')),
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
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.nameController,
                    // validator: (value) {
                    //   return controller.validateName(value!);
                    // },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Unit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.unitController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'TotalUnit',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.totalunitController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'unitqty',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.unitqtyController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'rate',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.rateController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Stock',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.stockController,
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
                          unit: controller.unitController.text,
                          totalunit: controller.totalunitController.text,
                          unitqty:
                              int.tryParse(controller.unitqtyController.text),
                          rate: double.tryParse(controller.rateController.text),
                          stock: int.tryParse(controller.stockController.text),
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
