import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/services/google_sign_in_api.dart';
import '../api/services/pub_services.dart';
import '../api/services/user_services.dart';
import '../configs/app_routes.dart';
import '../configs/session_data.dart';

import '../functions/utils.dart';
import '../models/request_result.dart';

import '../models/user.dart';

class PubController extends GetxController {


 Future<void> deletePub({required int id}) async {
    RequestResult result = await PubServices.deletePub(id: id);
    if (result.ok) {
      Get.offAllNamed(RouteName.home);
    }else {
     showMessage(type: 'error', message: 'Une erreur est survenue, veuillez réessayez');
    }
  }
}
