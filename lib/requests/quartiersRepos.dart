import 'package:front_ds/models/QuartierModel.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/http_config.dart';

class QuartiersRepository {

  String token;
  int cityId;
  QuartiersRepository(this.token, this.cityId);
  String baseUrl= apiUrl;

  Future getQuartiers() async {
//await Future.delayed(Duration(seconds: 30));
// print('retreiveReleaseGood $token');


    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

//      var city_id=1;
    String fullUrl = '${baseUrl}v1/quartiers-search/?&setcity=$cityId';

    print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response = await http.get(uri, headers: headers);


    //var data = jsonDecode(response2.body.toString());


    if(response.statusCode==200) {
      final List result = jsonDecode(response.body);
      print(result.length);
      return result.map((e) => QuartierModel.fromJson(e)).toList();
    }else{
      throw Exception(response.statusCode);
    }

    /*retreiverListOfQuartierName = ['Choisir le quartier'];
    retreiverListOfQuartierId = [];
    for (var element in (data as List)) {
      retreiverListOfQuartierName.add(element['intitule']);
      retreiverListOfQuartierId.add(element['id']);
    }*/


    //listOfQuartierId = retreiverListOfQuartierId;
    //majListQuartier(retreiverListOfQuartierName);
    //return data;
  }

  void setCityId(int id){
    cityId=id;
  }
}