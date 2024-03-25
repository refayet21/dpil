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
        title: Text('DPIL', style: TextStyle(fontSize: 22.sp)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: DropdownButtonFormField<VendorModel>(
              onChanged: (value) {
                selectedVendor = value;
              },
              hint: Text('Select Customer', style: TextStyle(fontSize: 14.sp)),
              isExpanded: true,
              value: selectedVendor,
              items: controller.vendors
                  .map((vendor) => DropdownMenuItem<VendorModel>(
                        value: vendor,
                        child: Text(vendor.name ?? ''),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Delivery Date",
              ),
              readOnly: true,
              onTap: () {
                selectDate(context);
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: controller.cartItems.length,
              itemBuilder: (context, index) {
                while (itemDataList.length <= index) {
                  itemDataList.add({});
                }

                return Card(
                  color: Colors.blue.shade200,
                  child: ListTile(
                    title: Text(
                        'Product Name: ${controller.cartItems[index].name ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                            'Product Stock: ${controller.cartItems[index].stock?.toString()}',
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Roll/PCS/Bag'),
                          onChanged: (value) {
                            itemDataList[index]['quantity'] =
                                double.tryParse(value) ?? 0;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Per roll/PCS/Bag'),
                          onChanged: (value) {
                            itemDataList[index]['perQuantity'] =
                                double.tryParse(value) ?? 0;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Unit'),
                          onChanged: (value) {
                            itemDataList[index]['unit'] = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(labelText: 'Per Unit Price'),
                          onChanged: (value) {
                            itemDataList[index]['perUnitPrice'] =
                                double.tryParse(value) ?? 0.0;
                          },
                        ),
                        SizedBox(height: 10.h),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Remarks'),
                          onChanged: (value) {
                            itemDataList[index]['remarks'] = value;
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                    // trailing: IconButton(
                    //   icon: Icon(Icons.remove_shopping_cart),
                    //   style: ButtonStyle(),
                    //   onPressed: () {
                    //     controller.removeFromCart(controller.cartItems[index]);
                    //   },
                    // ),
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
                    var perUnitPrice =
                        itemDataList[index]['perUnitPrice'] ?? '';
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
                        title: Text(
                          'Delivery Order',
                          style: TextStyle(fontSize: 11.sp),
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
                              String vendorName =
                                  '${selectedVendor?.name ?? ""}';
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
                  'Confirm Order',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ))
        ],
      ),
    );
  }
}
