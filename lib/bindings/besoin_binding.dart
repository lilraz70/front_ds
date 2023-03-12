 import 'package:get/get.dart';

import '../controllers/besoin_controller.dart';





class BesoinBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BesoinController());
  }
}