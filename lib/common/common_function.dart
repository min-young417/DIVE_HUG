import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonFunction {
  static double calcRisk(Map item) {
    final deposit = double.tryParse(item['보증금(원)'].toString()) ?? 0;
    final price = double.tryParse(item['주택매매가격(원)'].toString()) ?? 1;
    return (deposit / price * 100).clamp(0, 100);
  }

  static void showCustomSnackBar(String text) {
    Get.showSnackbar(
      GetSnackBar(
        titleText: Text(
          '알림',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        messageText: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: const Color.fromARGB(255, 209, 209, 209),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        margin: EdgeInsets.all(8.sp),
        borderRadius: 8,
        animationDuration: Duration(milliseconds: 800),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static String? formatNumberWithKoreanUnit(int? number) {
    if (number == null) return null;
    if (number == 0) return '0';

    final units = ['', '만', '억', '조', '경'];
    final result = <String>[];

    int unitIndex = 0;
    int current = number;

    while (current > 0) {
      int section = current % 10000;
      if (section != 0) {
        result.insert(0, '$section${units[unitIndex]}');
      }
      current ~/= 10000;
      unitIndex++;
    }

    return '${result.join('')}원';
  }
}  