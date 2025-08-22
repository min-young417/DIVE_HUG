import 'package:dive_hug/pages/predict_map/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RiskBottomsheet extends StatelessWidget {
  const RiskBottomsheet({
    super.key,
    required this.score,
  });

  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(14.sp),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.h,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '위험도 계산',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(thickness: 2, color: Colors.black,),
              ],
            ),
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
                        '보통',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Row(
              spacing: 6.w,
              children: [
                Image.asset(
                  'assets/icons/caution.png',
                  width: 14.sp,
                  height: 14.sp,
                ),
                Text(
                  '자세한 분석 내용을 챗봇과 함께 확인해보세요!',
                  style: TextStyle(
                    fontSize: 13.sp
                  ),
                )
              ],
            ),
            CustomOutlinedButton(
              onPress: () {}, 
              text: '챗봇에게 질문하기',
            ),
            SizedBox(height: 12.h),
          ]
        )
      )
    );
  }
}