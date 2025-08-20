import 'package:get/get.dart';
import 'package:dive_hug/pages/predict_map/predict_map_controller.dart';

class PredictMapBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => PredictMapController());
  }
}