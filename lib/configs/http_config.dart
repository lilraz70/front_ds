import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/request_result.dart';
import '../utils/methods.dart';
import 'session_data.dart';


getUserAccess()async {
  return Methods.getUserAccess();
}

Map user = SessionData.getUser();
String userAccess = user["telephone"];
String token = SessionData.getToken();
const String apiUrl='http://192.168.1.73:8000/api/';
const authorization = "Bearer ";
const url = "http://192.168.1.73:8000";
const baseUrl = "$url/api";
const baseResourceUrl = "$url/storage/";
const contentType = "application/json; charset=UTF-8";


Future<RequestResult> httpGET(String route, [dynamic data]) async {

  final header = token.isNotEmpty ? {
    "Content-Type": contentType,
    "Authorization": authorization+token,
  } : {
    "Content-Type": contentType,
  };
  var dataStr = jsonEncode(data);
  if(data !=null){
    var url = "$baseUrl$route?data=$dataStr";
    try {
    var result = await http.get(Uri.parse(url), headers: header);
    print(jsonDecode(result.body));
      return RequestResult(true, jsonDecode(result.body));
    } catch(exception) {
      return RequestResult(false, null);
    }
  }else {
    var url = "$baseUrl$route";
    try {
    var result = await http.get(Uri.parse(url), headers: header);
      return RequestResult(true, jsonDecode(result.body));
    } catch(exception) {
      return RequestResult(false, null);
    }
  }


}

Future<RequestResult> httpPOST(String route, [dynamic data]) async {
  final header = token.isNotEmpty ? {
    "Content-Type": contentType,
    "Authorization": authorization+token,
  } : {
    "Content-Type": contentType,
  };
  var dataStr = jsonEncode(data);
  var url = "$baseUrl$route?data=$dataStr";
  try {
  var result = await http.post(Uri.parse(url), body: dataStr, headers: header);
    return RequestResult(true, jsonDecode(result.body));
  } catch(exception) {
    return RequestResult(false, null);
  }
}

Future<RequestResult> firstHttpPOST(String route, [dynamic data]) async {

  final header =  {
    "Content-Type": contentType,
  };

  var dataStr = jsonEncode(data);
  var url = "$baseUrl$route?data=$dataStr";
  try{
  var result = await http.post(Uri.parse(url), body: dataStr, headers: header);
    return RequestResult(true, jsonDecode(result.body));
  } catch(exception) {
    return RequestResult(false, null);
  }
}

Future<RequestResult> httpPUT(String route, [dynamic data]) async {
  final header = token.isNotEmpty ? {
    "content-type": contentType,
    "Authorization": authorization+token,
  } : {
    "content-type": contentType,
  };

  var url = baseUrl+route;

  var dataStr = jsonEncode(data);
  try{
  var result = await http.put(Uri.parse(url), body: dataStr, headers: header);
    return RequestResult(true, jsonDecode(result.body));
  }catch(exception){
    return RequestResult(false, null);
  }
}

Future<RequestResult> httpDELETE(String route, [dynamic data]) async {

  final header = token.isNotEmpty ? {
    "content-type": contentType,
    "Authorization": authorization+token,
  } : {
    "content-type": contentType,
  };
  var url = baseUrl+route;
  try{
  var result = await http.delete(Uri.parse(url), headers: header);
    return RequestResult(true, jsonDecode(result.body));
  }catch(exception){
    return RequestResult(false, null);
  }

}

