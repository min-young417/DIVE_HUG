import 'package:dive_hug/common/custom_textfiled.dart';
import 'package:dive_hug/common/custom_theme.dart';
import 'package:dive_hug/pages/predict_map/widgets/custom_thumb_shape.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dive_hug/pages/predict_map/predict_map_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PredictMapView extends GetView<PredictMapController> {
  const PredictMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xfff8f8f8),
          leading: Padding(
            padding: EdgeInsetsGeometry.only(left: 14.w),
            child: Image.asset('assets/icons/left-arrow.png'),
          ),
          title: Text(
            '인근지역 시세조회',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          actions: [
            Image.asset(
              'assets/icons/home.png',
              width: 22.sp,
              height: 22.sp,
            ),
            SizedBox(width: 18.w,),
            Image.asset(
              'assets/icons/hambuger-menu.png',
              width: 18.sp,
              height: 18.sp,
            ),
            SizedBox(width: 14.w,),
          ],
        ),
      body: Stack(
        children: [
          // 지도
          Obx(() => FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              initialCenter: LatLng(35.1796, 129.0756),
              initialZoom: 16,
            ),
            children: [
              TileLayer(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"),
              MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                  maxClusterRadius: 25,
                  markers: controller.markers.toList(),
                  polygonOptions: PolygonOptions(
                    borderColor: Colors.blueAccent,
                    color: Colors.black12,
                    borderStrokeWidth: 3,
                  ),
                  builder: (context, clusterMarkers) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(clusterMarkers.length.toString(), style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              )
            ],
          )),

          // UI
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
                child: Row(
                  spacing: 6.w,
                  children: [
                    Image.asset(
                      'assets/icons/caution.png',
                      width: 14.sp,
                      height: 14.sp,
                    ),
                    Text(
                      '지도에 표출되지 않는 주소는 직접 검색하면 시세가 나와요!',
                      style: TextStyle(
                        fontSize: 10.sp
                      ),
                    )
                  ],
                ),
              ),

              // 검색
              Container(
                color: Color(0xfff8f8f8),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                child: CustomTextfiled(
                  controller: TextEditingController(),
                  hintText: '건물명, 도로명, 지번, 초성 검색',
                  suffix: GestureDetector(
                    child: Image.asset(
                      'assets/icons/search.png',
                      width: 13.sp,
                      height: 13.sp,
                    ),
                  )
                )
              ),

              // 최근 조회
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Colors.grey))
                ),
                padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 14.w),
                child: Row(
                  children: [
                    Text('최근 시세 조회',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomTheme.mainColor
                      ),),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5)
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      height: 15.h,
                    ),
                    Text(
                      '서면 세종 그랑시아(08.17)',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: CustomTheme.subColor
                      ),),
                    const Spacer(),
                    Image.asset(
                      'assets/icons/down-arrow.png',
                      width: 13.sp,
                      height: 15.sp,)
                  ],
                ),
              ),

              // 줌 컨트롤 바
              Padding(
                padding: EdgeInsetsGeometry.symmetric(vertical: 50.h, horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    zoomControllBar(context),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/chatbot');
          },
          backgroundColor: Colors.white,
          highlightElevation: 0,
          shape: CircleBorder(
          side: BorderSide(
            color: Colors.blue,
            width: 2,     
          ),
        ),
          child: Image.asset(
            'assets/icons/chatbot.png',
            width: 36.w,
            height: 36.h,)
        ),
    ));
  }

  /// 줌 컨트롤 바
  Widget zoomControllBar(BuildContext context){
    return Obx(() => Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff6f6f6f)),
        color: Colors.white,
      ),
      width: 26.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: controller.zoomIn,
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Color.fromARGB(255, 202, 202, 202)))
              ),
              width: 24.w,
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Image.asset(
                'assets/icons/plus.png',
                width: 10.sp,
                height: 10.sp,),
            ),
          ),
          Container(
            color: Colors.white,
            child: RotatedBox(
              quarterTurns: 3,
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  activeTrackColor: const Color.fromARGB(255, 0, 136, 247),
                  inactiveTrackColor: Colors.grey[300],
                  thumbColor: Colors.red,
                  thumbShape: CustomThumbShape(
                    thumbWidth: 6,
                    thumbHeight: 14,
                  ),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 8),
                  tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 0),
                ),
                child: Slider(
                  value: controller.zoom.value,
                  min: 10,
                  max: 17,
                  divisions: ((17 - 10) / 0.5).round(),
                  onChanged: (val) => controller.setZoom(val),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: controller.zoomOut,
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color.fromARGB(255, 202, 202, 202)))
              ),
              width: 24.w,
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Image.asset(
                'assets/icons/minus.png',
                width: 10.sp,
                height: 10.sp,),
            ),
          ),
        ],
      ),
    ));
  }
}