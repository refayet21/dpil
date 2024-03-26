import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controllers/douser_invoice.controller.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  DouserProductcartController douserProductcartController =
      Get.put(DouserProductcartController());
  DouserInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: Text(
          'DPIL',
          style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.dousers.isEmpty) {
          // Show loading indicator if data is being fetched
          if (controller.dousers.isEmpty && !controller.dousers.isNotEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          // Show message if data is empty
          return Center(child: Text('No delivery orders found'));
        } else {
          // Display the list of doNo values using ListView.builder
          return ListView.builder(
            itemCount: controller.dousers.length,
            itemBuilder: (context, index) {
              // List<dynamic> data = controller.dousers[index]['data'];

              // // Convert data back into the original format
              // List<List<dynamic>> convertedList = [];
              // // for (var item in data) {
              // //   // Ensure that each item is of type List<dynamic>
              // //   if (item is List<dynamic>) {
              // //     convertedList.add(item);
              // //   } else {}
              // // }

              // for (var item in data) {
              //   List<dynamic> items = item['items'];
              //   // Now you can access each item in the 'items' list
              //   // For example:
              //   for (var value in items) {
              //     print(value);
              //   }
              // }

              List<dynamic> data = controller.dousers[index]['data'];

              List<List<dynamic>> convertedList = [];
              for (var item in data) {
                List<dynamic> items = item['items'];
                convertedList.add(items);
              }

              return Card(
                child: ListTile(
                  title: Text('Do No: ${controller.dousers[index]['doNo']}'),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Customer Name :${controller.dousers[index]['vendorName']}',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        'Delivery Date : ${controller.dousers[index]['deliveryDate']}',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  onTap: () {
                    douserProductcartController.generateInvoicePdf(
                      controller.dousers[index]['doNo'],
                      controller.dousers[index]['date'],
                      controller.dousers[index]['userId'],
                      controller.dousers[index]['marketingPerson'],
                      controller.dousers[index]['vendorName'],
                      controller.dousers[index]['vendorAddress'],
                      controller.dousers[index]['contactPerson'],
                      controller.dousers[index]['vendorMobile'],
                      convertedList,
                      controller.dousers[index]['totalInWord'],
                      controller.dousers[index]['deliveryDate'],
                    );
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
