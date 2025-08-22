import 'dart:async';
import 'dart:convert';
import 'package:dive_hug/pages/predict_map/widgets/predict_bottomsheet.dart';
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
              Get.bottomSheet(
                isScrollControlled: true,
                PredictBottomsheet(building: e,),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              width: 6.sp, height: 6.sp,)),
        ))
        .toList()
    );
  }

  @override
  void onInit() {
    super.onInit();

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