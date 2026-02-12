import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  "username_$index",
                  style: TextStyle(
                    fontFamily: Fonts.semiBold,
                    color: Colours.white,
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(height: 350.h, color: Colours.divider),
              SizedBox(height: 15.h),
            ],
          );
        },
      ),
    );
  }
}
