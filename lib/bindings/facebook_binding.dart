 import 'package:get/get.dart';

import '../controllers/facebook_controller.dart';


class FacebookBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FacebookController());
  }
}