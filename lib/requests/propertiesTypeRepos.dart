import 'package:front_ds/models/PropertyModel.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../configs/http_config.dart';


class PropertiesTypeRepository{

  String token;
  String baseUrl=apiUrl;
  PropertiesTypeRepository(this.token);

  Future getProperties() async {
    //await Future.delayed(Duration(seconds: 30));
    // print('retreiveReleaseGood $token');


    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // var city_id=1;
    String fullUrl = '${baseUrl}v1/property-types';

    print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response = await http.get(uri, headers: headers);


    var data = jsonDecode(response.body.toString());

    if(response.statusCode==200) {
      final List result = jsonDecode(response.body)['data'];
      // print(result.length);
      return result.map((e) => PropertyModel.fromJson(e)).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }


    // print('${data['id']}');
   /* PropertyTypeModel propertyTypeModel = PropertyTypeModel.fromJson(data);


    List<String> retreiverListOfCityName=['Choisir le type'];
    List<int> retreiverListOfCityId=[];
    for (var element in (data as List)) {
      retreiverListOfCityName.add(element['intitule']);
      retreiverListOfCityId.add(element['id']);
    }

    //setState(() {
    listOfCityName=retreiverListOfCityName;
    listOfCityId=retreiverListOfCityId;
    //});

    //majListQuartier(retreiverListOfCityName);

    listOfProperty = ['Choisir le type'];
    propertyTypeModel.data!.removeAt(6);
    propertyTypeModel.data!.removeAt(6);

    for (var element in propertyTypeModel.data!) {
      listOfProperty.add(element.intitule!);
      listOfPropertyId.add(element.id!.toInt());
    }*/
    return data;
  }
}