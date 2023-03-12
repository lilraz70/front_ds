import 'package:get/get.dart';
import '../configs/app_routes.dart';
import '../configs/session_data.dart';

class OnBoardingController extends GetxController {

  @override
  void onInit() {

    super.onInit();
  }


  @override
  void onClose() {

    super.onClose();
  }

  void getStarted() {
    Get.offAllNamed(
      RouteName.login,
      // arguments: {
      //   'isUpdate': false,
      // }
    );
    SessionData.setLaunchStatus(true);

  }

}