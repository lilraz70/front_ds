import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/ReleaseGoodModel3.dart';
import '../widgets/displayReleaseGoodWidgetOfUser.dart';

class MesPubs extends StatefulWidget {
   const MesPubs({Key? key}) : super(key: key);

  @override
  State<MesPubs> createState() => _MesPubsState();
}
List<ReleaseGoodModel3> triUser(List<ReleaseGoodModel3> listOfReleaseGoodModel) {
    final listTri = listOfReleaseGoodModel.where((element) {
      return element.userId == user['id'];
    }).toList();

   // print(listTri.length);
    return listTri;
}
class _MesPubsState extends State<MesPubs> {

  Future<List<ReleaseGoodModel3>> retreiveReleaseGood() async {


    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.Response response2 = await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );


    if(response2.statusCode==200) {
      final List result = jsonDecode(response2.body);

      listOfReleaseGoodsInitial= result.map((e) => ReleaseGoodModel3.fromJson(e)).toList();
    }else{

      //return retreiveReleaseGood(fullUrl, token);
      throw Exception(response2.reasonPhrase);
    }

    // listOfReleaseGoodsToDisplay=triUser(listOfReleaseGoodsInitial);

    //setState(() {
      listOfReleaseGoodsToDisplay=listOfReleaseGoodsInitial;
   // });



    return listOfReleaseGoodsToDisplay;
  }

  Widget releaseGoodWidget(){

    return FutureBuilder<List<ReleaseGoodModel3>>(

        future: retreiveReleaseGood(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                // if (snapshot.hasError.toString().contains('FormatException')) {
                if (snapshot.error.toString().contains('FormatException') ) {
                  return releaseGoodWidget();
                }else {
                  return Center(
                    child: Text('Erreur: ${snapshot.error}'),
                  );
                }
                //
              } else if (snapshot.hasData) {

                if(listOfReleaseGoodsToDisplay.isEmpty) {
                  return const Center(child: Text('Vous n\'avez fait aucune publication', style: TextStyle(color: Colors.redAccent),));
                }else {
                  return const DisplayReleaseWidgetOfUser();
                }
              } else {

                return const Center(child: Text('Aucune données chargée'));

              }
          }
        });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [


            Expanded(child: releaseGoodWidget()),

            const SizedBox(height: 15,),

            FloatingActionButton(
                elevation: 7,
                onPressed: (){
                  Get.offAllNamed(
                    RouteName.storeReleaseGood,
                  );
             // context.push('/storeReleaseGood');
            },
                child: const Icon(Icons.add, color: Colors.white,))
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title:  Title(color: Colors.white, child: const Text('Mes publications', style: TextStyle(fontSize: 22),),),



      ),
    );
  }

/*  @override
  void didUpdateWidget(covariant MesPubs oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      retreiveReleaseGood().then((value) => {
        listOfReleaseGoodsToDisplay=listOfReleaseGoodsInitial
      });
    });


  }*/
}

late List<ReleaseGoodModel3> listOfReleaseGoodsInitial;
late List<ReleaseGoodModel3> listOfReleaseGoodsToDisplay;
var fullUrl = '${apiUrl}v1/release-goods-search/${user['id']}';
