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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  final AdminDoController douserProductcartController =
      Get.put(AdminDoController());

  DouserInvoiceScreen({Key? key}) : super(key: key);

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate
        ? (controller.startDate.value ?? DateTime.now())
        : (controller.endDate.value ?? DateTime.now());
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      if (isStartDate) {
        controller.startDate.value = picked;
      } else {
        controller.endDate.value = picked;
      }
    }
  }

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
      body: Obx(() {
        if (controller.dousers.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          // Get the filtered list based on the selected dates
          List<dynamic> filteredDousers = controller.getFilteredDousers();

          // Sort the filtered list by 'doNo' in descending order and by 'date' in ascending order
          filteredDousers.sort((a, b) {
            int doNoComparison = b['doNo'].compareTo(a['doNo']);
            if (doNoComparison != 0) {
              return doNoComparison;
            }
            DateTime dateA = DateFormat('dd-MM-yyyy').parse(a['date']);
            DateTime dateB = DateFormat('dd-MM-yyyy').parse(b['date']);
            return dateA.compareTo(dateB);
          });

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Start Date:'),
                        SizedBox(height: 8.0),
                        OutlinedButton(
                          onPressed: () async {
                            await _selectDate(context, true);
                          },
                          child: Text(controller.startDate.value != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(controller.startDate.value!)
                              : 'Select Start Date'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('End Date:'),
                        SizedBox(height: 8.0),
                        OutlinedButton(
                          onPressed: () async {
                            await _selectDate(context, false);
                          },
                          child: Text(controller.endDate.value != null
                              ? DateFormat('dd-MM-yyyy')
                                  .format(controller.endDate.value!)
                              : 'Select End Date'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDousers.length,
                  itemBuilder: (context, index) {
                    List<dynamic> data = filteredDousers[index]['data'];

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
                            'Do No: ${filteredDousers[index]['doNo']}',
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
                                'Customer Name :${filteredDousers[index]['vendorName']}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                'Delivery Date : ${filteredDousers[index]['deliveryDate']}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            douserProductcartController.generateInvoicePdf(
                              filteredDousers[index]['doNo'],
                              filteredDousers[index]['date'],
                              filteredDousers[index]['userId'],
                              filteredDousers[index]['marketingPerson'],
                              filteredDousers[index]['vendorName'],
                              filteredDousers[index]['vendorAddress'],
                              filteredDousers[index]['contactPerson'],
                              filteredDousers[index]['vendorMobile'],
                              convertedList,
                              filteredDousers[index]['totalInWord'],
                              filteredDousers[index]['deliveryDate'],
                            );
                          },
                          trailing: DateFormat('dd-MM-yyyy')
                                          .format(DateFormat('dd-MM-yyyy')
                                              .parse(filteredDousers[index]
                                                  ['date']))
                                          .toString() ==
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now())
                                          .toString() ||
                                  DateFormat('dd-MM-yyyy')
                                          .format(DateFormat('dd-MM-yyyy')
                                              .parse(filteredDousers[index]
                                                  ['date']))
                                          .toString() ==
                                      DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()
                                              .add(Duration(days: -1)))
                                          .toString()
                              ? IconButton(
                                  icon: Icon(
                                    Icons.edit_document,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                              'If you edit, it will be removed previous booking'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () async {
                                                bool bookedSuccessfully =
                                                    await controller
                                                        .removepreviousBooking(
                                                            filteredDousers[
                                                                    index]
                                                                ['data']!);
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog first
                                                if (bookedSuccessfully) {
                                                  Get.to(() =>
                                                      EditCartItemsScreen(
                                                        data: filteredDousers[
                                                            index]['data'],
                                                        doNo: filteredDousers[
                                                            index]['doNo'],
                                                      ));
                                                }
                                              },
                                              child: Obx(
                                                () => controller
                                                        .isSendingEmail.value
                                                    ? CircularProgressIndicator(
                                                        color: Colors.blue,
                                                      )
                                                    : Text('Edit'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'No',
                                                style:
                                                    TextStyle(fontSize: 11.sp),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.edit_off,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
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
                                        );
                                      },
                                    );
                                  },
                                ),

// tralling for delete previous booking and do
                          //   trailing: IconButton(
                          //     icon: Icon(
                          //       Icons.delete,
                          //       color: Colors.red,
                          //     ),
                          //     onPressed: () async {
                          //       await showDialog(
                          //         context: context,
                          //         builder: (BuildContext context) {
                          //           return AlertDialog(
                          //             title: Text(
                          //                 'Are you sure to delete Previous Booking?'),
                          //             actions: <Widget>[
                          //               TextButton(
                          //                 onPressed: () async {
                          //                   bool bookedSuccessfully =
                          //                       await controller
                          //                           .removepreviousBooking(
                          //                               filteredDousers[index]
                          //                                   ['data']);
                          //                   Navigator.of(context)
                          //                       .pop(); // Close the dialog first
                          //                   if (bookedSuccessfully) {
                          //                     await controller
                          //                         .deleteDeliveryOrder(
                          //                             filteredDousers[index]
                          //                                 ['doNo']);
                          //                     Navigator.of(context).pop();
                          //                   } // Close the dialog first
                          //                 },
                          //                 child: Obx(
                          //                   () => controller.isSendingEmail.value
                          //                       ? CircularProgressIndicator(
                          //                           color: Colors.blue,
                          //                         )
                          //                       : Text('Delete'),
                          //                 ),
                          //               ),
                          //               TextButton(
                          //                 onPressed: () {
                          //                   Navigator.of(context).pop();
                          //                 },
                          //                 child: Text(
                          //                   'No',
                          //                   style: TextStyle(fontSize: 11.sp),
                          //                 ),
                          //               ),
                          //             ],
                          //           );
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
