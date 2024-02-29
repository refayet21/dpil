import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_adddouser.controller.dart';

class AdminAdddouserScreen extends GetView<AdminAdddouserController> {
  const AdminAdddouserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawer(),
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
              onChanged: (value) => controller.searchdouser(value),
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
                itemCount: controller.founddouser.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.founddouser[index].name!}',
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
                          'Address :${controller.founddouser[index].address!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Mobile : ${controller.founddouser[index].mobile!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Email : ${controller.founddouser[index].email!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Password : ${controller.founddouser[index].password!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.founddouser[index].name!
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
                            controller.founddouser[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.founddouser[index].name!;
                      controller.addressController.text =
                          controller.founddouser[index].address!;
                      controller.mobileController.text =
                          controller.founddouser[index].mobile!;
                      controller.emailController.text =
                          controller.founddouser[index].email!;
                      controller.passwordController.text =
                          controller.founddouser[index].password!;

                      _buildAddEditdoUserView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.founddouser[index].docId!);
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
            _buildAddEditdoUserView(text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add Do User')),
    );
  }

  _buildAddEditdoUserView({String? text, int? addEditFlag, String? docId}) {
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
                    '${text} Do User',
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
                    // validator: (value) {
                    //   return controller.validateName(value!);
                    // },
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
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
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
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.emailController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    controller: controller.passwordController,
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
                        controller.saveUpdatedoUsers(
                          controller.nameController.text,
                          controller.addressController.text,
                          controller.mobileController.text,
                          controller.emailController.text,
                          controller.passwordController.text,
                          docId!,
                          addEditFlag!,
                        );
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
      title: "Delete Do User",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete Do User ?',
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