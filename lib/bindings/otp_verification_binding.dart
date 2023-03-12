import 'package:get/get.dart';
import '../controllers/otp_verification_controller.dart';
import '../views/auth/otp_verification_view.dart';

class OtpVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerificationController());
  }
}