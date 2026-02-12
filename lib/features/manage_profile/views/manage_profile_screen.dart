import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class ManageProfileScreen extends StatefulWidget {
  const ManageProfileScreen({super.key});

  @override
  State<ManageProfileScreen> createState() => _ManageProfileScreenState();
}

class _ManageProfileScreenState extends State<ManageProfileScreen> {
  bool isPrivate = false;

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            /// Top Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colours.white,
                      size: 18.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Manage Profile",
                    style: TextStyle(
                      fontFamily: Fonts.bold,
                      fontSize: 18.sp,
                      letterSpacing: 2,
                      color: Colours.white,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(width: 18.w),
                ],
              ),
            ),

            Divider(color: Colours.divider, thickness: 0.5),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(30),

                    /// Profile Image
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 55.r,
                              backgroundColor: Colours.divider,
                            ),
                            Positioned(
                              bottom: 4,
                              right: 4,
                              child: Container(
                                height: 26.h,
                                width: 26.h,
                                decoration: const BoxDecoration(
                                  color: Colours.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 14.sp,
                                  color: Colours.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    verticalSpace(40),

                    /// Username
                    _buildInputField("Username"),

                    verticalSpace(20),

                    /// Full Name
                    _buildInputField("Full Name"),

                    verticalSpace(20),

                    /// Bio
                    _buildInputField("Bio", maxLines: 3),

                    verticalSpace(35),

                    /// Account Status
                    Text(
                      "Account Status",
                      style: TextStyle(
                        fontFamily: Fonts.semiBold,
                        fontSize: 14.sp,
                        color: Colours.white,
                      ),
                    ),

                    verticalSpace(15),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colours.white, width: 0.6),
                      ),
                      child: Row(
                        children: [
                          Text(
                            isPrivate ? "Private Account" : "Public Account",
                            style: TextStyle(
                              fontFamily: Fonts.medium,
                              fontSize: 13.sp,
                              color: Colours.white,
                            ),
                          ),
                          const Spacer(),
                          Switch(
                            value: isPrivate,
                            activeColor: Colours.white,
                            activeTrackColor: Colours.grey,
                            inactiveThumbColor: Colours.white,
                            inactiveTrackColor: Colours.divider,
                            onChanged: (value) {
                              setState(() {
                                isPrivate = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    verticalSpace(50),

                    /// Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "SAVE CHANGES",
                          style: TextStyle(
                            fontFamily: Fonts.semiBold,
                            fontSize: 14.sp,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
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

  Widget _buildInputField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      cursorColor: Colours.white,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontFamily: Fonts.light, color: Colours.grey),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colours.white, width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colours.white, width: 1),
        ),
      ),
    );
  }
}
