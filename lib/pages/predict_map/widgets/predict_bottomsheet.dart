import 'package:dive_hug/common/common_function.dart';
import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/pages/predict_map/models/risk_response.dart';
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
    required this.predictAndExplain,
  });

  final Map building;
  final Future<RiskResponse?> Function(Map data) predictAndExplain;

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
    print(building);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 43.h),
      padding: EdgeInsets.all(14.sp),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '요약 정보',
                style: TextStyle(fontWeight: FontWeight.w500),
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
                        '선순위 채권 금액',
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
                        '보증 시작일',
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      CustomTextfiled(
                        controller: startDateController,
                        hintText: '(ex)202403',
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
                        controller: endDateController,
                        hintText: '(ex)202406',
                        isNumber: true,),
                    ],
                  ),
                  CustomButton(
                    onPress: () async {
                      Map data = {
                        'applicationMonth': int.parse(startDateController.text),
                        'expiryMonth': int.parse(endDateController.text),
                        'jeonsePrice': building['주택매매가격(원)'],
                        'depositAmount': building['보증금(원)'],
                        'seniority': int.parse(priceController.text),
                        'region': building['시군구'].substring(1, 3),
                        'housingType': building['주택유형'],
                      };
            
                      print(data);
            
                      if(priceController.text != '' && endDateController.text != '' && startDateController.text != ''){
                        CommonFunction.showCustomSnackBar('위험도를 계산중입니다.\n잠시만 기다려주세요.');
                        RiskResponse? result = await predictAndExplain(data);
                        
                        if(result != null){
                          final score = result.riskScore * 100;
                          final response = result.aiExplanation;
                          
                          print("Score: $score, Response: $response");
                        
                          Get.bottomSheet(
                            isScrollControlled: true,
                            RiskBottomsheet(
                              score: score,
                              response: response,
                            )
                          );
                        } else {
                          CommonFunction.showCustomSnackBar('서버 통신 오류. 다시 시도해주세요.');
                        }
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
          ),
        ],
      ),
    );
  }
}