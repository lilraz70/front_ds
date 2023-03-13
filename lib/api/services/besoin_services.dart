import 'package:get/get.dart';

import 'package:nb_utils/nb_utils.dart';

import '../../configs/http_config.dart';
import '../../configs/session_data.dart';

import '../../models/request_result.dart';
import '../../models/user.dart';

class BesoinServices {
  static Map authUser = SessionData.getUser();
  static Future<RequestResult> postBesoin({required String description, required String titre}) async {
    var request = await httpPOST("/v1/besoins/", {
      'userId': authUser['id'],
      'description': description,
      'titre': titre,
    });
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);

    } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> editBesoin({required int id,required String description, required String titre}) async {
    var request = await httpPUT("/v1/besoins/$id", {
      'description': description,
      'titre': titre,
    });
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);

    } else {
      return RequestResult(false, request.data);
    }
  }

  static Future<RequestResult> getAllBesoin({required int page}) async {
    var request = await httpGET("/v1/besoins/?page=$page");
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> deleteBesoin(int? id) async {
    var request = await httpDELETE("/v1/besoins/$id");
    if (request.ok) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, false);
    }
  }
  static Future<RequestResult> getUserBesoin({required int id,required int page}) async {
    var request = await httpGET("/v1/user-besoin/$id?page=$page");
    if (request.ok) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }
}
