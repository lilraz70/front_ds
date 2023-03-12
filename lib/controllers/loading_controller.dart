import 'package:get/get.dart';

class LoadingController extends GetxController {

  Future<void> init = Get.arguments['init'];
  String text = Get.arguments['text'];

  @override
  void onInit() {
    init;
    text;
    super.onInit();
  }


  @override
  void onClose() {
    init;
    text;
    super.onClose();
  }

}