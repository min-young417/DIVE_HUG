import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

class RiskBottomsheet extends StatelessWidget {
  const RiskBottomsheet({
    super.key,
    required this.score,
    required this.response,
  });

  final double score;
  final String response;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 43.h),
      padding: EdgeInsets.all(14.sp),
      child: Column(
        spacing: 16.h,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '위험도 계산',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.close(0);
                    },
                    child: Image.asset('assets/icons/cross.png',
                      width: 20.sp, height: 20.sp,),
                  )
                ],
              ),
              Divider(thickness: 1, color: Colors.black,),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16.h,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(color: Color.fromARGB(255, 226, 226, 226),),
                      color: Color(0xfff8f8f8),
                    ),
                    padding: EdgeInsets.all(10.sp),
                    child: Column(
                      spacing: 4.h,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '위험도 점수',
                              style: TextStyle(fontWeight: FontWeight.w500),),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${score.toInt()}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(' /100'),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '위험 수준',
                              style: TextStyle(fontWeight: FontWeight.w500),),
                            Text(
                              score > 14.8 ? '매우 높음' : score > 7.4 ? "높음" : "보통",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: score > 14.8
                                  ? Colors.red : score > 7.4 
                                  ? Colors.orange : Colors.green
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  MarkdownBody(
                    data: response,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ]
              )
            ),
          ),
        ],
      )
    );
  }
}