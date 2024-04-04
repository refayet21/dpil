import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_addstockuser.controller.dart';

class AdminAddstockuserScreen extends GetView<AdminAddstockuserController> {
  const AdminAddstockuserScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: AdminDrawer(),
      appBar: AppBar(
        title: Text(
          'ADD stock User',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextField(
              onChanged: (value) => controller.searchstockuser(value),
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
            child: Obx(
              () => ListView.builder(
                itemCount: controller.foundstockuser.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.foundstockuser[index].name!}',
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
                          height: 3.h,
                        ),
                        Text(
                          'Address :${controller.foundstockuser[index].address!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Mobile : ${controller.foundstockuser[index].mobile!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Email : ${controller.foundstockuser[index].email!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Password : ${controller.foundstockuser[index].password!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.foundstockuser[index].name!
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
                            controller.foundstockuser[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.foundstockuser[index].name!;
                      controller.addressController.text =
                          controller.foundstockuser[index].address!;
                      controller.mobileController.text =
                          controller.foundstockuser[index].mobile!;
                      controller.emailController.text =
                          controller.foundstockuser[index].email!;
                      controller.passwordController.text =
                          controller.foundstockuser[index].password!;

                      _buildAddEditstockUserView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.foundstockuser[index].docId!);
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
            _buildAddEditstockUserView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add stock User')),
    );
  }

  // _buildAddEditstockUserView({String? text, int? addEditFlag, String? docId}) {
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
  //                   '${text} stock User',
  //                   style: TextStyle(
  //                       fontSize: 16.sp,
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black),
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
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
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'address',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.addressController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Mobile',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.mobileController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Email',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.emailController,
  //                 ),
  //                 SizedBox(
  //                   height: 8.h,
  //                 ),
  //                 TextFormField(
  //                   keyboardType: TextInputType.multiline,
  //                   decoration: InputDecoration(
  //                     hintText: 'Password',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(8.r),
  //                     ),
  //                   ),
  //                   controller: controller.passwordController,
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
  //                       controller.saveUpdatestockUsers(
  //                         controller.nameController.text,
  //                         controller.addressController.text,
  //                         controller.mobileController.text,
  //                         controller.emailController.text,
  //                         controller.passwordController.text,
  //                         docId!,
  //                         addEditFlag!,
  //                       );
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

  _buildAddEditstockUserView({String? text, int? addEditFlag, String? docId}) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          color: Colors.blue.shade200,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${text} Stock User',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.addressController,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.mobileController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Mobile';
                      }
                      if (value.length < 11) {
                        return 'Mobile No must be  11 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    readOnly: addEditFlag == 2 ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    readOnly: addEditFlag == 2 ? true : false,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: Get.context!.width,
                      height: 45.h,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        text!,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.saveUpdatestockUsers(
                            controller.nameController.text,
                            controller.addressController.text,
                            controller.mobileController.text,
                            controller.emailController.text,
                            controller.passwordController.text,
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
      title: "Delete stock User",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete stock User ?',
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
