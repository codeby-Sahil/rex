import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(backgroundColor: Colours.divider),
            title: Text(
              "User $index",
              style: TextStyle(fontFamily: Fonts.medium, color: Colours.white),
            ),
            subtitle: Text(
              "Last message preview...",
              style: TextStyle(fontFamily: Fonts.light, color: Colours.grey),
            ),
          );
        },
      ),
    );
  }
}
