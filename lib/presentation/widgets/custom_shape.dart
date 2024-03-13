import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomShape extends StatelessWidget {
  String imageurl;
  String title;
  void Function() onTap;
  CustomShape(
      {super.key,
      required this.imageurl,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Stack(children: [
            Positioned(
              child: Container(
                width: 110.w,
                height: 110.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3.r,
                      blurRadius: 5.r,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 15.w,
              top: 15.h,
              child: Container(
                width: 80.w,
                height: 80.h,
                // color: Colors.amber,
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                        fit: BoxFit.contain, image: AssetImage(imageurl))),
              ),
            )
          ]),
          onTap: onTap,
        ),
        SizedBox(
          height: 7.h,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
