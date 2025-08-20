import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfiled extends StatelessWidget {
  CustomTextfiled({
    super.key,
    required this.hintText,
    this.suffix
  });

  final String hintText;
  Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 11.sp,
            color: Color.fromRGBO(150, 150, 150, 1),
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Color.fromRGBO(228, 228, 228, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide(color: Color.fromRGBO(228, 228, 228, 1)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
          suffixIcon: Padding(
            padding: EdgeInsetsGeometry.only(right: 10.w),
            child: suffix,
          ),
          suffixIconConstraints: BoxConstraints(
            minHeight: 12.sp,
            minWidth: 12.sp,
          ),
        ),
        style: TextStyle(
          fontSize: 11.sp
        ),
      ),
    );
  }
}