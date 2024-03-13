import 'package:dpil/presentation/widgets/admin_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/admin_addgenuser.controller.dart';

class AdminAddgenuserScreen extends GetView<AdminAddgenuserController> {
  const AdminAddgenuserScreen({Key? key}) : super(key: key);

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
              onChanged: (value) => controller.searchgeneraluser(value),
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
                itemCount: controller.foundgeneraluser.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    title: Text(
                      'Name : ${controller.foundgeneraluser[index].name!}',
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
                          'Address :${controller.foundgeneraluser[index].address!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Mobile : ${controller.foundgeneraluser[index].mobile!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Email : ${controller.foundgeneraluser[index].email!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Password : ${controller.foundgeneraluser[index].password!}',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      child: Text(
                        controller.foundgeneraluser[index].name!
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
                            controller.foundgeneraluser[index].docId!);
                      },
                    ),
                    onTap: () {
                      controller.nameController.text =
                          controller.foundgeneraluser[index].name!;
                      controller.addressController.text =
                          controller.foundgeneraluser[index].address!;
                      controller.mobileController.text =
                          controller.foundgeneraluser[index].mobile!;
                      controller.emailController.text =
                          controller.foundgeneraluser[index].email!;
                      controller.passwordController.text =
                          controller.foundgeneraluser[index].password!;

                      _buildAddEditGeneralUserView(
                          text: 'UPDATE',
                          addEditFlag: 2,
                          docId: controller.foundgeneraluser[index].docId!);
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
            _buildAddEditGeneralUserView(
                text: 'ADD', addEditFlag: 1, docId: '');
          },
          child: Text('Add General User')),
    );
  }

  _buildAddEditGeneralUserView(
      {String? text, int? addEditFlag, String? docId}) {
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
                    '${text} General User',
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
                        controller.saveUpdategeneralUsers(
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
      title: "Delete General User",
      titleStyle: TextStyle(fontSize: 20.sp),
      middleText: 'Are you sure to delete General User ?',
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
