import 'package:dive_hug/common/common_function.dart';
import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_button.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_outlined_button.dart';
import 'package:dive_hug/pages/predict_map/widgets/risk_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PredictBottomsheet extends StatelessWidget{
  const PredictBottomsheet({
    super.key,
    required this.building,
  });

  final Map building;

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    print(building);

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
                  '요약 정보',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Divider(thickness: 2, color: Colors.black,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  building['단지명'] ?? '없음',
                  style: TextStyle(
                    fontSize: 20.sp, 
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                ),
                Text(building['전체주소'] ?? '없음'),
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
                        '주택유형',
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      Text(building['주택유형'] ?? '없음')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '매매가',
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      Text(CommonFunction.formatNumberWithKoreanUnit(building['주택매매가격(원)']) ?? '없음')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '전세 보증금',
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      Text(CommonFunction.formatNumberWithKoreanUnit(building['보증금(원)']) ?? '조회불가')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '공시지가',
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      Text(CommonFunction.formatNumberWithKoreanUnit(building['공시지가(원)']) ?? '조회불가')
                    ],
                  )
                ],
              ),
            ),
            CustomOutlinedButton(
              onPress: () {}, 
              text: '상세추가정보 확인하기',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  '선순위 채권 금액 (만원)',
                  style: TextStyle(fontWeight: FontWeight.w500),),
                CustomTextfiled(
                  controller: priceController,
                  hintText: '',
                  isNumber: true,),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  '보증 만료일',
                  style: TextStyle(fontWeight: FontWeight.w500),),
                CustomTextfiled(
                  controller: dateController,
                  hintText: '',
                  isNumber: true,),
              ],
            ),
            CustomButton(
              onPress: () {
                if(priceController.text != '' && dateController.text != ''){
                  var score = CommonFunction.calcRisk(building);
                  Get.bottomSheet(
                    RiskBottomsheet(score: score)
                  );
                } else {
                  CommonFunction.showCustomSnackBar('모든 값을 입력해주세요');
                }
                
              }, 
              text: '위험도 계산하기',
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}