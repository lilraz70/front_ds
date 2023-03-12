 import 'package:get/get.dart';
import '../controllers/google_controller.dart';


class GoogleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoogleController());
  }
}