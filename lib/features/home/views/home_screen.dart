import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Top App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: Text(
                  "PRO SNAP",
                  style: TextStyle(
                    fontFamily: Fonts.bold,
                    fontSize: 22.sp,
                    letterSpacing: 4,
                    color: Colours.white,
                  ),
                ),
              ),
            ),

            /// Stories Section
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Column(
                        children: [
                          Container(
                            height: 65.h,
                            width: 65.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colours.white,
                                width: 1,
                              ),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colours.divider,
                            ),
                          ),
                          verticalSpace(8),
                          Text(
                            "user$index",
                            style: TextStyle(
                              fontFamily: Fonts.light,
                              fontSize: 11.sp,
                              color: Colours.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            /// Thin Divider
            SliverToBoxAdapter(
              child: Divider(color: Colours.divider, thickness: 0.5),
            ),

            /// Posts
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildPost(index);
              }, childCount: 5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPost(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(20),

        /// Header (Profile + Username + Location)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              CircleAvatar(radius: 18.r, backgroundColor: Colours.divider),
              horizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "username_$index",
                    style: TextStyle(
                      fontFamily: Fonts.semiBold,
                      fontSize: 13.sp,
                      color: Colours.white,
                    ),
                  ),
                  Text(
                    "New York, USA",
                    style: TextStyle(
                      fontFamily: Fonts.light,
                      fontSize: 11.sp,
                      color: Colours.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colours.white, size: 20.sp),
            ],
          ),
        ),

        verticalSpace(15),

        /// Post Image
        Container(
          height: 380.h,
          width: double.infinity,
          color: Colours.divider,
        ),

        verticalSpace(15),

        /// Actions
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Icon(Icons.favorite_border, color: Colours.white, size: 22.sp),
              horizontalSpace(20),
              Icon(
                Icons.mode_comment_outlined,
                color: Colours.white,
                size: 22.sp,
              ),
              const Spacer(),
              Icon(Icons.bookmark_border, color: Colours.white, size: 22.sp),
            ],
          ),
        ),

        verticalSpace(12),

        /// Caption
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "username_$index  ",
                  style: TextStyle(
                    fontFamily: Fonts.semiBold,
                    fontSize: 13.sp,
                    color: Colours.white,
                  ),
                ),
                TextSpan(
                  text: "A minimal aesthetic moment captured in silence.",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 13.sp,
                    color: Colours.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),

        verticalSpace(20),

        Divider(color: Colours.divider, thickness: 0.5),
      ],
    );
  }
}
