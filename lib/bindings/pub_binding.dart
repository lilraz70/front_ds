 import 'package:get/get.dart';
import '../controllers/google_controller.dart';
import '../controllers/pub_controller.dart';


class PubBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PubController());
  }
}