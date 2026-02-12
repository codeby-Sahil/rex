import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/features/chat/views/chat_screen.dart';
import 'package:prosnap/features/create_post/viwes/create_post_screen.dart';
import 'package:prosnap/features/home/views/home_screen.dart';
import 'package:prosnap/features/profile/views/profile_screen.dart';
import 'package:prosnap/features/search/view/search_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    SearchScreen(),
    SizedBox(), // Placeholder for Create Post
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colours.divider, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index == 2) {
              _openCreatePost(context);
              return;
            }
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colours.primary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Colours.white,
          unselectedItemColor: Colours.white.withOpacity(0.4),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: '',
            ),

            /// Center Create Button
            BottomNavigationBarItem(
              icon: Container(
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colours.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.add, color: Colours.white),
              ),
              label: '',
            ),

            const BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  void _openCreatePost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colours.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          height: 250.h,
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create",
                style: TextStyle(
                  color: Colours.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Get.to(() => CreatePostScreen());
                },
                child: _buildCreateOption(Icons.image_outlined, "New Post"),
              ),
              const SizedBox(height: 20),
              _buildCreateOption(Icons.videocam_outlined, "New Reel"),
              const SizedBox(height: 20),
              _buildCreateOption(Icons.auto_stories_outlined, "New Story"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCreateOption(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colours.white),
        const SizedBox(width: 15),
        Text(text, style: const TextStyle(color: Colours.white)),
      ],
    );
  }
}
