import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/douser/invoice/controllers/douser_invoice.controller.dart';
import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartItemsScreen extends GetView<DouserProductcartController> {
  // VendorAddController vendorAddController = Get.put(VendorAddController());
  DouserProductcartController homeController =
      Get.put(DouserProductcartController());

  TextEditingController dateController = TextEditingController();

  VendorModel? selectedVendor;

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
      body: Column(
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
                      child: Text(vendor.name ?? 'N/A'),
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
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  TextEditingController _quantityController =
                      TextEditingController(
                          text:
                              controller.cartItems[index].quantity.toString());

                  return Card(
                    color: Colors.blue.shade200,
                    child: ListTile(
                      title: Text(
                          'Name: ${controller.cartItems[index].name ?? "N/A"}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unit: ${controller.cartItems[index].unit ?? "N/A"}',
                          ),
                          Text(
                            'totalunit: ${controller.cartItems[index].totalunit ?? "N/A"}',
                          ),
                          Text(
                            'unitqty: ${controller.cartItems[index].unitqty?.toString()}',
                          ),
                          Text(
                            'rate: ${controller.cartItems[index].rate?.toString()}',
                          ),
                          Text(
                            'Stock: ${controller.cartItems[index].stock?.toString()}',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  controller.decreaseQuantity(
                                      controller.cartItems[index]);
                                  _quantityController.text = controller
                                      .cartItems[index].quantity
                                      .toString();
                                },
                              ),
                              SizedBox(
                                width: 50, // Adjust the width as needed
                                child: TextFormField(
                                  controller: _quantityController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (newValue) {
                                    // Update the quantity when the user changes the value
                                    controller.updateQuantity(
                                        controller.cartItems[index],
                                        int.parse(newValue));
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  controller.increaseQuantity(
                                      controller.cartItems[index]);
                                  _quantityController.text = controller
                                      .cartItems[index].quantity
                                      .toString();
                                },
                              ),
                            ],
                          ),
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
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       await controller.addPurchaseData(
          //         vendorDocId: selectedVendor!.docId,
          //         date: dateController.text,
          //         cartItems: controller.cartItems
          //             .map((item) => item.toJson())
          //             .toList(),
          //       );
          //     },
          //     // print('address: ${selectedVendor!.address}');
          //     // print('docId: ${selectedVendor!.docId}');
          //     // print('Date is : ${dateController.text}');

          //     // for (var item in controller.cartItems) {
          //     //   print('docId cart: ${item.docId ?? "N/A"}');
          //     //   print('Name: ${item.name ?? "N/A"}');
          //     //   print('Unit: ${item.unit ?? "N/A"}');
          //     //   print('Purchase Price: ${item.pPrice?.toString() ?? "N/A"}');
          //     //   print('Stock: ${item.stock?.toString() ?? "N/A"}');
          //     //   print('Quantity: ${item.quantity.toString()}');
          //     //   print('---'); // Separator between items, for clarity
          //     // }

          //     child: Text('Confirm Purchase'))

          // ElevatedButton(
          //   onPressed: () async {
          //     // Create a string to hold all the information
          //     String purchaseInfo = '';

          //     // Add vendor and date information
          //     purchaseInfo += 'Vendor Name: ${selectedVendor?.name ?? "N/A"}\n';
          //     purchaseInfo += 'Date: ${dateController.text}\n\n';

          //     // Add cart items information
          //     for (var item in controller.cartItems) {
          //       purchaseInfo += 'Product Name: ${item.name ?? "N/A"}\n';
          //       purchaseInfo += 'Unit: ${item.unit ?? "N/A"}\n';
          //       purchaseInfo +=
          //           'Purchase Price: ${item.pPrice?.toString() ?? "N/A"}\n';
          //       purchaseInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
          //       purchaseInfo +=
          //           'New Stock: ${(item.stock ?? 0) + item.quantity}\n'; // Use 0 as default value for item.stock
          //       purchaseInfo += '---\n'; // Separator between items, for clarity
          //     }

          //     // Show the dialog with the purchase information
          //     await showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Purchase Confirmation'),
          //           content: SingleChildScrollView(
          //             child: Text(purchaseInfo),
          //           ),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () {
          //                 // Continue with the purchase confirmation
          // controller.addPurchaseData(
          //   vendorDocId: selectedVendor!.docId,
          //   date: dateController.text,
          //   cartItems: controller.cartItems
          //       .map((item) => item.toJson())
          //       .toList(),
          // );

          //                 // Additional print statements
          //                 // print('address: ${selectedVendor!.address}');
          //                 // print('docId: ${selectedVendor!.docId}');
          //                 // print('Date is : ${dateController.text}');

          //                 // for (var item in controller.cartItems) {
          //                 //   print('docId cart: ${item.docId ?? "N/A"}');
          //                 //   print('Name: ${item.name ?? "N/A"}');
          //                 //   print('Unit: ${item.unit ?? "N/A"}');
          //                 //   print(
          //                 //       'Purchase Price: ${item.pPrice?.toString() ?? "N/A"}');
          //                 //   print('Stock: ${item.stock?.toString() ?? "N/A"}');
          //                 //   print(
          //                 //       'New Stock: ${(item.stock ?? 0) + item.quantity}\n'); // Use 0 as default value for item.stock
          //                 //   print(
          //                 //       '---'); // Separator between items, for clarity
          //                 // }

          //                 // Close the dialog
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Confirm'),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 // Close the dialog without saving
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Cancel'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          //   child: Text('Confirm Purchase'),
          // ),

          // ElevatedButton(
          //   onPressed: () async {
          //     // Create a string to hold all the information
          //     String purchaseInfo = '';

          //     // Add vendor and date information
          //     purchaseInfo += 'Vendor Name: ${selectedVendor?.name ?? "N/A"}\n';
          //     purchaseInfo += 'Date: ${dateController.text}\n\n';

          //     // Add cart items information
          //     for (var item in controller.cartItems) {
          //       purchaseInfo += 'Product Name: ${item.name ?? "N/A"}\n';
          //       purchaseInfo += 'Unit: ${item.unit ?? "N/A"}\n';
          //       purchaseInfo +=
          //           'Purchase Price: ${item.pPrice?.toString() ?? "N/A"}\n';
          //       purchaseInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
          //       purchaseInfo +=
          //           'New Stock: ${(item.stock ?? 0) + item.quantity}\n'; // Use 0 as default value for item.stock
          //       purchaseInfo += '---\n'; // Separator between items, for clarity
          //     }

          //     // Show the dialog with the purchase information
          //     await showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Purchase Confirmation'),
          //           content: SingleChildScrollView(
          //             child: Text(purchaseInfo),
          //           ),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () async {
          //                 // Continue with the purchase confirmation
          //                 await controller.addPurchaseData(
          //                   vendorDocId: selectedVendor!.docId,
          //                   date: dateController.text,
          //                   cartItems: controller.cartItems
          //                       .map((item) => item.toJson())
          //                       .toList(),
          //                   purchaseInfo:
          //                       purchaseInfo, // Pass purchaseInfo here
          //                 );

          //                 // Additional print statements
          //                 print('address: ${selectedVendor!.address}');
          //                 print('docId: ${selectedVendor!.docId}');
          //                 print('Date is : ${dateController.text}');

          //                 for (var item in controller.cartItems) {
          //                   print('docId cart: ${item.docId ?? "N/A"}');
          //                   print('Name: ${item.name ?? "N/A"}');
          //                   print('Unit: ${item.unit ?? "N/A"}');
          //                   print(
          //                       'Purchase Price: ${item.pPrice?.toString() ?? "N/A"}');
          //                   print('Stock: ${item.stock?.toString() ?? "N/A"}');
          //                   print(
          //                       'New Stock: ${(item.stock ?? 0) + item.quantity}\n'); // Use 0 as default value for item.stock
          //                   print(
          //                       '---'); // Separator between items, for clarity
          //                 }

          //                 // Close the dialog
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Confirm'),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 // Close the dialog without saving
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Cancel'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          //   child: Text('Confirm Purchase'),
          // ),

          // ElevatedButton(
          //   onPressed: () async {
          //     // Create a list to hold purchaseInfo data for each item
          //     List<String> purchaseInfoList = [];

          //     var serialno;

          //     // Add vendor and date information
          //     String vendorName =
          //         'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
          //     String vendorAddress =
          //         'Vendor address: ${selectedVendor?.address ?? "N/A"}';

          //     String dateInfo = 'Date: ${dateController.text}';
          //     purchaseInfoList.add('$vendorName\n$vendorAddress\n$dateInfo\n');

          //     // Add cart items information
          //     for (var index = 0;
          //         index < controller.cartItems.length;
          //         index++) {
          //       serialno = index + 1;
          //       var item = controller.cartItems[index];

          //       String itemInfo = '';
          //       itemInfo += 'Product Name: ${item.name ?? "N/A"}\n';
          //       itemInfo += 'Unit: ${item.unit ?? "N/A"}\n';
          //       itemInfo += 'totalunit: ${item.totalunit ?? "N/A"}\n';
          //       itemInfo += 'unitqty: ${item.unitqty ?? "N/A"}\n';
          //       itemInfo += 'rate: ${item.rate ?? "N/A"}\n';
          //       itemInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
          //       itemInfo += 'Sell Amount: ${(item.quantity).toString()}\n';
          //       itemInfo += '---\n'; // Separator between items, for clarity

          //       // Add the purchaseInfo data to the list
          //       purchaseInfoList.add(itemInfo);
          //     }

          //     // Show a dialog with the previous purchase information
          //     await showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Previous Purchase Information'),
          //           content: SingleChildScrollView(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children:
          //                   purchaseInfoList.map((info) => Text(info)).toList(),
          //             ),
          //           ),
          //           actions: <Widget>[
          //             TextButton(
          //               onPressed: () async {
          //                 // Continue with the purchase confirmation using updated cart items
          //                 // await controller.addPurchaseData(
          //                 //   vendorDocId: selectedVendor!.docId,
          //                 //   date: dateController.text,
          //                 //   cartItems: controller.cartItems
          //                 //       .map((item) => item.toJson())
          //                 //       .toList(),
          //                 // );
          //                 String vendorName =
          //                     '${selectedVendor?.name ?? "N/A"}';
          //                 String vendorAddress =
          //                     '${selectedVendor?.address ?? "N/A"}';
          //                 String contactPerson =
          //                     '${selectedVendor?.contactperson ?? "N/A"}';
          //                 String vendorMobile =
          //                     '${selectedVendor?.mobile ?? "N/A"}';

          //                 homeController.generateInvoicePdf(
          //                   'John Doe',
          //                   vendorName,
          //                   vendorAddress,
          //                   contactPerson,
          //                   vendorMobile,
          //                   controller.cartItems[0].unit,
          //                   controller.cartItems[0].totalunit,
          //                   controller.cartItems
          //                       .map((item) => [
          //                             serialno,
          //                             item.name ?? 'N/A',
          //                             item.unitqty ?? 'N/A',
          //                             item.totalunit ?? 'N/A',
          //                             item.rate != null
          //                                 ? item.rate.toString()
          //                                 : 'N/A', // Ensure rate is converted to String
          //                           ])
          //                       .toList(),
          //                 );

          //                 // Close the dialog
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Confirm'),
          //             ),
          //             TextButton(
          //               onPressed: () {
          //                 // Close the dialog without saving
          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('Cancel'),
          //             ),
          //           ],
          //         );
          //       },
          //     );
          //   },
          //   child: Text('Confirm Purchase'),
          // )

          ElevatedButton(
            onPressed: () async {
              List<String> purchaseInfoList = [];
              double totalAmount = 0.0;

              String vendorName =
                  'Customer Name: ${selectedVendor?.name ?? "N/A"}';
              String vendorAddress =
                  'Customer address: ${selectedVendor?.address ?? "N/A"}';
              String dateInfo = 'Delivery Date: ${dateController.text}';
              purchaseInfoList.add('$vendorName\n$vendorAddress\n$dateInfo\n');

              List<List<dynamic>> invoiceData = [];

              for (var index = 0;
                  index < controller.cartItems.length;
                  index++) {
                var item = controller.cartItems[index];
                var serialNo = index + 1;

                // Add null checks for quantity and unitQty before performing multiplication
                var quantity = item.quantity ?? 0;
                var unitQty = item.unitqty ?? 0;

                var bagTotal =
                    NumberFormat.decimalPattern().format(quantity * unitQty);
                var amount = NumberFormat.decimalPattern()
                    .format((item.rate ?? 1) * (quantity * unitQty));
                totalAmount += (item.rate ?? 1) * (quantity * unitQty);

                List<dynamic> itemData = [
                  serialNo,
                  item.name ?? 'N/A',
                  quantity,
                  unitQty,
                  bagTotal,
                  item.rate != null ? item.rate.toString() : 'N/A',
                  amount,
                ];

                invoiceData.add(itemData);

                // Item info remains unchanged
                String itemInfo = '';
                itemInfo += 'Serial No: $serialNo\n';
                itemInfo += 'Product Name: ${item.name ?? "N/A"}\n';
                itemInfo += 'Unit: ${item.unit ?? "N/A"}\n';
                itemInfo += 'totalunit: ${item.totalunit ?? "N/A"}\n';
                itemInfo += 'unitqty: ${item.unitqty ?? "N/A"}\n';
                itemInfo += 'rate: ${item.rate ?? "N/A"}\n';
                itemInfo += 'Stock: ${item.stock?.toString() ?? "N/A"}\n';
                itemInfo += 'Sell Amount: ${(item.quantity).toString()}\n';
                itemInfo += '---\n';

                purchaseInfoList.add(itemInfo);
              }

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Previous Delivery Order'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            purchaseInfoList.map((info) => Text(info)).toList(),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          String vendorName =
                              '${selectedVendor?.name ?? "N/A"}';
                          String vendorAddress =
                              '${selectedVendor?.address ?? "N/A"}';
                          String contactPerson =
                              '${selectedVendor?.contactperson ?? "N/A"}';
                          String vendorMobile =
                              '${selectedVendor?.mobile ?? "N/A"}';

                          homeController.generateInvoicePdf(
                            'Test user',
                            vendorName,
                            vendorAddress,
                            contactPerson,
                            vendorMobile,
                            controller.cartItems[0].unit,
                            controller.cartItems[0].totalunit,
                            invoiceData,
                            totalAmount,
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
    );
  }
}
