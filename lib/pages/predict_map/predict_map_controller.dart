import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dive_hug/common/location_service.dart';
import 'package:dive_hug/pages/predict_map/widgets/select_dong_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PredictMapController extends GetxController {
  final mapController = MapController();
  final markers = <Marker>[].obs;
  final selected = Rxn<Map<String, dynamic>>();
  final riskScore = 0.0.obs;

  // 내 위치 조회허가 + 지도 이동
  Future<void> getLocation() async {
    try {
      final position = await LocationService.getCurrentLocation();
      if (position != null) {
        log('위도: ${position.latitude} 경도: ${position.longitude}');
        moveTo(position.latitude, position.longitude);
        markers.add(
          Marker(
            point: LatLng(position.latitude, position.longitude), 
            child: Image.asset(
              'assets/icons/pin.png',
              width: 24.sp,
              height: 24.sp,))
        );
      }
    } catch (e) {
      log('에러: $e');
    }
  }

  // 위치 변경 함수
  void moveTo(double lat, double lng) {
    final newPos = LatLng(lat, lng);
    mapController.move(newPos, zoom.value);
  }

  Future<void> loadData() async {
    final jsonString = await rootBundle.loadString('assets/data/jeonse_data.json');
    final data = jsonDecode(jsonString) as List;
    markers.assignAll(
      data
        .where((e) => e['위도'] != null && e['경도'] != null)
        .map((e) => Marker(
          point: LatLng(e['위도'], e['경도']),
          child: GestureDetector(
            onTap: (){
              if(e['주택유형'] == '아파트'){
                Get.bottomSheet(
                  isScrollControlled: true,
                  SelectDongBottomsheet(building: e,)
                );
              } else {
                Get.toNamed('/buildingInfo', arguments: e);
              }
            },
            child: Image.asset(
              e['주택유형'] == '아파트'
                  ? 'assets/icons/apt_pin.png'
                  : 'assets/icons/home_pin.png')
          )
        ))
        .toList()
    );
  }

  @override
  void onInit() {
    super.onInit();

    getLocation();
    loadData();
  }

  // 줌 기능 
  var zoom = 16.0.obs;

  void zoomIn() {
    if (zoom.value < 17) {
      zoom.value = (zoom.value + 0.5).clamp(10, 17);
      mapController.move(mapController.camera.center, zoom.value);
    }
  }

  void zoomOut() {
    if (zoom.value > 10) {
      zoom.value = (zoom.value - 0.5).clamp(10, 17);
      mapController.move(mapController.camera.center, zoom.value);
    }
  }

  void setZoom(double value) {
    zoom.value = value.clamp(10, 17);
    mapController.move(mapController.camera.center, zoom.value);
  }
}