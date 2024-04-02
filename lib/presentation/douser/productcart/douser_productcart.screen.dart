//working code

// import 'package:dpil/presentation/douser/productcart/cartScreen.dart';
// import 'package:dpil/presentation/widgets/do_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:get/get.dart';

// import 'controllers/douser_productcart.controller.dart';

// class DouserProductcartScreen extends GetView<DouserProductcartController> {
//   const DouserProductcartScreen({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DoDrawer(),
//       appBar: AppBar(
//         title: Text(
//           'Select Product',
//           style: TextStyle(fontSize: 25.sp),
//         ),
//         centerTitle: true,
//       ),
//       body: Obx(
//         () => ListView.builder(
//           itemCount: controller.productModel.length,
//           itemBuilder: (context, index) {
//             // Check if the product is already in the cart
//             bool isInCart =
//                 controller.isProductInCart(controller.productModel[index]);

//             return Card(
//               color: Colors.blue.shade200,
//               child: ListTile(
//                 title: Text(
//                   'Product Name : ${controller.productModel[index].name ?? "N/A"}',
//                   style:
//                       TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Text(
//                       'Category : ${controller.productModel[index].category?.toString() ?? "N/A"}',
//                     ),
//                     Text(
//                       'Checkin : ${controller.productModel[index].checkin ?? "N/A"}',
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Text(
//                       'Checkout : ${controller.productModel[index].checkout ?? "N/A"}',
//                     ),
//                     SizedBox(
//                       height: 5.h,
//                     ),
//                     Text(
//                       'Booked : ${controller.productModel[index].booked ?? "N/A"}',
//                     ),
//                   ],
//                 ),
//                 trailing: IconButton(
//                   icon: isInCart
//                       ? Icon(Icons
//                           .shopping_cart) // If in cart, show a different icon
//                       : Icon(Icons.add_shopping_cart),
//                   onPressed: () {
//                     if (!isInCart) {
//                       controller.addToCart(controller.productModel[index]);
//                     } else {
//                       // Optionally, you can handle removing from the cart
//                       // controller.removeFromCart(controller.productModel[index]);
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Get.to(() => CartItemsScreen());
//         },
//         label: Obx(
//             () => Text('Selected Product (${controller.cartItems.length})')),
//       ),
//     );
//   }
// }

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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: TextFormField(
              onChanged: (value) => controller.searchProduct(value),
              decoration: InputDecoration(
                hintText: "Search  By Product Name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0.r)),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.foundProduct.length,
                itemBuilder: (context, index) {
                  bool isInCart = controller
                      .isProductInCart(controller.foundProduct[index]);
                  return Card(
                    color: Colors.blue.shade200,
                    child: ListTile(
                      title: Text(
                        'Product Name : ${controller.foundProduct[index].name ?? "N/A"}',
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Category : ${controller.foundProduct[index].category?.toString() ?? "N/A"}',
                          ),
                          Text(
                            'Checkin : ${controller.foundProduct[index].checkin ?? "N/A"}',
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Checkout : ${controller.foundProduct[index].checkout ?? "N/A"}',
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            'Booked : ${controller.foundProduct[index].booked ?? "N/A"}',
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: isInCart
                            ? Icon(Icons.shopping_cart)
                            : Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          if (!isInCart) {
                            controller
                                .addToCart(controller.foundProduct[index]);
                          } else {
                            // Optionally, you can handle removing from the cart
                            // controller.removeFromCart(controller.filteredProducts[index]);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
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



// previous code 

// import 'package:dpil/model/product.dart';
// import 'package:dpil/presentation/douser/productcart/cartScreen.dart';
// import 'package:dpil/presentation/widgets/do_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import 'controllers/douser_productcart.controller.dart';

// class DouserProductcartScreen extends GetView<DouserProductcartController> {
//   const DouserProductcartScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: DoDrawer(),
//       appBar: AppBar(
//         title: Text(
//           'Select Product',
//           style: TextStyle(fontSize: 25.sp),
//         ),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<Map<String, List<ProductModel>>>(
//         stream: controller.getAllProductsGroupedByCategory(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             final groupedProducts = snapshot.data!;
//             return ListView.builder(
//               itemCount: groupedProducts.length,
//               itemBuilder: (context, index) {
//                 final category = groupedProducts.keys.elementAt(index);
//                 final products = groupedProducts[category]!;
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       child: Text(
//                         category,
//                         style: TextStyle(
//                           fontSize: 20.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];
//                         bool isInCart = controller.isProductInCart(product);
//                         return Card(
//                           color: Colors.blue.shade200,
//                           child: ListTile(
//                             title: Text(
//                               'Product Name : ${product.name ?? "N/A"}',
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'Category : ${product.category ?? "N/A"}',
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'Checkin : ${product.checkin ?? "N/A"}',
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'Checkout : ${product.checkout ?? "N/A"}',
//                                 ),
//                                 SizedBox(
//                                   height: 5.h,
//                                 ),
//                                 Text(
//                                   'Booked : ${product.booked ?? "N/A"}',
//                                 ),
//                               ],
//                             ),
//                             trailing: IconButton(
//                               icon: isInCart
//                                   ? Icon(Icons.shopping_cart)
//                                   : Icon(Icons.add_shopping_cart),
//                               onPressed: () {
//                                 if (!isInCart) {
//                                   controller.addToCart(product);
//                                 } else {
//                                   // Optionally, you can handle removing from the cart
//                                   // controller.removeFromCart(product);
//                                 }
//                               },
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Get.to(() => CartItemsScreen());
//         },
//         label: Obx(
//             () => Text('Selected Product (${controller.cartItems.length})')),
//       ),
//     );
//   }
// }
