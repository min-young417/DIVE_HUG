import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/common/custom_theme.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectDongBottomsheet extends StatelessWidget{
  const SelectDongBottomsheet({
    super.key,
    required this.building, 
  });

  final Map building;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 6.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.close(0);
                      },
                      child: Image.asset('assets/icons/cross.png',
                        width: 34.sp, height: 24.sp,),
                    ),
                  ],
                ),
                Text(
                  '시세 확인',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              building['단지명'] ?? '없음',
                              style: TextStyle(fontWeight: FontWeight.w500),
                              softWrap: true,
                            ),
                            Text(
                              building['전체주소'] ?? '없음',
                              style: TextStyle(fontWeight: FontWeight.w500),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextfiled(
                  controller: dongController,
                  hintText: '동을 입력해주세요. ex) 101',
                  isNumber: true,),
                CustomTextfiled(
                  controller: floorController,
                  hintText: '층을 입력해주세요. ex) 3',
                  isNumber: true,),
               CustomTextfiled(
                  controller: hoController,
                  hintText: '호를 입력해주세요. ex) 301',
                  isNumber: true,),
              ]
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(vertical: 16.h),
            child: CustomButton(
              onPress: () {
                Get.toNamed('/buildingInfo', arguments: building);
              }, 
              text: '확인',
              color: CustomTheme.mainColor,),
          ),
        ],
      )
    );
  }
}