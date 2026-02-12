import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  Widget verticalSpace(double h) => SizedBox(height: h.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(15),

            /// Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colours.white, width: 0.6),
                ),
                child: TextField(
                  cursorColor: Colours.white,
                  style: TextStyle(
                    fontFamily: Fonts.medium,
                    fontSize: 14.sp,
                    color: Colours.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search people, posts, #hashtags",
                    hintStyle: TextStyle(
                      fontFamily: Fonts.light,
                      color: Colours.grey,
                      fontSize: 13.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colours.white.withOpacity(0.8),
                      size: 20.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ),

            verticalSpace(20),

            /// Explore Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.w,
                ),
                itemCount: 60,
                itemBuilder: (context, index) {
                  return Container(color: Colours.divider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
