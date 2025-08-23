import 'package:dive_hug/pages/building_info/building_info_controller.dart';
import 'package:get/get.dart';

class BuildingInfoBinding extends Bindings {
  
  @override
  void dependencies() {
    Get.lazyPut(() => BuildingInfoController());
  }
}