import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String logoPath;
  final String title;
  final String subtitle;

  CustomCard({
    required this.logoPath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: Container(
        width: double.infinity, // Set width to full width

        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                logoPath,
                width: 60.w,
                height: 60.h,
              ),
              SizedBox(height: 10.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 6.h),
            ],
          ),
        ),
      ),
    );
  }
}
