import 'dart:convert';

import 'package:front_ds/models/CityModel.dart';
import 'package:http/http.dart' as http;

import '../configs/http_config.dart';


class CitiesRepository {

  int id;
  String token;
  String baseUrl=apiUrl;


  CitiesRepository(this.id, this.token);

  Future<List<CityModel>> getCities( int id) async{


    Map<String, String> headers={
      "Content-Type": "application/json",
      'Accept':'application/json',
      'Authorization': 'Bearer $token',
    };

    // var city_id=1;
    // String fullUrl='${baseUrl}v1/city-name/$id';
    String fullUrl='${baseUrl}v1/cities';

    print(fullUrl);
    final uri=Uri.parse(fullUrl);
    http.Response response= await http.get(uri, headers: headers);


    if(response.statusCode==200) {
      final List result = jsonDecode(response.body)['data'];
     // print(result.length);
      return result.map((e) => CityModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
    /*List<String> retreiverListOfCityName=['Choisir la ville'];
    List<int> retreiverListOfCityId=[];
    for (var element in (data as List)) {
      retreiverListOfCityName.add(element['intitule']);
      retreiverListOfCityId.add(element['id']);
    }*/

    //setState(() {
    //listOfCityName=retreiverListOfCityName;
    //listOfCityId=retreiverListOfCityId;
    //});

    //majListQuartier(retreiverListOfCityName);




  }
}