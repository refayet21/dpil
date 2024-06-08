import 'package:dpil/model/do_model.dart';
import 'package:dpil/model/douser_model.dart';
import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/douser/productcart/controllers/douser_productcart.controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class CartItemsScreen extends GetView<DouserProductcartController> {
  DouserProductcartController controller =
      Get.put(DouserProductcartController());
  TextEditingController deliverydateController = TextEditingController();
  VendorModel? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

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
      deliverydateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Product (${controller.cartItems.length})',
            style: TextStyle(fontSize: 25.sp)),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanded(
            //   flex: 1,
            //   child: DropdownButtonFormField<VendorModel>(
            //     onChanged: (value) {
            //       selectedVendor = value;
            //     },
            //     hint: Text('Select Customer', style: TextStyle(fontSize: 14.sp)),
            //     isExpanded: true,
            //     value: selectedVendor,
            //     items: controller.vendors
            //         .map((vendor) => DropdownMenuItem<VendorModel>(
            //               value: vendor,
            //               child: Text(vendor.name ?? ''),
            //             ))
            //         .toList(),
            //   ),
            // ),

            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () {
                    // Sort vendors by name
                    controller.vendors
                        .sort((a, b) => a.name!.compareTo(b.name!));

                    return DropdownButton2<VendorModel>(
                      isExpanded: true,
                      hint: Text(
                        'Customer Name',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: controller.vendors
                          .map((item) => DropdownMenuItem<VendorModel>(
                                value: item,
                                child: Text(
                                  item.name!, // Assuming name is the property representing the vendor's name
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: controller.selectedVendor.value,
                      // Inside the onChanged callback of DropdownButton2
                      onChanged: (value) {
                        // print('Selected value: $value');
                        controller.updateSelectedVendor(value);
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 200,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                      ),
                      menuItemStyleData: MenuItemStyleData(
                        height: 40,
                      ),
                      dropdownSearchData: DropdownSearchData(
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Search for an item...',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        // searchMatchFn: (item, searchValue) {
                        //   return item.value.toString().contains(searchValue);
                        // },

                        searchMatchFn: (item, searchValue) {
                          // Check if the item's name contains the search value
                          return item.value!.name!
                              .toLowerCase()
                              .contains(searchValue.toLowerCase());
                        },
                      ),
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
                      },
                    );
                  },
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: Obx(
                () {
                  // Accessing the selectedVendor from the controller's observable
                  VendorModel? selectedVendor = controller.selectedVendor.value;

                  return selectedVendor == null
                      ? Text(
                          'Please Select a customer',
                          style: TextStyle(fontSize: 14, color: Colors.red),
                        )
                      : SizedBox(); // Return an empty SizedBox if a customer is selected
                },
              ),
            ),

            Expanded(
              flex: 1,
              child: TextFormField(
                controller: deliverydateController,
                validator: (value) {
                  return controller.validateDoDate(value!);
                },
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                  ),
                  hintText: "Delivery Date",
                ),
                readOnly: true,
                onTap: () {
                  selectDate(context);
                },
              ),
            ),
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  int displayIndex = index + 1;
                  while (itemDataList.length <= index) {
                    itemDataList.add({});
                  }

                  return Card(
                    color: Colors.blue.shade200,
                    child: ListTile(
                      leading: Text('SL: $displayIndex',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          )),
                      title: Text(
                          'Description: ${controller.cartItems[index].name ?? "N/A"}',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.w700)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.h),
                          Text(
                              'Category: ${controller.cartItems[index].category?.toString()}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 5.h),
                          Text(
                              'Stock in: ${controller.cartItems[index].checkin?.toString()}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              'Stock out: ${controller.cartItems[index].checkout?.toString()}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          Text(
                              'Booked: ${controller.cartItems[index].booked?.toString()}',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(height: 10.h),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return controller.validateRollPcsBag(value!);
                            },
                            decoration:
                                InputDecoration(labelText: 'Roll/PCS/Bag'),
                            initialValue:
                                itemDataList[index]['rollPcsBag']?.toString() ??
                                    '',
                            onChanged: (value) {
                              itemDataList[index]['rollPcsBag'] =
                                  double.tryParse(value) ?? 0;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Per roll/PCS/Bag'),
                            initialValue: itemDataList[index]['perRollPcsBag']
                                    ?.toString() ??
                                '',
                            onChanged: (value) {
                              itemDataList[index]['perRollPcsBag'] =
                                  double.tryParse(value) ?? 0;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Unit'),
                            initialValue:
                                itemDataList[index]['unit']?.toString() ?? '',
                            onChanged: (value) {
                              itemDataList[index]['unit'] = value;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration(labelText: 'Per Unit Price'),
                            initialValue: itemDataList[index]['perUnitPrice']
                                    ?.toString() ??
                                '',
                            onChanged: (value) {
                              itemDataList[index]['perUnitPrice'] =
                                  double.tryParse(value) ?? 0.0;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(labelText: 'Remarks'),
                            initialValue:
                                itemDataList[index]['remarks']?.toString() ??
                                    '',
                            onChanged: (value) {
                              itemDataList[index]['remarks'] = value;
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
                    if (controller.formKey.currentState!.validate()) {
                      if (selectedVendor != null) {
                        List<String> purchaseInfoList = [];
                        double totalAmount = 0.0;
                        var formatedtotalAmount;

                        // Get vendor info
                        String vendorName =
                            'Customer Name: ${selectedVendor!.name ?? ""}';
                        String vendorAddress =
                            'Customer address: ${selectedVendor!.address ?? ""}';
                        String dateInfo =
                            'Delivery Date: ${deliverydateController.text}';
                        purchaseInfoList
                            .add('$vendorName\n$vendorAddress\n$dateInfo\n');

                        // Rest of your code...
                      }
                      // } else {
                      //   // If no vendor is selected, show an error message or handle it accordingly
                      //   // print('No vendor selected');
                      // }
                      List<String> purchaseInfoList = [];
                      double totalAmount = 0.0;
                      var formatedtotalAmount;

                      String vendorName =
                          'Customer Name: ${controller.selectedVendor.value!.name ?? ""}';
                      String vendorAddress =
                          'Customer address: ${controller.selectedVendor.value!.address ?? ""}';
                      String dateInfo =
                          'Delivery Date: ${deliverydateController.text}';
                      purchaseInfoList
                          .add('$vendorName\n$vendorAddress\n$dateInfo\n');

                      List<List<dynamic>> invoiceData = [];

                      // List<List<dynamic>> stockData = [];

                      for (var index = 0;
                          index < controller.cartItems.length;
                          index++) {
                        var item = controller.cartItems[index];
                        var serialNo = index + 1;

                        var rollPcsBag = double.tryParse(
                                itemDataList[index]['rollPcsBag'].toString()) ??
                            0.0;
                        var perRollPcsBag = double.tryParse(itemDataList[index]
                                    ['perRollPcsBag']
                                .toString()) ??
                            0.0;

                        var unit = itemDataList[index]['unit'] ?? '';
                        var perUnitPrice =
                            itemDataList[index]['perUnitPrice'] ?? 0.0;
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
                        var formatedamount = formatter.format(amount);
                        var remarks = itemDataList[index]['remarks'] ?? '';

                        formatedtotalAmount =
                            formatter.format(totalAmount += amount);

                        List<dynamic> itemData = [
                          serialNo,
                          item.name ?? '',
                          rollPcsBag,
                          perRollPcsBag,
                          unit,
                          perUnitPrice,
                          totalUnit,
                          formatedamount,
                          remarks
                        ];
                        // List<dynamic> stockItemData = [
                        //   item.docId ?? '',
                        //   item.name ?? '',
                        //   item.stock ?? '',
                        // ];

                        invoiceData.add(itemData);
                        // stockData.add(stockItemData);

                        String itemInfo = '';
                        itemInfo += 'SL: $serialNo\n';
                        itemInfo += 'Description: ${item.name ?? ""}\n';
                        itemInfo +=
                            'Stock in: ${item.checkin?.toString() ?? ""}\n';
                        itemInfo +=
                            'Stock out: ${item.checkout?.toString() ?? ""}\n';
                        itemInfo +=
                            'Booked: ${item.booked?.toString() ?? ""}\n';
                        itemInfo += 'Roll/PCS/Bag: $rollPcsBag\n';
                        itemInfo += 'Per Roll/PCS/Bag: $perRollPcsBag\n';
                        itemInfo += 'Unit: $unit\n';
                        itemInfo += 'Per Unit Price: $perUnitPrice\n';
                        itemInfo += 'Remarks: $remarks\n';
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
                          // totalAmount,
                          formatedtotalAmount,
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
                              // style: TextStyle(fontSize: 11.sp),
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
                                  final box = GetStorage();
                                  String currentDates = DateFormat('yyyy-MM-dd')
                                      .format(DateTime.now());
                                  DoUserModel? marketingperson =
                                      await controller.getDoUserById(
                                          box.read('employeeId'));

                                  // Retrieve the stored date and docounter value from local storage
                                  String? storedDate = box.read('storedDate');
                                  int docounter = box.read('docounter') ?? 0;

                                  // Check if the stored date matches the current date
                                  if (storedDate != currentDates) {
                                    // Reset the counter to 1
                                    docounter = 0;
                                    // Update the stored date to the current date
                                    await box.write('storedDate', currentDates);
                                  } else {
                                    // Increment the counter if the stored date matches the current date
                                    docounter++;
                                  }

                                  // Save the updated docounter value to local storage
                                  await box.write('docounter', docounter);

                                  docounter++;

                                  final String currentDate = DateTime.now()
                                      .day
                                      .toString()
                                      .padLeft(2, '0');
                                  final String currentMonth = DateTime.now()
                                      .month
                                      .toString()
                                      .padLeft(2, '0');
                                  final String currentYear =
                                      DateTime.now().year.toString();

                                  var firstletter = marketingperson!.name;

                                  final String doNo =
                                      'DPIL-$currentDate-$currentMonth-$currentYear-$firstletter-$docounter';
                                  final String date =
                                      '$currentDate-$currentMonth-$currentYear';
                                  String vendorName =
                                      '${controller.selectedVendor.value!.name ?? ""}';
                                  String vendorAddress =
                                      '${controller.selectedVendor.value!.address ?? ""}';
                                  String contactPerson =
                                      '${controller.selectedVendor.value!.contactperson ?? ""}';
                                  String vendorMobile =
                                      '${controller.selectedVendor.value!.mobile ?? ""}';

                                  bool bookedSuccessfully = await controller
                                      .updateBooking(invoiceData);

                                  if (bookedSuccessfully) {
                                    bool savedSuccessfully =
                                        await controller.saveDeliveryOrder(
                                      DeliveryOrder(
                                        doNo: doNo,
                                        date: date,
                                        userId: marketingperson.docId!,
                                        marketingPerson: marketingperson.name!,
                                        vendorName: vendorName,
                                        vendorAddress: vendorAddress,
                                        contactPerson: contactPerson,
                                        vendorMobile: vendorMobile,
                                        data: invoiceData,
                                        totalInWord: totalAmount,
                                        deliveryDate:
                                            deliverydateController.text,
                                      ),
                                    );
                                    if (savedSuccessfully) {
                                      controller.generateInvoicePdf(
                                        doNo,
                                        date,
                                        marketingperson.docId!,
                                        marketingperson.name!,
                                        vendorName,
                                        vendorAddress,
                                        contactPerson,
                                        vendorMobile,
                                        invoiceData,
                                        totalAmount,
                                        deliverydateController.text,
                                      );
                                    }
                                  }

                                  // print('invoiceData is $invoiceData');

                                  Navigator.of(context).pop();
                                },
                                child: Obx(
                                  () => controller.isSendingEmail.value
                                      ? CircularProgressIndicator(
                                          color: Colors.blue,
                                        )
                                      : Text('Confirm'),
                                ),
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
                    }
                  },
                  child: Text(
                    'Confirm Order',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
