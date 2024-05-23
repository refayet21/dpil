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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditCartItemsScreen extends StatelessWidget {
  final List<dynamic> data;

  const EditCartItemsScreen({Key? key, required this.data}) : super(key: key);

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
                        // TextFormField(
                        //   keyboardType: TextInputType.text,
                        //   decoration: InputDecoration(labelText: 'Remarks'),
                        //   initialValue: currentItem.length > 9
                        //       ? currentItem[9]?.toString() ?? ''
                        //       : '',
                        //   onChanged: (value) {
                        //     if (currentItem.length > 9) {
                        //       currentItem[9] = value;
                        //     }
                        //   },
                        // ),
                        // SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
