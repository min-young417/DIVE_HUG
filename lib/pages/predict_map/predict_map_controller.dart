import 'dart:async';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

class PredictMapController extends GetxController {
  final naverMapController = Completer<NaverMapController>();

  // 줌 기능 
  var zoom = 13.0.obs;

  void zoomIn() async {
    if (zoom.value < 15){
      zoom.value = (zoom.value + 0.5).clamp(10, 15);
      final controller = await naverMapController.future;
      controller.updateCamera(NCameraUpdate.scrollAndZoomTo(zoom: zoom.value));
    }
  }

  void zoomOut() async {
    if (zoom.value > 10){
      zoom.value = (zoom.value - 0.5).clamp(5, 15);
      final controller = await naverMapController.future;
      controller.updateCamera(NCameraUpdate.scrollAndZoomTo(zoom: zoom.value));
    }
  }

  void setZoom(double value) async {
    zoom.value = value;
    final controller = await naverMapController.future;
    controller.updateCamera(NCameraUpdate.scrollAndZoomTo(zoom: value));
  }
}