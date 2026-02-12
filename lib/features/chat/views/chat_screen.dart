import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/conversation/views/conversation_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),

            /// Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Messages",
                  style: TextStyle(
                    fontFamily: Fonts.bold,
                    fontSize: 22.sp,
                    letterSpacing: 2,
                    color: Colours.white,
                  ),
                ),
              ),
            ),

            verticalSpace(20),

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
                    hintText: "Search conversations",
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
                  ),
                ),
              ),
            ),

            verticalSpace(20),

            /// Chat List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: 10,
                separatorBuilder:
                    (_, __) => Divider(color: Colours.divider, thickness: 0.5),
                itemBuilder: (context, index) {
                  return _buildChatTile(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatTile(int index) {
    return InkWell(
      onTap: () {
        Get.to(() => ConversationScreen());
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            /// Profile Image
            CircleAvatar(radius: 26.r, backgroundColor: Colours.divider),

            horizontalSpace(14),

            /// Name + Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "user_$index",
                    style: TextStyle(
                      fontFamily: Fonts.semiBold,
                      fontSize: 14.sp,
                      color: Colours.white,
                    ),
                  ),
                  verticalSpace(6),
                  Text(
                    "Last message preview goes here...",
                    style: TextStyle(
                      fontFamily: Fonts.light,
                      fontSize: 12.sp,
                      color: Colours.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            /// Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "2:45 PM",
                  style: TextStyle(
                    fontFamily: Fonts.light,
                    fontSize: 11.sp,
                    color: Colours.white.withOpacity(0.6),
                    letterSpacing: 1,
                  ),
                ),
                verticalSpace(6),

                /// Unread Dot (optional)
                Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: const BoxDecoration(
                    color: Colours.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
