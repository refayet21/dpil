import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_addvendor.controller.dart';

class AdminAddvendorScreen extends GetView<AdminAddvendorController> {
  AdminAddvendorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'Add Customer',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchVendor(value),
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
          Expanded(
            child: Obx(() {
              // Sort vendors by name
              controller.foundVendor.sort((a, b) => a.name!.compareTo(b.name!));

              return ListView.builder(
                itemCount: controller.foundVendor.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.foundVendor[index].name!}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'Address :${controller.foundVendor[index].address!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Contact Person :${controller.foundVendor[index].contactperson!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Mobile : ${controller.foundVendor[index].mobile!}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    // Expanded(
                    //   child: Obx(
                    //     () => ListView.builder(
                    //       itemCount: controller.foundVendor.length,
                    //       itemBuilder: (context, index) => Card(
                    //         color: Colors.grey.shade200,
                    //         child: ListTile(
                    //           title: Text(
                    //             'Name: ${controller.foundVendor[index].name!}',
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
                    //                 height: 3.h,
                    //               ),
                    //               Text(
                    //                 'Address: ${controller.foundVendor[index].address!}',
                    //                 style: TextStyle(
                    //                     fontSize: 14.sp,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: Colors.black),
                    //               ),
                    //               SizedBox(
                    //                 height: 3.h,
                    //               ),
                    //               Text(
                    //                 'Contact Person: ${controller.foundVendor[index].contactperson!}',
                    //                 style: TextStyle(
                    //                     fontSize: 14.sp,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: Colors.black),
                    //               ),
                    //               SizedBox(
                    //                 height: 3.h,
                    //               ),
                    //               Text(
                    //                 'Mobile: ${controller.foundVendor[index].mobile!}',
                    //                 style: TextStyle(
                    //                     fontSize: 14.sp,
                    //                     fontWeight: FontWeight.w600,
                    //                     color: Colors.black),
                    //               ),
                    //             ],
                    //           ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.foundVendor[index].name!
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
                            controller.foundVendor[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.foundVendor[index].name!;
                      controller.addressController.text =
                          controller.foundVendor[index].address!;
                      controller.contactpersonController.text =
                          controller.foundVendor[index].contactperson!;
                      controller.mobileController.text =
                          controller.foundVendor[index].mobile!;

                      _buildAddEditVendorView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.foundVendor[index].docId!);
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            _buildAddEditVendorView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add Customer')),
    );
  }

  _buildAddEditVendorView({String? text, int? addEditFlag, String? docId}) {
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
                    '${text} Customer',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.nameController,
                    validator: (value) {
                      return controller.validateName(value!);
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.addressController,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Contact Person',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.contactpersonController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return controller.validatemobile(value!);
                    },
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.mobileController,
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
                        if (controller.formKey.currentState!.validate()) {
                          controller.saveUpdateVendor(
                            controller.nameController.text,
                            controller.addressController.text,
                            controller.contactpersonController.text,
                            controller.mobileController.text,
                            docId!,
                            addEditFlag!,
                          );
                        }
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
      title: "Delete Customer",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete Customer ?',
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
