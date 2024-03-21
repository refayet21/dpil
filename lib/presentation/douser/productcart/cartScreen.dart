// import 'package:dpil/model/vendor.dart';
// import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class CartItemsScreen extends GetView<DouserProductcartController> {
//   // VendorAddController vendorAddController = Get.put(VendorAddController());
//   DouserProductcartController homeController =
//       Get.put(DouserProductcartController());

//   TextEditingController dateController = TextEditingController();

//   VendorModel? selectedVendor;
//   TextEditingController _quantityController = TextEditingController();
//   TextEditingController _perquantityController = TextEditingController();
//   TextEditingController _unitController = TextEditingController();
//   TextEditingController _perUnitPriceController = TextEditingController();
//   //  TextEditingController _quantityController =TextEditingController();

//   Future<void> selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
//       dateController.text = formattedDate;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DPIL'),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           DropdownButtonFormField<VendorModel>(
//             onChanged: (value) {
//               selectedVendor = value;
//             },
//             hint: const Text('Select Customer'),
//             isExpanded: true,
//             value: selectedVendor,
//             items: controller.vendors
//                 .map((vendor) => DropdownMenuItem<VendorModel>(
//                       value: vendor,
//                       child: Text(vendor.name ?? 'N/A'),
//                     ))
//                 .toList(),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           TextField(
//             controller: dateController,
//             decoration: InputDecoration(
//                 icon: Icon(Icons.calendar_today), labelText: "Delivery Date"),
//             readOnly: true,
//             onTap: () {
//               selectDate(context);
//             },
//           ),
//           Expanded(
//             child: Obx(
//               () => ListView.builder(
//                 itemCount: controller.cartItems.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     color: Colors.blue.shade200,
//                     child: ListTile(
//                       title: Text(
//                           'Name: ${controller.cartItems[index].name ?? "N/A"}'),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Stock: ${controller.cartItems[index].stock?.toString()}',
//                           ),

//                           SizedBox(
//                             height: 50.h,
//                             width: 220.w, // Adjust the width as needed
//                             child: TextFormField(
//                               controller: _quantityController,
//                               keyboardType: TextInputType.number,
//                               textAlign: TextAlign.start,
//                               decoration:
//                                   InputDecoration(hintText: 'Roll/PCS/Bag'),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 50.h,
//                             width: 220.w, // Adjust the width as needed
//                             child: TextFormField(
//                               controller: _perquantityController,
//                               keyboardType: TextInputType.number,
//                               textAlign: TextAlign.start,
//                               decoration:
//                                   InputDecoration(hintText: 'Per ROLL/PCS/BAG'),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 50.h,
//                             width: 220.w, // Adjust the width as needed
//                             child: TextFormField(
//                               controller: _unitController,
//                               keyboardType: TextInputType.text,
//                               textAlign: TextAlign.start,
//                               decoration: InputDecoration(hintText: 'Unit'),
//                             ),
//                           ),

//                           SizedBox(
//                             height: 50.h,
//                             width: 220.w, // Adjust the width as needed
//                             child: TextFormField(
//                               controller: _perUnitPriceController,
//                               keyboardType: TextInputType.number,
//                               textAlign: TextAlign.start,
//                               decoration:
//                                   InputDecoration(hintText: 'Per Unit Price'),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           )

//                           // Column(
//                           //   children: [
//                           //     Row(
//                           //       mainAxisAlignment: MainAxisAlignment.start,
//                           //       children: [
//                           //         // IconButton(
//                           //         //   icon: Icon(Icons.remove),
//                           //         //   onPressed: () {
//                           //         //     controller.decreaseQuantity(
//                           //         //         controller.cartItems[index]);
//                           //         //     _quantityController.text = controller
//                           //         //         .cartItems[index].quantity
//                           //         //         .toString();
//                           //         //   },
//                           //         // ),
//                           //         SizedBox(
//                           //           width: 150.w, // Adjust the width as needed
//                           //           child: TextFormField(
//                           //             controller: _quantityController,
//                           //             keyboardType: TextInputType.number,
//                           //             textAlign: TextAlign.start,
//                           //             decoration: InputDecoration(
//                           //                 hintText: 'Required Qty'),
//                           //             // onChanged: (newValue) {
//                           //             //   // Update the quantity when the user changes the value
//                           //             //   controller.updateQuantity(
//                           //             //       controller.cartItems[index],
//                           //             //       int.parse(newValue));
//                           //             // },
//                           //           ),
//                           //         ),

//                           //         // IconButton(
//                           //         //   icon: Icon(Icons.add),
//                           //         //   onPressed: () {
//                           //         //     controller.increaseQuantity(
//                           //         //         controller.cartItems[index]);
//                           //         //     _quantityController.text = controller
//                           //         //         .cartItems[index].quantity
//                           //         //         .toString();
//                           //         //   },
//                           //         // ),
//                           //       ],
//                           //     ),
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon:
//                             Icon(Icons.remove_shopping_cart, color: Colors.red),
//                         onPressed: () {
//                           controller
//                               .removeFromCart(controller.cartItems[index]);
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               List<String> purchaseInfoList = [];
//               double totalAmount = 0.0;

//               String vendorName =
//                   'Customer Name: ${selectedVendor?.name ?? "N/A"}';
//               String vendorAddress =
//                   'Customer address: ${selectedVendor?.address ?? "N/A"}';
//               String dateInfo = 'Delivery Date: ${dateController.text}';
//               purchaseInfoList.add('$vendorName\n$vendorAddress\n$dateInfo\n');

//               List<List<dynamic>> invoiceData = [];

//               for (var index = 0;
//                   index < controller.cartItems.length;
//                   index++) {
//                 var item = controller.cartItems[index];
//                 var serialNo = index + 1;

//                 // Add null checks for quantity and unitQty before performing multiplication
//                 // var quantity = item.quantity ?? 0;
//                 // var unitQty = item.unitqty ?? 0;

//                 // var bagTotal =
//                 //     NumberFormat.decimalPattern().format(quantity * unitQty);
//                 // var amount = NumberFormat.decimalPattern()
//                 //     .format((item.rate ?? 1) * (quantity * unitQty));
//                 // totalAmount += (item.rate ?? 1) * (quantity * unitQty);

//                 List<dynamic> itemData = [
//                   serialNo,
//                   item.name ?? 'N/A',
//                   // quantity,
//                   // unitQty,
//                   // bagTotal,
//                   // // item.rate != null ? item.rate.toString() : 'N/A',
//                   // amount,
//                 ];

//                 invoiceData.add(itemData);

//                 // Item info remains unchanged
//                 String itemInfo = '';
//                 itemInfo += 'Serial No: $serialNo\n';
//                 itemInfo += 'Product Name: ${item.name ?? "N/A"}\n';
//                 // itemInfo += 'Unit: ${item.unit ?? "N/A"}\n';
//                 // itemInfo += 'totalunit: ${item.totalunit ?? "N/A"}\n';
//                 // itemInfo += 'unitqty: ${item.unitqty ?? "N/A"}\n';
//                 // itemInfo += 'rate: ${item.rate ?? "N/A"}\n';
//                 itemInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
//                 itemInfo += 'Sell Amount: ${(item.quantity).toString()}\n';
//                 itemInfo += '---\n';

//                 purchaseInfoList.add(itemInfo);
//               }

//               await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Previous Delivery Order'),
//                     content: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children:
//                             purchaseInfoList.map((info) => Text(info)).toList(),
//                       ),
//                     ),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () async {
//                           String vendorName =
//                               '${selectedVendor?.name ?? "N/A"}';
//                           String vendorAddress =
//                               '${selectedVendor?.address ?? "N/A"}';
//                           String contactPerson =
//                               '${selectedVendor?.contactperson ?? "N/A"}';
//                           String vendorMobile =
//                               '${selectedVendor?.mobile ?? "N/A"}';

//                           // homeController.generateInvoicePdf(
//                           //     // 'Test user',
//                           //     vendorName,
//                           //     vendorAddress,
//                           //     contactPerson,
//                           //     vendorMobile,
//                           //     controller.cartItems[0].unit,
//                           //     controller.cartItems[0].totalunit,
//                           //     invoiceData,
//                           //     NumberFormat.decimalPattern().format(totalAmount),
//                           //     totalAmount.toInt(),
//                           // dateController.text
//                           // );

//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Confirm'),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Text('Cancel'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             child: Text('Confirm Order'),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:dpil/model/vendor.dart';
// import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class CartItemsScreen extends GetView<DouserProductcartController> {
//   DouserProductcartController homeController =
//       Get.put(DouserProductcartController());

//   TextEditingController dateController = TextEditingController();

//   VendorModel? selectedVendor;

//   List<Map<String, dynamic>> itemDataList = [];

//   Future<void> selectDate(BuildContext context) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
//       dateController.text = formattedDate;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('DPIL'),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           DropdownButtonFormField<VendorModel>(
//             onChanged: (value) {
//               selectedVendor = value;
//             },
//             hint: const Text('Select Customer'),
//             isExpanded: true,
//             value: selectedVendor,
//             items: controller.vendors
//                 .map((vendor) => DropdownMenuItem<VendorModel>(
//                       value: vendor,
//                       child: Text(vendor.name ?? 'N/A'),
//                     ))
//                 .toList(),
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           TextField(
//             controller: dateController,
//             decoration: InputDecoration(
//                 icon: Icon(Icons.calendar_today), labelText: "Delivery Date"),
//             readOnly: true,
//             onTap: () {
//               selectDate(context);
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: controller.cartItems.length,
//               itemBuilder: (context, index) {
//                 // Ensure that itemDataList has data for each item in the cart
//                 while (itemDataList.length <= index) {
//                   itemDataList.add({});
//                 }

//                 return Card(
//                   color: Colors.blue.shade200,
//                   child: ListTile(
//                     title: Text(
//                         'Name: ${controller.cartItems[index].name ?? "N/A"}'),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Stock: ${controller.cartItems[index].stock?.toString()}',
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(labelText: 'Quantity'),
//                           onChanged: (value) {
//                             itemDataList[index]['quantity'] = value;
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration:
//                               InputDecoration(labelText: 'Per Quantity'),
//                           onChanged: (value) {
//                             itemDataList[index]['perQuantity'] = value;
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           decoration: InputDecoration(labelText: 'Unit'),
//                           onChanged: (value) {
//                             itemDataList[index]['unit'] = value;
//                           },
//                         ),
//                         SizedBox(height: 10),
//                         TextFormField(
//                           keyboardType: TextInputType.number,
//                           decoration:
//                               InputDecoration(labelText: 'Per Unit Price'),
//                           onChanged: (value) {
//                             itemDataList[index]['perUnitPrice'] = value;
//                           },
//                         ),
//                         SizedBox(height: 10),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       icon: Icon(Icons.remove_shopping_cart),
//                       onPressed: () {
//                         controller.removeFromCart(controller.cartItems[index]);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               print('Order Data:');
//               itemDataList.forEach((itemData) {
//                 print('Quantity: ${itemData['quantity']}');
//                 print('Per Quantity: ${itemData['perQuantity']}');
//                 print('Unit: ${itemData['unit']}');
//                 print('Per Unit Price: ${itemData['perUnitPrice']}');
//                 print('-------------');
//               });
//             },
//             child: Text('Confirm Order'),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartItemsScreen extends GetView<DouserProductcartController> {
  DouserProductcartController controller =
      Get.put(DouserProductcartController());
  TextEditingController dateController = TextEditingController();

  VendorModel? selectedVendor;

  List<Map<String, dynamic>> itemDataList = [];

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      dateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DPIL'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<VendorModel>(
              onChanged: (value) {
                selectedVendor = value;
              },
              hint: const Text('Select Customer'),
              isExpanded: true,
              value: selectedVendor,
              items: controller.vendors
                  .map((vendor) => DropdownMenuItem<VendorModel>(
                        value: vendor,
                        child: Text(vendor.name ?? ''),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today), labelText: "Delivery Date"),
              readOnly: true,
              onTap: () {
                selectDate(context);
              },
            ),
            SizedBox(
              height: 430.h, // Set a specific height for the ListView
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  // Ensure that itemDataList has data for each item in the cart
                  while (itemDataList.length <= index) {
                    itemDataList.add({});
                  }

                  return Card(
                    color: Colors.blue.shade200,
                    child: ListTile(
                      title: Text(
                          'Product Name: ${controller.cartItems[index].name ?? "N/A"}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Stock Qty: ${controller.cartItems[index].stock?.toString()}',
                          ),
                          SizedBox(height: 10),
                          // TextFormField(
                          //   keyboardType: TextInputType.number,
                          //   decoration:
                          //       InputDecoration(labelText: 'Roll/PCS/Bag'),
                          //   onChanged: (value) {
                          //     itemDataList[index]['quantity'] = value;
                          //   },
                          // ),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Roll/PCS/Bag'),
                            onChanged: (value) {
                              itemDataList[index]['quantity'] =
                                  int.tryParse(value) ?? 0;
                            },
                          ),
                          SizedBox(height: 10),
                          // TextFormField(
                          //   keyboardType: TextInputType.number,
                          //   decoration:
                          //       InputDecoration(labelText: 'Per roll/PCS/Bag'),
                          //   onChanged: (value) {
                          //     itemDataList[index]['perQuantity'] = value;
                          //   },
                          // ),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Per roll/PCS/Bag'),
                            onChanged: (value) {
                              itemDataList[index]['perQuantity'] =
                                  int.tryParse(value) ?? 0;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Unit'),
                            onChanged: (value) {
                              itemDataList[index]['unit'] = value;
                            },
                          ),
                          SizedBox(height: 10),
                          // TextFormField(
                          //   keyboardType: TextInputType.number,
                          //   decoration:
                          //       InputDecoration(labelText: 'Per Unit Price'),
                          //   onChanged: (value) {
                          //     itemDataList[index]['perUnitPrice'] = value;
                          //   },
                          // ),

                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Per Unit Price'),
                            onChanged: (value) {
                              itemDataList[index]['perUnitPrice'] =
                                  double.tryParse(value) ?? 0.0;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Remarks'),
                            onChanged: (value) {
                              itemDataList[index]['remarks'] = value;
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          controller
                              .removeFromCart(controller.cartItems[index]);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                List<String> purchaseInfoList = [];
                double totalAmount = 0.0;

                String vendorName =
                    'Customer Name: ${selectedVendor?.name ?? ""}';
                String vendorAddress =
                    'Customer address: ${selectedVendor?.address ?? ""}';
                String dateInfo = 'Delivery Date: ${dateController.text}';
                purchaseInfoList
                    .add('$vendorName\n$vendorAddress\n$dateInfo\n');

                List<List<dynamic>> invoiceData = [];

                for (var index = 0;
                    index < controller.cartItems.length;
                    index++) {
                  var item = controller.cartItems[index];
                  var serialNo = index + 1;

                  var quantity = itemDataList[index]['quantity'] ?? '';
                  var perQuantity = itemDataList[index]['perQuantity'] ?? '';
                  var unit = itemDataList[index]['unit'] ?? '';
                  var perUnitPrice = itemDataList[index]['perUnitPrice'] ?? '';
                  var totalUnit = quantity * perQuantity;
                  var amount = perUnitPrice * (quantity * perQuantity);

                  var remarks = itemDataList[index]['remarks'] ?? '';

                  totalAmount += amount;

                  List<dynamic> itemData = [
                    serialNo,
                    item.name ?? '',
                    quantity,
                    perQuantity,
                    unit,
                    perUnitPrice,
                    totalUnit,
                    amount,
                    remarks
                  ];

                  invoiceData.add(itemData);

                  String itemInfo = '';
                  itemInfo += 'Serial No: $serialNo\n';
                  itemInfo += 'Product Name: ${item.name ?? ""}\n';
                  itemInfo += 'Stock Qty: ${item.stock?.toString() ?? ""}\n';
                  itemInfo += 'Roll/PCS/Bag: $quantity\n';
                  itemInfo += 'Per Roll/PCS/Bag: $perQuantity\n';
                  itemInfo += 'Unit: $unit\n';
                  itemInfo += 'Per Unit Price: $perUnitPrice\n';
                  itemInfo += 'Remarks: $remarks\n';
                  itemInfo += '---\n';

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
                    totalAmount,
                    ''
                  ];
                  invoiceData.add(itemData);
                }

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delivery Order'),
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
                            String vendorName = '${selectedVendor?.name ?? ""}';
                            String vendorAddress =
                                '${selectedVendor?.address ?? ""}';
                            String contactPerson =
                                '${selectedVendor?.contactperson ?? ""}';
                            String vendorMobile =
                                '${selectedVendor?.mobile ?? ""}';

                            controller.generateInvoicePdf(
                              vendorName,
                              vendorAddress,
                              contactPerson,
                              vendorMobile,
                              invoiceData,
                              // totalAmount,
                              25,
                              dateController.text,
                            );

                            Navigator.of(context).pop();
                          },
                          child: Text('Confirm'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Confirm Order'),
            )
          ],
        ),
      ),
    );
  }
}
