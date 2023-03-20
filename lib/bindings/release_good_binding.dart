import 'package:front_ds/controllers/release_good_controller.dart';
import 'package:get/get.dart';



class ReleaseGoodBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReleaseGoodController());
  }
}