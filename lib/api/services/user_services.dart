import 'package:get/get.dart';

import '../../configs/http_config.dart';
import '../../configs/session_data.dart';

import '../../models/request_result.dart';
import '../../models/user.dart';

class UserServices {
  static Map authUser = SessionData.getUser();
  static Future<RequestResult> googleRegister(User user) async {
    var request = await firstHttpPOST("/store_user", {
      'name': user.name,
      'pseudo': user.pseudo,
      'telephone':user.telephone,
      'photo_de_profil': user.photo_de_profil  == null ?   user.photo_de_profil : null,
      'google_id': user.google_id
    });
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);

    } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> facebookRegister(User user) async {
    var request = await firstHttpPOST("/store_user", {
      'name': user.name,
      'pseudo': user.pseudo,
      'telephone':user.telephone,
      'photo_de_profil': user.photo_de_profil  == null ?   user.photo_de_profil : null,
      'facebook_id': user.facebook_id
    });
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> register(User user) async {
    var request = await firstHttpPOST("/store_user", {
      'name': user.name,
      'pseudo': user.pseudo,
      'telephone':user.telephone,
    });
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> getUserByGoogle(
      String google_id,) async {
    var request = await firstHttpPOST(
        "/user_login_by_google", {"google_id": google_id});
    if (request.data['success'] == true) {
      return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }

  static Future<RequestResult> getUserByFacebook(
      String facebook_id,) async {
    var request = await firstHttpPOST(
        "/user_login_by_facebook", {"facebook_id": facebook_id});
    if (request.data['success'] == true) {
        return RequestResult(true, request.data);
      } else {
      return RequestResult(false, request.data);
    }
  }
  static Future<RequestResult> getUserByPhone({
      required String telephone}) async {
    var request = await firstHttpPOST(
        "/user_login_by_phone", {'telephone': telephone,});
    if (request.data['success'] == true) {
        return RequestResult(true, request.data);
    } else {
      return RequestResult(false, request.data);
    }
  }

  static Future<RequestResult> update(User user) async {
    var request = await httpPUT("/v1/update_user/${authUser['id']}", {
      'name': user.name,
      'pseudo': user.pseudo,
      'telephone':user.telephone,
    });
    if (request.ok) {
      if (request.data['success'] == true) {
        return RequestResult(true, request.data);
      } else {
        return RequestResult(false, request.data);
      }
    } else {
      return RequestResult(false, request.data);
    }
  }

  static Future<RequestResult> existToApp() async {
      var request = await httpPOST("/logout");
      if (request.data['success'] == true) {
      return RequestResult(true, request.data);
      }else{
       return RequestResult(false, request.data);
      }
  }
}
