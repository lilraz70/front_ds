import 'package:get/get.dart';
import '../api/services/pub_services.dart';
import '../configs/app_routes.dart';
import '../functions/utils.dart';
import '../models/request_result.dart';

class PubController extends GetxController {


 Future<void> deletePub({required int id}) async {
    RequestResult result = await PubServices.deletePub(id: id);
    if (result.ok) {
      Get.offAllNamed(RouteName.myPubView);
      showMessage(type: "success",title: "Success", message: 'Publication supprimée avec succès');
    }else {
      Get.back();
     showMessage(type: "error",title: "Une erreur est survenue", message: 'Veuillez réessayez');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}