import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';
import 'package:prosnap/features/navbar/views/home_screen.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  String? selectedGender;
  DateTime? selectedDate;

  Widget verticalSpace(double height) => SizedBox(height: height.h);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(40),

              /// Logo
              Text(
                "PRO SNAP",
                style: TextStyle(
                  fontFamily: Fonts.bold,
                  fontSize: 28.sp,
                  letterSpacing: 6,
                  color: Colours.white,
                ),
              ),

              verticalSpace(10),

              Text(
                "Complete Profile",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                  color: Colours.white.withOpacity(0.7),
                ),
              ),

              verticalSpace(40),

              /// Profile Image
              GestureDetector(
                onTap: () {
                  // open image picker
                },
                child: Container(
                  height: 110.h,
                  width: 110.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colours.white, width: 1),
                  ),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: Colours.white.withOpacity(0.7),
                    size: 28.sp,
                  ),
                ),
              ),

              verticalSpace(40),

              _buildInputField("Username"),
              verticalSpace(18),

              _buildInputField("Full Name"),
              verticalSpace(18),

              _buildGenderDropdown(),
              verticalSpace(18),

              _buildDobField(context),
              verticalSpace(18),

              _buildBioField(),
              verticalSpace(40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => MainNavScreen());
                  },
                  child: const Text("CONTINUE"),
                ),
              ),

              verticalSpace(30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String hint) {
    return TextFormField(
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: _inputDecoration(hint),
    );
  }

  Widget _buildBioField() {
    return TextFormField(
      maxLines: 3,
      style: TextStyle(
        fontFamily: Fonts.medium,
        fontSize: 14.sp,
        color: Colours.white,
      ),
      cursorColor: Colours.white,
      decoration: _inputDecoration("Bio"),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colours.primary,
      value: selectedGender,
      style: TextStyle(fontFamily: Fonts.medium, color: Colours.white),
      decoration: _inputDecoration("Gender"),
      items:
          ["Male", "Female", "Other"]
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender)),
              )
              .toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
    );
  }

  Widget _buildDobField(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1950),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Colours.white,
                  onPrimary: Colours.primary,
                  surface: Colours.primary,
                  onSurface: Colours.white,
                ),
              ),
              child: child!,
            );
          },
        );

        if (picked != null) {
          setState(() {
            selectedDate = picked;
          });
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          style: TextStyle(
            fontFamily: Fonts.medium,
            fontSize: 14.sp,
            color: Colours.white,
          ),
          decoration: _inputDecoration(
            selectedDate == null
                ? "Date of Birth"
                : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
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
    );
  }
}
