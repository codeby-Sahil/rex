import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prosnap/core/consts/colours.dart';
import 'package:prosnap/core/consts/fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;

  Widget verticalSpace(double h) => SizedBox(height: h.h);
  Widget horizontalSpace(double w) => SizedBox(width: w.w);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(15),

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
                  controller: _controller,
                  cursorColor: Colours.white,
                  style: TextStyle(
                    fontFamily: Fonts.medium,
                    fontSize: 14.sp,
                    color: Colours.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isSearching = value.isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search people, posts, #hashtags",
                    hintStyle: TextStyle(
                      fontFamily: Fonts.light,
                      color: Colours.grey,
                      fontSize: 13.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colours.white.withOpacity(0.8),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            verticalSpace(20),

            /// Body
            Expanded(
              child: isSearching ? _buildSearchResults() : _buildExploreGrid(),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- EXPLORE GRID ----------------
  Widget _buildExploreGrid() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 2.w,
      ),
      itemCount: 60,
      itemBuilder: (context, index) {
        return Container(color: Colours.divider);
      },
    );
  }

  /// ---------------- SEARCH RESULTS ----------------
  Widget _buildSearchResults() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _sectionTitle("People"),
        verticalSpace(10),
        ...List.generate(3, (index) => _buildUserResult(index)),

        verticalSpace(25),

        _sectionTitle("Hashtags"),
        verticalSpace(10),
        ...List.generate(3, (index) => _buildHashtagResult(index)),

        verticalSpace(25),

        _sectionTitle("Posts"),
        verticalSpace(10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 2.w,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(color: Colours.divider);
          },
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: Fonts.semiBold,
        fontSize: 14.sp,
        color: Colours.white,
      ),
    );
  }

  Widget _buildUserResult(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          CircleAvatar(radius: 22.r, backgroundColor: Colours.divider),
          horizontalSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "user_$index",
                style: TextStyle(
                  fontFamily: Fonts.medium,
                  fontSize: 14.sp,
                  color: Colours.white,
                ),
              ),
              Text(
                "Full Name $index",
                style: TextStyle(
                  fontFamily: Fonts.light,
                  fontSize: 12.sp,
                  color: Colours.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHashtagResult(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        "#minimal_$index",
        style: TextStyle(
          fontFamily: Fonts.medium,
          fontSize: 14.sp,
          color: Colours.white,
        ),
      ),
    );
  }
}
