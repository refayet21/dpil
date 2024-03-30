import 'package:dpil/model/product.dart';
import 'package:grouped_list/grouped_list.dart';
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
      body: GroupedListView<ProductModel, String>(
        elements: controller.productModel,
        groupBy: (element) => element.category!,
        groupSeparatorBuilder: (String category) => Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Text(
            category,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        itemBuilder: (context, ProductModel element) => Card(
          color: Colors.blue.shade200,
          child: ListTile(
            title: Text(
              'Product Name : ${element.name ?? "N/A"}',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  'Category : ${element.category?.toString() ?? "N/A"}',
                ),
                SizedBox(height: 5.h),
                Text(
                  'Stock : ${element.stock?.toString() ?? "N/A"}',
                ),
              ],
            ),
            trailing: IconButton(
              icon: controller.isProductInCart(element)
                  ? Icon(Icons.shopping_cart)
                  : Icon(Icons.add_shopping_cart),
              onPressed: () {
                if (!controller.isProductInCart(element)) {
                  controller.addToCart(element);
                } else {
                  // Optionally, you can handle removing from the cart
                  // controller.removeFromCart(element);
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => CartItemsScreen());
        },
        label: Obx(
          () => Text('Selected Product (${controller.cartItems.length})'),
        ),
      ),
    );
  }
}
