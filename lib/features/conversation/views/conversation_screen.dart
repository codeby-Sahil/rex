import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔝 TOP BAR
            _buildTopBar(context),

            /// Divider
            Divider(color: Colours.divider, thickness: 0.5),

            /// 💬 Messages
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                children: const [
                  _MessageBubble(
                    message: "Hey, love your latest post.",
                    isMe: false,
                  ),
                  _MessageBubble(message: "Thank you 🤍", isMe: true),
                  _MessageBubble(
                    message: "Let’s collaborate soon.",
                    isMe: false,
                  ),
                ],
              ),
            ),

            /// ✍ Input Area
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  /// ---------------- TOP BAR ----------------
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          /// Back
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18.sp,
              color: Colours.white,
            ),
          ),

          horizontalSpace(12),

          /// Avatar
          CircleAvatar(radius: 20.r, backgroundColor: Colours.divider),

          horizontalSpace(12),

          /// Name + Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "pro_user",
                style: TextStyle(
                  fontFamily: Fonts.semiBold,
                  fontSize: 14.sp,
                  color: Colours.white,
                ),
              ),
              Text(
                "Online",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 11.sp,
                  color: Colours.white.withOpacity(0.6),
                ),
              ),
            ],
          ),

          const Spacer(),

          /// Options
          PopupMenuButton<String>(
            color: Colours.primary,
            icon: Icon(Icons.more_vert, color: Colours.white, size: 20.sp),
            onSelected: (value) {},
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: "report",
                    child: Text(
                      "Report",
                      style: TextStyle(
                        fontFamily: Fonts.medium,
                        color: Colours.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "block",
                    child: Text(
                      "Block",
                      style: TextStyle(
                        fontFamily: Fonts.medium,
                        color: Colours.white,
                      ),
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  /// ---------------- INPUT AREA ----------------
  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colours.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          /// Attachment
          Icon(
            Icons.attach_file,
            color: Colours.white.withOpacity(0.7),
            size: 22.sp,
          ),

          horizontalSpace(10),

          /// Text Field
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colours.white, width: 0.5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                cursorColor: Colours.white,
                style: TextStyle(
                  fontFamily: Fonts.medium,
                  fontSize: 13.sp,
                  color: Colours.white,
                ),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(
                    fontFamily: Fonts.light,
                    color: Colours.grey,
                  ),
                  border: InputBorder.none,
                  isCollapsed: true,
                ),
              ),
            ),
          ),

          horizontalSpace(10),

          /// Send
          Container(
            height: 40.h,
            width: 40.h,
            decoration: const BoxDecoration(
              color: Colours.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_upward,
              size: 18.sp,
              color: Colours.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- MESSAGE BUBBLE ----------------
class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const _MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        constraints: BoxConstraints(maxWidth: 250.w),
        decoration: BoxDecoration(
          color: isMe ? Colours.white : Colours.divider,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontFamily: Fonts.medium,
            fontSize: 13.sp,
            color: isMe ? Colours.primary : Colours.white,
          ),
        ),
      ),
    );
  }
}
