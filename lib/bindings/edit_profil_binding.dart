
import 'package:front_ds/controllers/edit_profil_controller.dart';
import 'package:get/get.dart';




class EditProfilBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfilController());
  }
}