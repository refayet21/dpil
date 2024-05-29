// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class EditCartItemsScreen extends StatelessWidget {
//   final List<dynamic> data;

//   const EditCartItemsScreen({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Check if data is empty or contains invalid types
//     if (data.isEmpty ||
//         data.any((item) =>
//             item is! Map<String, dynamic> || item['items'] is! List<dynamic>)) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Error'),
//         ),
//         body: Center(
//           child: Text('Invalid data type or empty data list.'),
//         ),
//       );
//     }

//     // Extract the items list from the data
//     List<List<dynamic>> itemList =
//         data.map((item) => item['items'] as List<dynamic>).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Order', style: TextStyle(fontSize: 25.sp)),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             flex: 8,
//             child: ListView.builder(
//               itemCount: itemList.length,
//               itemBuilder: (context, index) {
//                 int displayIndex = index+1;
//                 var currentItem = itemList[index];

//                 return Card(
//                   color: Colors.blue.shade200,
//                   child: ListTile(
//                     leading: Text('SL: $displayIndex',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700,
//                         )),
//                     title: Text(
//                         'product: ${currentItem.length > 1 ? currentItem[1] : ""}',
//                         style: TextStyle(
//                             fontSize: 16.sp, fontWeight: FontWeight.w700)),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5.h),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration:
//                               InputDecoration(labelText: 'Roll/PCS/Bag'),
//                           initialValue: currentItem.length > 2
//                               ? currentItem[2]?.toString() ?? ''
//                               : '',
//                           onChanged: (value) {
//                             if (currentItem.length > 2) {
//                               currentItem[2] = double.tryParse(value) ?? 0;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration:
//                               InputDecoration(labelText: 'Per roll/PCS/Bag'),
//                           initialValue: currentItem.length > 3
//                               ? currentItem[3]?.toString() ?? ''
//                               : '',
//                           onChanged: (value) {
//                             if (currentItem.length > 3) {
//                               currentItem[3] = double.tryParse(value) ?? 0;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           decoration: InputDecoration(labelText: 'Unit'),
//                           initialValue: currentItem.length > 4
//                               ? currentItem[4]?.toString() ?? ''
//                               : '',
//                           onChanged: (value) {
//                             if (currentItem.length > 4) {
//                               currentItem[4] = value;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration:
//                               InputDecoration(labelText: 'Per Unit Price'),
//                           initialValue: currentItem.length > 5
//                               ? currentItem[5]?.toString() ?? ''
//                               : '',
//                           onChanged: (value) {
//                             if (currentItem.length > 5) {
//                               currentItem[5] = double.tryParse(value) ?? 0.0;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10.h),
//                         TextFormField(
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(labelText: 'Remarks'),
//                           initialValue: currentItem.length > 9
//                               ? currentItem[9]?.toString() ?? ''
//                               : '',
//                           onChanged: (value) {
//                             if (currentItem.length > 9) {
//                               currentItem[9] = value;
//                             }
//                           },
//                         ),
//                         SizedBox(height: 10.h),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:dpil/model/do_model.dart';
import 'package:dpil/presentation/douser/invoice/controllers/douser_invoice.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditCartItemsScreen extends StatelessWidget {
  final DouserInvoiceController controller = Get.put(DouserInvoiceController());
  final List<dynamic> data;
  final List<dynamic>? previousdata;
  final String? doNo;

  EditCartItemsScreen(
      {Key? key, required this.data, this.previousdata, this.doNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if data is empty or contains invalid types
    if (data.isEmpty ||
        data.any((item) =>
            item is! Map<String, dynamic> || item['items'] is! List<dynamic>)) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Invalid data type or empty data list.'),
        ),
      );
    }

    // Extract the items list from the data and remove the 'Total' entry
    List<List<dynamic>> itemList = data
        .map((item) => item['items'] as List<dynamic>)
        .where((items) => items[1] != 'Total')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Order', style: TextStyle(fontSize: 25.sp)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                int displayIndex = index + 1;
                var currentItem = itemList[index];

                return Card(
                  color: Colors.blue.shade200,
                  child: ListTile(
                    leading: Text('SL: $displayIndex',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        )),
                    title: Text(
                        'Product: ${currentItem.length > 1 ? currentItem[1] : ""}',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Roll/PCS/Bag'),
                          initialValue: currentItem.length > 2
                              ? currentItem[2]?.toString() ?? ''
                              : '',
                          onChanged: (value) {
                            if (currentItem.length > 2) {
                              currentItem[2] = double.tryParse(value) ?? 0;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Per roll/PCS/Bag'),
                          initialValue: currentItem.length > 3
                              ? currentItem[3]?.toString() ?? ''
                              : '',
                          onChanged: (value) {
                            if (currentItem.length > 3) {
                              currentItem[3] = double.tryParse(value) ?? 0;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Unit'),
                          initialValue: currentItem.length > 4
                              ? currentItem[4]?.toString() ?? ''
                              : '',
                          onChanged: (value) {
                            if (currentItem.length > 4) {
                              currentItem[4] = value;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Per Unit Price'),
                          initialValue: currentItem.length > 5
                              ? currentItem[5]?.toString() ?? ''
                              : '',
                          onChanged: (value) {
                            if (currentItem.length > 5) {
                              currentItem[5] = double.tryParse(value) ?? 0.0;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Remarks'),
                          initialValue: currentItem.length > 8
                              ? currentItem[8]?.toString() ?? ''
                              : '',
                          onChanged: (value) {
                            if (currentItem.length > 8) {
                              currentItem[8] = value;
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () async {
                  List<String> purchaseInfoList = [];
                  double totalAmount = 0.0;
                  var formattedTotalAmount;

                  List<List<dynamic>> invoiceData = [];

                  for (var index = 0; index < itemList.length; index++) {
                    var currentItem = itemList[index];
                    var serialNo = index + 1;

                    //  var product =  'Product: ${currentItem.length > 1 ? currentItem[1] : ""}'
                    var product = currentItem.length > 1
                        ? currentItem[1]?.toString() ?? ''
                        : '';
                    var rollPcsBag = double.tryParse(currentItem.length > 2
                            ? currentItem[2]?.toString() ?? '0'
                            : '0') ??
                        0.0;
                    var perRollPcsBag = double.tryParse(currentItem.length > 3
                            ? currentItem[3]?.toString() ?? '0'
                            : '0') ??
                        0.0;

                    var unit = currentItem.length > 4
                        ? currentItem[4]?.toString() ?? ''
                        : '';
                    var perUnitPrice = double.tryParse(currentItem.length > 5
                            ? currentItem[5]?.toString() ?? '0'
                            : '0') ??
                        0.0;

                    var remarks = currentItem.length > 8
                        ? currentItem[8]?.toString() ?? ''
                        : '';
                    var totalUnit;

                    if (rollPcsBag != 0.0 && perRollPcsBag != 0.0) {
                      totalUnit = rollPcsBag * perRollPcsBag;
                    } else if (rollPcsBag != 0.0) {
                      totalUnit = rollPcsBag;
                    } else if (perRollPcsBag != 0.0) {
                      totalUnit = perRollPcsBag;
                    } else {
                      totalUnit =
                          0.0; // Set a default value or handle the case where both are null
                    }
                    var formatter = NumberFormat('#,##,000.00');
                    var amount = perUnitPrice * totalUnit;
                    var formattedAmount = formatter.format(amount);

                    formattedTotalAmount =
                        formatter.format(totalAmount += amount);

                    List<dynamic> itemData = [
                      serialNo,
                      product,
                      rollPcsBag,
                      perRollPcsBag,
                      unit,
                      perUnitPrice,
                      totalUnit,
                      formattedAmount,
                      remarks,
                    ];

                    invoiceData.add(itemData);

                    String itemInfo = '';
                    itemInfo += 'product: $product\n';
                    itemInfo += 'Roll/PCS/Bag: $rollPcsBag\n';
                    itemInfo += 'Per Roll/PCS/Bag: $perRollPcsBag\n';
                    itemInfo += 'Unit: $unit\n';
                    itemInfo += 'Per Unit Price: $perUnitPrice\n';
                    itemInfo += 'remarks: $remarks\n';

                    itemInfo += '----------------\n';

                    purchaseInfoList.add(itemInfo);
                  }
                  for (var i = 0; i < 1; i++) {
                    var itemData = [
                      '',
                      'Total',
                      '',
                      '',
                      '',
                      '',
                      '',
                      formattedTotalAmount,
                      ''
                    ];
                    invoiceData.add(itemData);
                  }

                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Update Delivery Order',
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: purchaseInfoList
                                .map((info) => Text(info))
                                .toList(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              // bool bookedSuccessfully = await controller
                              //     .removepreviousBooking(previousdata!);

                              // if (bookedSuccessfully) {
                              //   bool savedSuccessfully =
                              //       await controller.updateBooking(invoiceData);
                              //   if (savedSuccessfully) {
                              controller.updateDeliveryOrderFields(
                                  doNo!, invoiceData, totalAmount);
                              // }

                              // print('bookedSuccessfully');
                              // }
                              /// Parse string to integer

                              // print(
                              //     'invoice data is ${totalAmount.runtimeType}');

                              Navigator.of(context).pop();
                            },
                            // child: Obx(
                            //   () => controller.isSendingEmail.value
                            //       ? CircularProgressIndicator(
                            //           color: Colors.blue,
                            //         )
                            //       : Text('Confirm'),
                            // ),
                            child: Text('Confirm'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(fontSize: 11.sp),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Update Order',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ))
        ],
      ),
    );
  }
}
