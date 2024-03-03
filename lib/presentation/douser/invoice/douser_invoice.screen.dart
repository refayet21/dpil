import 'package:dpil/model/vendor.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_invoice.controller.dart';

class DouserInvoiceScreen extends GetView<DouserInvoiceController> {
  DouserInvoiceScreen({Key? key}) : super(key: key);
  DouserInvoiceController homeController = Get.put(DouserInvoiceController());
  TextEditingController dateController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productQuantityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  VendorModel? selectedVendor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: const Text('DouserInvoiceScreen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => DropdownButtonFormField<VendorModel>(
                  onChanged: (value) {
                    selectedVendor = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Vendor',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ),
                  isExpanded: true,
                  value: selectedVendor,
                  items: homeController.vendors
                      .map((vendor) => DropdownMenuItem<VendorModel>(
                            value: vendor,
                            child: Text(vendor.name ?? 'N/A'),
                          ))
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: productNameController,
                decoration: InputDecoration(
                  hintText: 'Product Name',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: productPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Product Price',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: productQuantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Product Quantity',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // onPressed: () {
                //   String vendorInfo =
                //       'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
                //   String dateInfo = 'Date: ${dateController.text}';
                //   String productInfo =
                //       'Product Name: ${productNameController.text}';
                //   String priceInfo = 'Price: ${productPriceController.text}';
                //   String quantityInfo =
                //       'Quantity: ${productQuantityController.text}';
                //   String addressInfo = 'Address: ${addressController.text}';

                //   print(
                //     '$vendorInfo\n$dateInfo\n$productInfo\n$priceInfo\n$quantityInfo\n$addressInfo',
                //   );

                //   homeController.generateInvoicePDF(vendorInfo);
                // },
                onPressed: () async {
                  // Get the selected vendor, date, product details from the controllers
                  String vendorInfo =
                      'Vendor Name: ${selectedVendor?.name ?? "N/A"}';
                  final date = dateController.text;
                  final productName = productNameController.text;
                  final productPrice =
                      double.parse(productPriceController.text);
                  final productQuantity =
                      int.parse(productQuantityController.text);

                  // Call the generateInvoicePDF method
                  homeController.generateInvoicePdf(vendorInfo, date,
                      productName, productPrice, productQuantity);
                },
                child: Text('Invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
