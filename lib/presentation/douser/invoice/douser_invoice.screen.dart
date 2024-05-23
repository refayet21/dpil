import 'package:dpil/model/do_model.dart';
import 'package:dpil/presentation/admin/do/controllers/admin_do.controller.dart';
import 'package:dpil/presentation/douser/invoice/controllers/editcart.dart';
import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controllers/douser_invoice.controller.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  AdminDoController douserProductcartController = Get.put(AdminDoController());
  DouserInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: Text(
          'DO History',
          style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      // body: Obx(() {
      //   if (controller.dousers.isEmpty) {
      //     // Show loading indicator if data is being fetched
      //     if (controller.dousers.isEmpty && !controller.dousers.isNotEmpty) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     // Show message if data is empty
      //     return Center(child: Text('No delivery orders found'));
      //   } else {
      //     // Display the list of doNo values using ListView.builder
      //     return ListView.builder(
      //       itemCount: controller.dousers.length,
      //       itemBuilder: (context, index) {
      //         List<dynamic> data = controller.dousers[index]['data'];

      //         List<List<dynamic>> convertedList = [];
      //         for (var item in data) {
      //           List<dynamic> items = item['items'];
      //           convertedList.add(items);
      //         }

      //         return Padding(
      //           padding: EdgeInsets.all(8.0.r),
      //           child: Card(
      //             child: ListTile(
      //               title: Text(
      //                 'Do No: ${controller.dousers[index]['doNo']}',
      //                 style: TextStyle(
      //                     fontSize: 14.sp,
      //                     fontWeight: FontWeight.w700,
      //                     color: Colors.black),
      //               ),
      //               subtitle: Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(
      //                     height: 3.h,
      //                   ),
      //                   Text(
      //                     'Customer Name :${controller.dousers[index]['vendorName']}',
      //                     style: TextStyle(
      //                       fontSize: 14.sp,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: 3.h,
      //                   ),
      //                   Text(
      //                     'Delivery Date : ${controller.dousers[index]['deliveryDate']}',
      //                     style: TextStyle(
      //                       fontSize: 14.sp,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               onTap: () {
      //                 douserProductcartController.generateInvoicePdf(
      //                   controller.dousers[index]['doNo'],
      //                   controller.dousers[index]['date'],
      //                   controller.dousers[index]['userId'],
      //                   controller.dousers[index]['marketingPerson'],
      //                   controller.dousers[index]['vendorName'],
      //                   controller.dousers[index]['vendorAddress'],
      //                   controller.dousers[index]['contactPerson'],
      //                   controller.dousers[index]['vendorMobile'],
      //                   convertedList,
      //                   // convertedList,
      //                   controller.dousers[index]['totalInWord'],
      //                   controller.dousers[index]['deliveryDate'],
      //                 );
      //               },
      //             ),
      //           ),
      //         );
      //       },
      //     );
      //   }
      // }),

      body: Obx(() {
        if (controller.dousers.isEmpty) {
          // Show loading indicator if data is being fetched
          if (controller.dousers.isEmpty && !controller.dousers.isNotEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          // Show message if data is empty
          return Center(child: Text('No delivery orders found'));
        } else {
          // Sort dousers list by 'doNo' in descending order
          controller.dousers.sort((a, b) => b['doNo'].compareTo(a['doNo']));

          // Display the sorted list of doNo values using ListView.builder
          return ListView.builder(
            itemCount: controller.dousers.length,
            itemBuilder: (context, index) {
              List<dynamic> data = controller.dousers[index]['data'];

              List<List<dynamic>> convertedList = [];
              for (var item in data) {
                List<dynamic> items = item['items'];
                convertedList.add(items);
              }

              return Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Card(
                  child: ListTile(
                    title: Text(
                      'Do No: ${controller.dousers[index]['doNo']}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          'Customer Name :${controller.dousers[index]['vendorName']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          'Delivery Date : ${controller.dousers[index]['deliveryDate']}',
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
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
                    trailing: DateFormat('dd-MM-yyyy')
                                    .format(DateFormat('dd-MM-yyyy').parse(
                                        controller.dousers[index]['date']))
                                    .toString() ==
                                DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now())
                                    .toString() ||
                            DateFormat('dd-MM-yyyy')
                                    .format(DateFormat('dd-MM-yyyy').parse(
                                        controller.dousers[index]['date']))
                                    .toString() ==
                                DateFormat('dd-MM-yyyy')
                                    .format(
                                        DateTime.now().add(Duration(days: -1)))
                                    .toString()
                        ? IconButton(
                            icon: Icon(
                              Icons.edit_document,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              Get.to(() => EditCartItemsScreen(
                                    data: controller.dousers[index]['data'],
                                  ));

                              print(controller.dousers[index]['data']);
                            },
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.edit_off,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              // print(
                              //     'current date ${DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()}');
                              // print(
                              //     'controller date ${DateFormat('dd-MM-yyyy').format(DateFormat('dd-MM-yyyy').parse(controller.dousers[index]['date'])).toString()}');

                              // print(
                              //     'tommorow date ${DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: -1))).toString()}');
                              // print(
                              //     'controller +1 date ${DateFormat('dd-MM-yyyy').format(DateFormat('dd-MM-yyyy').parse(controller.dousers[index]['date']).add(Duration(days: 1))).toString()}');

                              await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text(
                                        'Time is over to edit',
                                        style: TextStyle(
                                          fontSize: 25.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                    // actions: <Widget>[
                                    //   TextButton(
                                    //     onPressed: () {
                                    //       Navigator.of(context).pop();
                                    //     },
                                    //     child: Text(
                                    //       'OK',
                                    //       style: TextStyle(fontSize: 20.sp),
                                    //     ),
                                    //   ),
                                    // ],
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
