import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/auth/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => LoginScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget verticalSpace(double height) => SizedBox(height: height.h);
  Widget horizontalSpace(double width) => SizedBox(width: width.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(200),

              /// App Name
              Text(
                "PRO SNAP",
                style: TextStyle(
                  fontFamily: Fonts.bold,
                  fontSize: 36.sp,
                  letterSpacing: 6,
                  color: Colors.white,
                ),
              ),

              verticalSpace(16),

              /// Tagline
              Text(
                "Capture Silence",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 14.sp,
                  letterSpacing: 2,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),

              const Spacer(),

              /// Footer
              Text(
                "© 2026 Pro Snap",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),

              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
