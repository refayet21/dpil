import 'package:dpil/presentation/douser/productcart/cartScreen.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'controllers/douser_productcart.controller.dart';

class DouserProductcartScreen extends GetView<DouserProductcartController> {
  const DouserProductcartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: Text(
          'Select Product',
          style: TextStyle(fontSize: 25.sp),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.productModel.length,
          itemBuilder: (context, index) {
            // Check if the product is already in the cart
            bool isInCart =
                controller.isProductInCart(controller.productModel[index]);

            return Card(
              color: Colors.blue.shade200,
              child: ListTile(
                title: Text(
                  'Product Name : ${controller.productModel[index].name ?? "N/A"}',
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Category : ${controller.productModel[index].category?.toString() ?? "N/A"}',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      'Stock : ${controller.productModel[index].stock?.toString() ?? "N/A"}',
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: isInCart
                      ? Icon(Icons
                          .shopping_cart) // If in cart, show a different icon
                      : Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    if (!isInCart) {
                      controller.addToCart(controller.productModel[index]);
                    } else {
                      // Optionally, you can handle removing from the cart
                      // controller.removeFromCart(controller.productModel[index]);
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => CartItemsScreen());
        },
        label: Obx(
            () => Text('Selected Product (${controller.cartItems.length})')),
      ),
    );
  }
}
