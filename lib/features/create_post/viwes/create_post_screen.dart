import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔝 Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontFamily: Fonts.medium,
                        fontSize: 14.sp,
                        color: Colours.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Create Post",
                    style: TextStyle(
                      fontFamily: Fonts.bold,
                      fontSize: 16.sp,
                      letterSpacing: 2,
                      color: Colours.white,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Share",
                      style: TextStyle(
                        fontFamily: Fonts.semiBold,
                        fontSize: 14.sp,
                        color: Colours.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Divider(color: Colours.divider, thickness: 0.5),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(25),

                    /// Image Preview
                    Container(
                      height: 320.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colours.divider,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40.sp,
                          color: Colours.white.withOpacity(0.6),
                        ),
                      ),
                    ),

                    verticalSpace(35),

                    /// Caption
                    Text(
                      "Caption",
                      style: TextStyle(
                        fontFamily: Fonts.semiBold,
                        fontSize: 14.sp,
                        color: Colours.white,
                      ),
                    ),

                    verticalSpace(12),

                    TextField(
                      maxLines: 4,
                      cursorColor: Colours.white,
                      style: TextStyle(
                        fontFamily: Fonts.medium,
                        fontSize: 14.sp,
                        color: Colours.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Write something minimal...",
                        hintStyle: TextStyle(
                          fontFamily: Fonts.light,
                          color: Colours.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colours.white,
                            width: 0.6,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colours.white,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(16.w),
                      ),
                    ),

                    verticalSpace(30),

                    /// Add Location
                    _buildOptionTile(
                      Icons.location_on_outlined,
                      "Add Location",
                    ),

                    verticalSpace(15),

                    /// Advanced Settings
                    _buildOptionTile(
                      Icons.settings_outlined,
                      "Advanced Settings",
                    ),

                    verticalSpace(40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colours.white, width: 0.5),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colours.white.withOpacity(0.8)),
          horizontalSpace(15),
          Text(
            title,
            style: TextStyle(
              fontFamily: Fonts.medium,
              fontSize: 14.sp,
              color: Colours.white,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 14.sp,
            color: Colours.white.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
