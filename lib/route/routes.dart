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

    // 챗봇 화면
    GetPage(
      name: '/chatbot',
      page: () => ChatbotView(),
      binding: ChatbotBinding(),
      popGesture: true,),
  ];
}