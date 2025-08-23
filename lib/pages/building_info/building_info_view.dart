import 'package:dive_hug/common/common_function.dart';
import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/common/custom_theme.dart';
import 'package:dive_hug/pages/building_info/building_info_controller.dart';
import 'package:dive_hug/pages/predict_map/models/risk_response.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_button.dart';
import 'package:dive_hug/common/custom_outlined_button.dart';
import 'package:dive_hug/pages/predict_map/widgets/risk_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuildingInfoView extends GetView<BuildingInfoController> {
  const BuildingInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xfff8f8f8),
          leading: Padding(
            padding: EdgeInsets.only(left: 14.w), // ✅ 수정
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Image.asset('assets/icons/left-arrow.png'),
            ),
          ),
          title: Text(
            '조회 결과',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          actions: [
            Image.asset(
              'assets/icons/home.png',
              width: 22.sp,
              height: 22.sp,
            ),
            SizedBox(width: 18.w),
            Image.asset(
              'assets/icons/hambuger-menu.png',
              width: 18.sp,
              height: 18.sp,
            ),
            SizedBox(width: 14.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Column( // ✅ Expanded 제거
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 14.sp, top: 14.sp),
                child: Text(
                  '조회하신 주택의 기본정보를 확인하세요.',
                  style: TextStyle(
                      fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
              ),
              // 🔽 첫 번째 카드
              _buildInfoCard(),
              // 🔽 입력 폼 카드
              _buildFormCard(context),
            ],
          ),
        ),
      ),
    );
  }

  // 주택 기본정보 카드
  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      margin: EdgeInsets.all(14.sp),
      padding: EdgeInsets.all(14.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '주소',
            style: TextStyle(
              fontSize: 12.w,
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 131, 131, 131),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            controller.building['전체주소'] ?? '없음',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: const Color.fromARGB(255, 240, 240, 240),
            ),
            padding: EdgeInsets.all(10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '매매시세',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: CustomTheme.subColor),
                ),
                SizedBox(width: 6.w),
                Text(CommonFunction.formatNumberWithKoreanUnit(
                        controller.building['주택매매가격(원)']) ??
                    '없음'),
              ],
            ),
          ),
          const Divider(color: Color.fromARGB(255, 225, 225, 225)),
          Row(
            children: [
              _buildTag(controller.building['주택유형'] ?? '없음'),
              SizedBox(width: 6.w),
              _buildTag(
                  '전용면적 ${controller.building['전용면적(㎡)'] ?? '-'}(㎡)'),
            ],
          ),
          SizedBox(height: 16.h),
          CustomOutlinedButton(
            onPress: () {},
            text: '상세추가정보 확인하기',
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      decoration: BoxDecoration(
        color: CustomTheme.subColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 13.sp, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }

  // 입력폼 카드
  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      margin: EdgeInsets.all(14.sp),
      padding: EdgeInsets.all(14.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInput('전세보증금', controller.depositController),
          _buildInput('보증 시작일', controller.startDateController,
              hint: 'ex) 202403'),
          _buildInput('보증 만료일', controller.endDateController,
              hint: 'ex) 202406'),
          _buildInput('선순위 채권 금액', controller.priceController),
          SizedBox(height: 16.h),
          _buildInfoSection(),
          SizedBox(height: 16.h),
          _buildTrustSection(),
          SizedBox(height: 16.h),
          CustomButton(
            onPress: () async {
              if (controller.priceController.text.isEmpty ||
                  controller.endDateController.text.isEmpty ||
                  controller.startDateController.text.isEmpty) {
                CommonFunction.showCustomSnackBar('모든 값을 입력해주세요');
                return;
              }

              final startMonth =
                  int.tryParse(controller.startDateController.text);
              final endMonth = int.tryParse(controller.endDateController.text);
              final seniority = int.tryParse(controller.priceController.text);
              final deposit =
                  int.tryParse(controller.depositController.text) ?? 0;

              if (startMonth == null || endMonth == null || seniority == null) {
                CommonFunction.showCustomSnackBar('입력값을 확인해주세요');
                return;
              }

              final region = controller.building['시군구'] ?? '';
              final regionCode =
                  region.length >= 3 ? region.substring(1, 3) : region;

              Map<String, dynamic> data = {
                'applicationMonth': startMonth,
                'expiryMonth': endMonth,
                'jeonsePrice': controller.building['주택매매가격(원)'] ?? 0,
                'depositAmount': deposit,
                'seniority': seniority,
                'region': regionCode,
                'housingType': controller.building['주택유형'] ?? '',
              };

              CommonFunction.showCustomSnackBar('위험도를 계산중입니다.\n잠시만 기다려주세요.');
              RiskResponse? result = await controller.predictAndExplain(data);

              if (result != null) {
                final score = result.riskScore * 100;
                final response = result.aiExplanation;

                Get.bottomSheet(
                  isScrollControlled: true,
                  RiskBottomsheet(
                    score: score,
                    response: response,
                  ),
                );
              } else {
                CommonFunction.showCustomSnackBar('서버 통신 오류. 다시 시도해주세요.');
              }
            },
            color: CustomTheme.mainColor,
            text: '위험도 계산하기',
          ),
        ],
      ),
    );
  }

  Widget _buildInput(String title, TextEditingController controller,
      {String hint = ''}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 4.h),
          CustomTextfiled(
            controller: controller,
            hintText: hint,
            isNumber: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('저당권 등 선순위채권 정보를 모르는 경우',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
        CustomOutlinedButton(
          onPress: () {},
          height: 48.h,
          text: '등기부등본 정보\n확인 후 안심진단하기',
        ),
        Text('등기부등본 열람 대행 및 결제 수수료(1,000원) 포함\n등기부등본이란?',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTrustSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('등기부등본에 "신탁"표시가 확인되는 경우',
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500)),
        CustomOutlinedButton(
          color: CustomTheme.sub2Color,
          onPress: () {
            controller.launchURL('https://24minwon.net/req_form_01/?idx=13');
          },
          text: '신탁원부 확인하러 가기',
        ),
        Text(
          '신탁원부에는 이 집을 세입자가 전세, 월세 계약할 수 있는지 여부가 적혀 있습니다.\n'
          '확인하지 않고 계약시, 보증금을 돌려받지 못할 수 있습니다.',
          style: TextStyle(fontSize: 11.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
