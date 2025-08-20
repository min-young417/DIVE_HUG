import 'package:dive_hug/pages/predict_map/predict_map_binding.dart';
import 'package:dive_hug/pages/predict_map/predict_map_view.dart';
import 'package:get/get.dart';

class GetXRouter {
  static final routes = [
    // 예측 지도 화면
    GetPage(
      name: '/',
      page: () => PredictMapView(),
      binding: PredictMapBinding(),
      popGesture: true,),
  ];
}