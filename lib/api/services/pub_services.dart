import 'package:get/get.dart';

import '../../configs/http_config.dart';
import '../../configs/session_data.dart';

import '../../models/request_result.dart';
import '../../models/user.dart';

class PubServices {
  static Map authUser = SessionData.getUser();

  static Future<RequestResult> deletePub({required int id}) async {
    var request = await httpGET(
        "/destroye-release-good/$id",);
    if (request.ok) {
        return RequestResult(true, request.data);
      } else {
      return RequestResult(false, request.data);
    }
  }

}
