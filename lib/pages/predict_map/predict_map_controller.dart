import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dive_hug/pages/predict_map/models/risk_response.dart';
import 'package:dive_hug/pages/predict_map/widgets/predict_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
                PredictBottomsheet(
                  building: e,
                  predictAndExplain: predictAndExplain
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('assets/icons/building.png'))
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

  // 위험도 예측
  var isLoading = false.obs;

  Future<RiskResponse?> predictAndExplain(Map data) async {
    try {
      isLoading.value = true;

      final url = Uri.parse(dotenv.env['PREDICT_MODEL_SERVER_URL']!);
      final body = {
        "보증시작월": data['applicationMonth'],
        "보증완료월": data['expiryMonth'],
        "주택가액": data['jeonsePrice'],
        "임대보증금액": data['depositAmount'],
        "선순위": data['seniority'],
        "시도": data['region'],
        "주택구분": data['housingType'],
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RiskResponse.fromJson(data);
      } else {
        log("Error: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      log("Exception: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
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