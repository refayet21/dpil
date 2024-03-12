import 'package:dpil/presentation/douser/productcart/cartScreen.dart';
import 'package:dpil/presentation/widgets/do_drawer.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/douser_productcart.controller.dart';

class DouserProductcartScreen extends GetView<DouserProductcartController> {
  const DouserProductcartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DoDrawer(),
      appBar: AppBar(
        title: const Text('DPIL'),
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
                  'Name : ${controller.productModel[index].name ?? "N/A"}',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Unit : ${controller.productModel[index].unit ?? "N/A"}',
                    ),
                    Text(
                      'quantity  : ${controller.productModel[index].quantity ?? "N/A"}',
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
        label: Obx(() => Text('Cart (${controller.cartItems.length})')),
      ),
    );
  }
}
