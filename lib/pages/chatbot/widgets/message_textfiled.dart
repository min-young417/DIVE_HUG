import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTextfiled extends StatelessWidget {
  const MessageTextfiled({
    super.key,
    required this.controller,
    required this.onSend,
  });

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      height: 40.h,
      child: Row(
        children: [
          Text(
            "가",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),

          // 입력창
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "무엇을 도와드릴까요?",
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                border: InputBorder.none,
              ),
            ),
          ),

          // 전송 버튼
          GestureDetector(
            onTap: onSend,
            child: Image.asset(
              'assets/icons/send.png'),
          ),
        ],
      ),
    );
  }
}