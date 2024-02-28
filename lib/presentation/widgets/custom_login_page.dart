import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoginPage extends StatelessWidget {
  CustomLoginPage(
      {super.key,
      this.loginBgUrl,
      this.loginLogoUrl,
      this.loginTitle,
      this.inputFields,
      this.loginOnPressed,
      this.loginButtonText,
      this.forgetPassword,
      this.forgetOntap});

  final String? loginBgUrl;
  final String? loginLogoUrl;
  final String? loginTitle;
  final List<Widget>? inputFields;
  final VoidCallback? loginOnPressed;
  final String? loginButtonText;
  final String? forgetPassword;
  final VoidCallback? forgetOntap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          // background Image
          Image(
            image: AssetImage(loginBgUrl.toString()),
            height: 1.sh,
            width: 1.sw,
            fit: BoxFit.cover,
          ),
          // bg image opacity
          Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.black,
            ),
          ),

          // login ui container
          Container(
            margin: EdgeInsets.fromLTRB(20.w, 100.h, 20.w, 20.h),
            // padding: EdgeInsets.zero,
            // width: 1.sw,
            // height: 1.sh,
            decoration: BoxDecoration(
              color: Colors.white70,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Color(0x4d9e9e9e), width: 2),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // login logo
                    Image(
                      image: AssetImage(
                        loginLogoUrl.toString(),
                      ),
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 30.h, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          loginTitle!,
                          textAlign: TextAlign.start,
                          // overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 22.sp,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    for (var field in inputFields!)
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 16.h, horizontal: 0),
                        child: field,
                      ),
                    // forget password section
                    if (forgetPassword != null)
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5.h, 0, 20.h),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              child: Text(
                                forgetPassword.toString(),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                    color: Colors.black),
                              ),
                              onTap: forgetOntap),
                        ),
                      ),

                    // submit button
                    MaterialButton(
                      onPressed: loginOnPressed,
                      color: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        loginButtonText!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      textColor: Color(0xffffffff),
                      height: 40.h,
                      minWidth: 1.sw,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
