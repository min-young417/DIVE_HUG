import 'package:dive_hug/pages/building_info/building_info_binding.dart';
import 'package:dive_hug/pages/building_info/building_info_view.dart';
import 'package:dive_hug/pages/chatbot/chatbot_binding.dart';
import 'package:dive_hug/pages/chatbot/chatbot_view.dart';
import 'package:dive_hug/pages/predict_map/predict_map_binding.dart';
import 'package:dive_hug/pages/predict_map/predict_map_view.dart';
import 'package:get/get.dart';

class GetXRouter {
  static final routes = [
    // 예측 지도 화면
    GetPage(
      name: '/predictMap',
      page: () => PredictMapView(),
      binding: PredictMapBinding(),
      popGesture: true,),
    
    // 주택 정보 조회 화면
    GetPage(
      name: '/buildingInfo',
      page: () => BuildingInfoView(),
      binding: BuildingInfoBinding(),
      popGesture: true,),

    // 챗봇 화면
    GetPage(
      name: '/chatbot',
      page: () => ChatbotView(),
      binding: ChatbotBinding(),
      popGesture: true,),
  ];
}