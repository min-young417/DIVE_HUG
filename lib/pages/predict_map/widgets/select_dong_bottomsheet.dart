import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/pages/predict_map/models/risk_response.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_button.dart';
import 'package:dive_hug/pages/predict_map/widgets/predict_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SelectDongBottomsheet extends StatelessWidget{
  const SelectDongBottomsheet({
    super.key,
    required this.building, 
    required this.predictAndExplain,
  });

  final Map building;
  final Future<RiskResponse?> Function(Map data) predictAndExplain;

  @override
  Widget build(BuildContext context) {
    TextEditingController dongController = TextEditingController();
    TextEditingController floorController = TextEditingController();
    TextEditingController hoController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 43.h),
      padding: EdgeInsets.all(14.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16.h,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                '동',
                style: TextStyle(fontWeight: FontWeight.w500),),
              CustomTextfiled(
                controller: dongController,
                hintText: '101',
                isNumber: true,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                '층',
                style: TextStyle(fontWeight: FontWeight.w500),),
              CustomTextfiled(
                controller: floorController,
                hintText: '3',
                isNumber: true,),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.h,
            children: [
              Text(
                '호수',
                style: TextStyle(fontWeight: FontWeight.w500),),
              CustomTextfiled(
                controller: hoController,
                hintText: '301',
                isNumber: true,),
            ],
          ),
          CustomButton(
            onPress: () {
              Get.bottomSheet(
                isScrollControlled: true,
                PredictBottomsheet(
                  building: building,
                  predictAndExplain: predictAndExplain,
                ),
              );
            }, 
            text: '입력 완료',),
          SizedBox(height: 16.h,)
        ]
      )
    );
  }
}