import 'package:get/get.dart';

import '../controllers/edit_pub_controller.dart';


class EditPubBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditPubController());
  }
}