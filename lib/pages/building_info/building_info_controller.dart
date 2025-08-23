import 'dart:convert';
import 'dart:developer';
import 'package:dive_hug/pages/predict_map/models/risk_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class BuildingInfoController extends GetxController {
  Map building = Get.arguments;

  TextEditingController priceController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController depositController = TextEditingController();

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

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(building);
  }
}