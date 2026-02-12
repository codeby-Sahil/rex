import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/auth/views/registration_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(70),

              /// Logo
              Text(
                "PRO SNAP",
                style: TextStyle(
                  fontFamily: Fonts.bold,
                  fontSize: 30.sp,
                  letterSpacing: 6,
                  color: Colours.white,
                ),
              ),

              verticalSpace(12),

              /// Subtitle
              Text(
                "Create Account",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                  color: Colours.white.withOpacity(0.7),
                ),
              ),

              verticalSpace(50),

              _buildInputField("Email", false),
              verticalSpace(18),

              _buildInputField("Password", true),
              verticalSpace(18),

              verticalSpace(40),

              /// Signup Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => ProfileSetupScreen());
                  },
                  child: const Text("SIGN UP"),
                ),
              ),

              const Spacer(),

              /// Already have account
              Column(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontFamily: Fonts.light,
                      fontSize: 13.sp,
                      color: Colours.grey,
                    ),
                  ),
                  verticalSpace(8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: Fonts.semiBold,
                        fontSize: 14.sp,
                        letterSpacing: 1.2,
                        color: Colours.white,
                      ),
                    ),
                  ),
                ],
              ),

              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, bool obscure) {
    return TextFormField(
      obscureText: obscure,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontFamily: Fonts.light, color: Colours.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colours.white, width: 0.6),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Colours.white, width: 1),
        ),
      ),
    );
  }
}
