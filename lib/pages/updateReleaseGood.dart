import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/models/PropertyTypeModel.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:front_ds/widgets/mediumText.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/Conveniences.dart';
import '../models/ReleaseGoodModel3.dart';
import '../widgets/cardItemCheckbox2.dart';
import '../widgets/cardItemPlusOuMoins2.dart';


class UpdateReleaseGood extends StatefulWidget {

  // final ville,quartier,type, dateDeLibre,loyer,comment,tel,cond;

 final releaseGoodString;

   UpdateReleaseGood({super.key,
     required this.releaseGoodString,
     });


  @override
  State<UpdateReleaseGood> createState() => _UpdateReleaseGoodState();


   Future retreiveDropdownQuartierInfo() async {
//await Future.delayed(Duration(seconds: 30));
// print('retreiveReleaseGood $token');


     Map<String, String> headers = {
       "Content-Type": "application/json",
       'Accept': 'application/json',
       'Authorization': 'Bearer $token',
     };

// var city_id=1;
     String fullUrl = '${baseUrl}v1/quartiers-search/?&setcity=$cityId';

   //  print(fullUrl);
     final uri = Uri.parse(fullUrl);
     http.Response response2 = await http.get(uri, headers: headers);


     var data = jsonDecode(response2.body.toString());


     retreiverListOfQuartierName = ['Choisir le quartier'];
     retreiverListOfQuartierId = [];
     for (var element in (data as List)) {
       retreiverListOfQuartierName.add(element['intitule']);
       retreiverListOfQuartierId.add(element['id']);
     }


     listOfQuartierId = retreiverListOfQuartierId;
     //majListQuartier(retreiverListOfQuartierName);
     return data;
   }

   Future retreiveDropdownInfoPropertyType() async {
     if (listOfProperty.length == 1) {


       Map<String, String> headers = {
         "Content-Type": "application/json",
         'Accept': 'application/json',
         'Authorization': 'Bearer $token',
       };

       // var city_id=1;
       String fullUrl = '${baseUrl}v1/property-types';

       // print(fullUrl);
       final uri = Uri.parse(fullUrl);
       http.Response response2 = await http.get(uri, headers: headers);


       var data = jsonDecode(response2.body.toString());

       // print('${data['id']}');


       PropertyTypeModel propertyTypeModel = PropertyTypeModel.fromJson(data);


       /*  List<String> retreiverListOfCityName=['Choisir le type'];
      List<int> retreiverListOfCityId=[];
      for (var element in (data as List)) {
        retreiverListOfCityName.add(element['intitule']);
        retreiverListOfCityId.add(element['id']);
      }

      //setState(() {
      listOfCityName=retreiverListOfCityName;
      listOfCityId=retreiverListOfCityId;*/
       //});

       //majListQuartier(retreiverListOfCityName);

       listOfProperty = ['Choisir le type'];
       propertyTypeModel.data!.removeAt(6);
       propertyTypeModel.data!.removeAt(6);

       for (var element in propertyTypeModel.data!) {
         listOfProperty.add(element.intitule!);
         listOfPropertyId.add(element.id!.toInt());
       }
       return data;
     } else {
       return listOfProperty;
     }
   }

   String formatDatePresentation(String? dateStr) {
     var outputFormat = DateFormat('dd-MM-yyyy');
     DateTime dateTime = DateTime.parse(dateStr!);

     var outputDate = outputFormat.format(dateTime);
     return outputDate;
   }

   Future retreiveDropdownCitiesInfo() async {
     if (listOfCityName.length == 1) {
       //String tk = '594|u2Rel1CfyBDaLRK36NXCDkP0XILHB5Sa1oqQxhT3';

       Map<String, String> headers = {
         "Content-Type": "application/json",
         'Accept': 'application/json',
         'Authorization': 'Bearer $token',
       };

       String fullUrl = '${baseUrl}v1/city-name/$countryId';

       // print(fullUrl);
       final uri = Uri.parse(fullUrl);
       http.Response response2 = await http.get(uri, headers: headers);


       var data = jsonDecode(response2.body.toString());

       // print('${data['id']}');



       List<String> retreiverListOfCityName = ['Choisir la ville'];
       List<int> retreiverListOfCityId = [];
       for (var element in (data as List)) {
         retreiverListOfCityName.add(element['intitule']);
         retreiverListOfCityId.add(element['id']);
       }

       //setState(() {
       listOfCityName = retreiverListOfCityName;
       listOfCityId = retreiverListOfCityId;
       //});

       //majListQuartier(retreiverListOfCityName);

       return data;
     } else {
       return listOfCityName;
     }
   }

   void majListQuartier(List<String> list) {
     listOfQuartierName = list;
   }
}

class _UpdateReleaseGoodState extends State<UpdateReleaseGood> {

  Future initializing() async {
    var data=jsonDecode(widget.releaseGoodString);
    releaseGood=ReleaseGoodModel3.fromJson(data);

    prix=releaseGood.cout.toString();
    localisation=releaseGood.localisation.toString().compareTo('null')==0 ? '' : releaseGood.localisation.toString();
    conditions=releaseGood.conditionsBailleur;
    commentaire=releaseGood.commentaires.toString().compareTo('null')==0 ? '' : releaseGood.commentaires.toString();
    contact=releaseGood.contactBailleur;
    quartierSelectionne=releaseGood.quartier!.intitule!;
    villeSelectionnee=releaseGood.city!.intitule!;
    typeSelectionne=releaseGood.propertytype!.intitule!;
    cityId=int.parse(releaseGood.cityId.toString());
    quartierId=int.parse(releaseGood.quartierId.toString());
    propertyId=int.parse(releaseGood.propertytypeId.toString());
    dateDeLiberation=formatDatePresentation(releaseGood.dateSortiPrevu);
    dateTimeChoosen=DateTime.parse(releaseGood.dateSortiPrevu!);

    if(releaseGood.releasegoodconvenience != null) {
      for(var rgc in releaseGood.releasegoodconvenience!){
      rgcIds.add(int.parse(rgc.id.toString()));
    }
    }

   await retreiveDropdownQuartierInfo().then((value) {
      majListQuartier(retreiverListOfQuartierName);
    });

  }
    void majListQuartier(List<String> list) {
      listOfQuartierName = list;
    }

  Future retreiveReleaseGood() async {

    var fulUrl = '${apiUrl}v1/release-goods-search/${user['id']}';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.Response response2 = await http.get(
      Uri.parse(fulUrl),
      headers: headers,
    );

    List<ReleaseGoodModel3> listOfReleaseGoods;
    if(response2.statusCode==200) {
      final List result = jsonDecode(response2.body);

      listOfReleaseGoods= result.map((e) => ReleaseGoodModel3.fromJson(e)).toList();
    }else{

      //return retreiveReleaseGood(fullUrl, token);
      throw Exception(response2.reasonPhrase);
    }

    return response2;
  }
  List<Widget> generateListOfConveniencePlusOrMinus(List<Conveniences> listOfConvenience) {
    List<Widget> list = [];

    for (var element in (listOfConvenience)) {
      if (element.morethanone == 1) {
        list.add(CardItemPlusOrMinus2(
          position: listOfConvenience.indexOf(element),
          convenience: element,
          list: nbConvList, counter: nbConvList[listOfConvenience.indexOf(element)],));
        nbConvPlusOrMinus++;
      }
    }


    return list;
  }

  List<Widget> generateListOfConvenienceCheckBox(
      List<Conveniences> listOfConvenience) {
    List<Widget> list = [];
    for (var element in (listOfConvenience)) {
      if (element.morethanone == 0) {
        list.add(CardItemCheckBox2(position: listOfConvenience.indexOf(element),
          convenience: element,
          list: nbConvList,
          checkBoxValue: (nbConvList[listOfConvenience.indexOf(element)]==1) ? true : false,));
        nbConvPlusOrMinus++;
      }
    }


    return list;
  }

  Widget chambreTile() {
    return StatefulBuilder(builder: (context, funct) {
      return ListTile(

        title: MediumText(text: "Chambre",),
        //title: MediumText(text: widget.title),
        leading:  Image.asset(
          'assets/icon/android/lit.png',
          color: AppColors.mainColor,
          height: 45,
          width: 45,
        ),
        trailing: SizedBox(
          width: 200,
          child: Wrap(alignment: WrapAlignment.start,

            children: [
              Row(
                children: <Widget>[
                  IconButton(onPressed: () {
                    if (nbChambre > 0) {
                      funct(() {
                        nbChambre--;
                      });
                    }
                  }, icon: const Icon(Icons.remove)),
                  MediumText(text: "$nbChambre"),
                  IconButton(onPressed: () {
                    funct(() {
                      nbChambre++;
                    });
                  }, icon: const Icon(Icons.add)),


                ],
              )
            ],),
        ),
      );
    });
  }

  String recupConvIdsAndCount() {
    String ids = "";
    newConvNb = "";
    int i = 0;
    for (var count in nbConvList) {
      if (count > 0 && !checkedConvIds.contains(listOfConvenience.elementAt(i).id)) { // si l'élément de nbConvList est > 0 et ne fait pas parti des conveniences venus cochés
        ids = "${listOfConvenience.elementAt(i).id},$ids";
        newConvNb = "$count,$newConvNb";
      }
      i++;
    }

    if (ids.isNotEmpty) {
      ids = ids.substring(0, ids.length - 1);
      newConvNb = newConvNb.substring(0, newConvNb.length - 1);
    }


    return ids.toString();
  }

   /* String recupConvIdsAnnules() {
      String ids = "";
      int i = 0;
      for (var count in nbConvList) {
        if (count == 0 && checkedConvIds.contains(listOfConvenience.elementAt(i).id)) { // si l'élément de nbConvList est > 0 mais fait pas parti des conveniences venus cochés
          ids = "${listOfConvenience.elementAt(i).id},$ids";
          convNbAnnules = "$count,$convNb";
        }
        i++;
      }

      if (ids.isNotEmpty) {
        ids = ids.substring(0, ids.length - 1);
        convNb = convNb.substring(0, convNb.length - 1);
      }


      return ids.toString();
    }*/

    /*String recupConvIdsModifies() {
      String ids = "";
      int i = 0;
      for (var count in nbConvList) {
        if (count > 0 && checkedConvIds.contains(listOfConvenience.elementAt(i).id)) { // si l'élément de nbConvList est > 0 mais fait pas parti des conveniences venus cochés
          ids = "${listOfConvenience.elementAt(i).id},$ids";
          convNbModifies = "$count,$convNb";

        }
        i++;
      }

      if (ids.isNotEmpty) {
        ids = ids.substring(0, ids.length - 1);
        convNb = convNb.substring(0, convNb.length - 1);
      }


      return ids.toString();
    }*/

    void recupConvIdsUpdated() {
      int i = 0;
      updatedConvIds.clear();
      nbConvUpdated.clear();
      for (var count in nbConvList) {
        if (count > 0 && checkedConvIds.contains(listOfConvenience.elementAt(i).id)) { // si l'élément de nbConvList est > 0 mais fait pas parti des conveniences venus cochés
          nbConvUpdated.add(count);
          updatedConvIds.add(listOfConvenience.elementAt(i).id);
        }
        i++;
      }
    }

    void recupConvIdsDeleted() {

      int i = 0;
      deletedConvIds.clear();
      for (var count in nbConvList) {
        if (count == 0 && checkedConvIds.contains(listOfConvenience.elementAt(i).id)) { // si l'élément de nbConvList est > 0 mais fait pas parti des conveniences venus cochés
          deletedConvIds.add(listOfConvenience.elementAt(i).id);
        }
        i++;
      }

    }

  String formatDatePresentation(String? dateStr) {
    var outputFormat = DateFormat('dd-MM-yyyy');
    DateTime dateTime = DateTime.parse(dateStr!);

    var outputDate = outputFormat.format(dateTime);
    return outputDate;
  }

  String formatDateBD(DateTime dateTime) {
    var outputFormat = DateFormat('yyyy-MM-dd');
    var outputDate = outputFormat.format(dateTime);
    return outputDate;
  }

  Widget datePicker() {
    dateDeLiberation= formatDatePresentation(DateTime.now().toString());
    return StatefulBuilder(builder: (context, funct) {
      return
        Container(

          height: 45,
          width: 150,
          margin: const EdgeInsets.only(left: 20, right: 20),

          // padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColors.mainColor
          ),

          child: ElevatedButton(

            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              // foreground
              elevation: 10,
              shape: BeveledRectangleBorder(),
              alignment: Alignment.centerRight,


            ),

            onPressed: () {
              showDatePicker(context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025),
              ).then((value) {
                dateTimeChoosen = value!;
                funct(() =>
                {
                  //dateDeLiberation = DateFormat.yMd().format(value!)
                  dateDeLiberation = formatDatePresentation(value.toString())
                });
              });
            },
            //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
            child: Row(
              children: [
                const Icon(Icons.date_range_rounded),
                const SizedBox(width: 15,),
                Text('Libération prévue le: ${dateDeLiberation}'),
              ],

              //majDate(date)
            ),
          ),
          //child: SmallText(text: 'Se Connecter'),
          // child:TextButton(onPressed: (){}, child: SmallText(text: 'Connexion'),),
        );
    });
  }

  int retreiveReleaseGoodConvId(int convId){
    final releaseGoodConv = releaseGood.releasegoodconvenience!.where((element) {
      return int.parse(element.conveniencetypeId) == convId;
    }).toList();

    return int.parse(releaseGoodConv.first.id.toString());
  }
  Future update() async {
//await Future.delayed(Duration(seconds: 30));



    dateDeLiberation = formatDateBD(dateTimeChoosen);

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };


     String fullUrl="${baseUrl}v1/release-goods/${releaseGood.id}?date_sorti_prevu=$dateDeLiberation&setcountry_id=$countryId&city_id=$cityId&quartier_id=$quartierId&nb_chambre=$nbChambre&cout=$prix&loyer_augmentera=false&user_access=$userAccess&emergencylevel_id=1&propertytype_id=$propertyId&localisation=$localisation&commentaires=$commentaire&conditions_bailleur=$conditions&contact_bailleur=$contact&date_limite=12/12/23&conveniencetype_ids=$newConvIDs&conveniencetype_nb=$newConvNb";


    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.patch(uri, headers: headers);
    return response2;
  }


    Future updateReleaseGoodConvenience(int convenienceId) async {

      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      int releaseGoodConvId=retreiveReleaseGoodConvId(convenienceId);

      String fullUrl="${baseUrl}v1/release-good-conveniences/$releaseGoodConvId?releasegood_id=${releaseGood.id}&conveniencetype_id=$convenienceId&number=${nbConvUpdated[updatedConvIds.indexOf(convenienceId)]}";

     // print(fullUrl);

      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.patch(uri, headers: headers);


      //var data= jsonDecode(response2.statusCode.toString());
      //print(data);

      return response2;
    }

    Future deleteReleaseGoodConvenience(int convenienceId) async {


      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      int releaseGoodConvId=retreiveReleaseGoodConvId(convenienceId);

      String fullUrl="${baseUrl}v1/release-good-conveniences/$releaseGoodConvId";

     // print(fullUrl);

      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.delete(uri, headers: headers);


      //var data= jsonDecode(response2.statusCode.toString());
      //print(data);

      return response2;
    }

    Future retreiveDropdownQuartierInfo() async {
//await Future.delayed(Duration(seconds: 30));
// print('retreiveReleaseGood $token');


      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

// var city_id=1;
      String fullUrl = '${baseUrl}v1/quartiers-search/?&setcity=$cityId';

      //print(fullUrl);
      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.get(uri, headers: headers);


      var data = jsonDecode(response2.body.toString());


      retreiverListOfQuartierName = ['Choisir le quartier'];
      retreiverListOfQuartierId = [];
      for (var element in (data as List)) {
        retreiverListOfQuartierName.add(element['intitule']);
        retreiverListOfQuartierId.add(element['id']);
      }


      listOfQuartierId = retreiverListOfQuartierId;
      //majListQuartier(retreiverListOfQuartierName);
      return data;
    }

    Future retreiveDropdownInfoPropertyType() async {
      if (listOfProperty.length == 1) {


        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        // var city_id=1;
        String fullUrl = '${baseUrl}v1/property-types';

        //print(fullUrl);
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);


        var data = jsonDecode(response2.body.toString());

        // print('${data['id']}');


        PropertyTypeModel propertyTypeModel = PropertyTypeModel.fromJson(data);


        /*  List<String> retreiverListOfCityName=['Choisir le type'];
      List<int> retreiverListOfCityId=[];
      for (var element in (data as List)) {
        retreiverListOfCityName.add(element['intitule']);
        retreiverListOfCityId.add(element['id']);
      }

      //setState(() {
      listOfCityName=retreiverListOfCityName;
      listOfCityId=retreiverListOfCityId;*/
        //});

        //majListQuartier(retreiverListOfCityName);

        listOfProperty = ['Choisir le type'];
        propertyTypeModel.data!.removeAt(6);
        propertyTypeModel.data!.removeAt(6);

        for (var element in propertyTypeModel.data!) {
          listOfProperty.add(element.intitule!);
          listOfPropertyId.add(element.id!.toInt());
        }
        return data;
      } else {
        return listOfProperty;
      }
    }
    Widget propertyTypeWidgets() {

      return FutureBuilder(

          future: retreiveDropdownInfoPropertyType(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        items: const [],
                        hint: const Text('Chargement...'),
                        iconSize: 5,
                        elevation: 5,
                        onChanged: (String? newValue) {

                        }
                    ),

                    const SizedBox(width:25, height:25,child: CircularProgressIndicator(color: Colors.indigo)),
                  ],
                );
              case ConnectionState.done:
              default:
                if (snapshot.hasError) {
                  //print(snapshot.error);
                  return propertyTypeWidgets();
                  return Center(
                    child: Text('Erreur occured: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {

                  // if(firstDrawerDisplay) {
                  //typeSelectionne=listOfProperty.elementAt(listOfPropertyId.indexOf(propertyId)); //+1 parce qu'il ya choisir le type en 1er. on pourra bien l'enlever après
                  // }
                  return
                    StatefulBuilder(builder: (context, funct) {
                      return DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        //items: listOfCity.cast(),
                        iconSize: 5,
                        elevation: 5,
                        alignment: Alignment.center,
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16
                        ),
                        value: typeSelectionne,
                        underline: Container(
                          height: 2,
                          color: AppColors.mainColor,
                        ),
                        onChanged: (String? newValue) {
                          propertyId =
                          listOfPropertyId[listOfProperty.indexOf(newValue!)];


                          funct(() =>
                          {
                            typeSelectionne = newValue
                          });


                          //quartierSelectionne=newValue;

                        },
                        items: listOfProperty.map<DropdownMenuItem<String>>((
                            String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),

                      );
                    });
                } else {
                  return
                    const Center(child: Text('No data'));
                }
            }
          }
      );
    }

    Future retreiveDropdownCitiesInfo() async {
      if (listOfCityName.length == 1) {

        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        String fullUrl = '${baseUrl}v1/city-name/$countryId';
        
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);


        var data = jsonDecode(response2.body.toString());

        // print('${data['id']}');



        List<String> retreiverListOfCityName = ['Choisir la ville'];
        List<int> retreiverListOfCityId = [];
        for (var element in (data as List)) {
          retreiverListOfCityName.add(element['intitule']);
          retreiverListOfCityId.add(element['id']);
        }

        //setState(() {
        listOfCityName = retreiverListOfCityName;
        listOfCityId = retreiverListOfCityId;
        //});

        //majListQuartier(retreiverListOfCityName);

        return data;
      } else {
        return listOfCityName;
      }
    }

    Widget villeAndQuartierWidgets() {


      return StatefulBuilder(builder: (context, funct) {
        void majListQuartier(List<String> list) {
          funct(() {
            listOfQuartierName = list;
          });
        }


        Widget futureListVille() {
          return FutureBuilder(

              future: retreiveDropdownCitiesInfo(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        DropdownButton<String>(
                            icon: const Icon(Icons.arrow_downward),
                            hint: const Text("Chargement..."),
                            items: const [],
                            iconSize: 5,
                            elevation: 5,
                            onChanged: (String? newValue) {

                            }
                        ),

                        const SizedBox(width:25, height:25,child: CircularProgressIndicator(color: Colors.indigo)),
                      ],
                    );
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      //print(snapshot.error);

                      return futureListVille();
                      return Center(
                        child: Text('Erreur occured: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {

                      /*if(firstDrawerDisplay) {
                      villeSelectionee=listOfCityName.elementAt(listOfCityId.indexOf(cityId)+1);
                    }*/
                      return
                        StatefulBuilder(builder: (context, funct) {

                          return DropdownButton<String>(
                            icon: const Icon(Icons.arrow_downward),
                            hint: const Text("Choisir la ville"),
                            iconSize: 5,
                            elevation: 5,
                            alignment: Alignment.center,
                            value: villeSelectionnee,
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16
                            ),
                            underline: Container(
                              height: 2,
                              color: AppColors.mainColor,
                            ),

                            onChanged: (String? newValue) {
                              cityId =
                              listOfCityId[listOfCityName.indexOf(newValue!) -
                                  1]; //-1 parce que listOfCityName commence avant listOfCityId

                              //chargerLesQuartiers=true;
                              retreiveDropdownQuartierInfo().then((value) {
                                majListQuartier(retreiverListOfQuartierName);
                                //listOfQuartierName=retreiverListOfQuartierName;
                                // chargerLesQuartiers=false;
                              });



                              villeSelectionnee = newValue;
                              quartierSelectionne = 'Choisir le quartier';
                              //});

                              // villeSelectionee=newValue;
                            },

                            items: listOfCityName.map<DropdownMenuItem<String>>((
                                String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),



                          );
                        }
                        );
                    } else {
                      return
                        const Center(child: Text('No data'));
                    }
                }
              }
          );
        }

        Widget futureListQuartier() {
          return FutureBuilder(

              future: retreiveDropdownQuartierInfo(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        DropdownButton<String>(
                            icon: const Icon(Icons.arrow_downward),
                            items: const [],
                            hint: const Text('Chargement...'),
                            iconSize: 5,
                            elevation: 5,
                            onChanged: (String? newValue) {

                            }
                        ),

                        const SizedBox(width:25, height:25,child: CircularProgressIndicator(color: Colors.indigo)),
                      ],
                    );
                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      // print(snapshot.error);

                      return Center(
                        child: Text('Erreur: ${snapshot.error}'),
                      );
                    } else if (snapshot.hasData) {




                      return  StatefulBuilder(builder: (context, funct) {
                        return DropdownButton<String>(
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 5,
                          elevation: 5,
                          alignment: Alignment.center,
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16
                          ),
                          value: quartierSelectionne,
                          underline: Container(
                            height: 2,
                            color: AppColors.mainColor,
                          ),
                          onChanged: (String? newValue) {

                            if(newValue!.compareTo('Choisir le quartier')!=0) {
                              quartierId =listOfQuartierId[listOfQuartierName.indexOf(newValue) - 1];
                            }

                            funct(() =>
                            {
                              quartierSelectionne = newValue
                            });


                          },
                          items: listOfQuartierName.map<
                              DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Align(alignment: Alignment.center, child: Text(value)),

                              //Text(value,textAlign: TextAlign.center,),
                            );
                          }).toList(),

                        );
                      });
                    } else {
                      return
                        const Center(child: Text('No data'));
                    }
                }
              }
          );
        }
        return Column(children: [
          futureListVille(),
          const SizedBox(height: 5,),
          futureListQuartier()
        ],);
      });
    }

    Future retreiveConveniences() async {
//await Future.delayed(Duration(seconds: 30));
// print('retreiveReleaseGood $token');


      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };


      String fullUrl = '${baseUrl}v1/convenience-types';

     // print(fullUrl);
      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.get(uri, headers: headers);
      final List data = jsonDecode(response2.body.toString())['data'];


      listOfConvenience= data.map((e) => Conveniences.fromJson(e)).toList();
      nbConvList.clear();
      for (var element in listOfConvenience) {
        // listOfConvenienceIds.add(element.id);
        nbConvList.add(0);
      }

      listOfConvenience.sort((a, b) => a.intitule.compareTo(b.intitule)); // ordre alphabétique

      // if(releaseGood.releasegoodconvenience!.isNotEmpty) {
      checkedConvIds.clear();
        for (var element in releaseGood.releasegoodconvenience!) {
          checkedConvIds.add(int.parse(element.conveniencetype!.id.toString()));
          nbConvList[listOfConvenience.indexWhere((convenience) =>
          convenience.intitule == element.conveniencetype?.intitule)] = int.parse(element.number.toString()); // on récupère déja les numbers avec lesquels les convenineces sont arrivés donc on prend les number où les convenience.intitule correspondent au rgc.conveniencetype.intitule
        }
      //}
      listOfCardItemPlusOrMinus=generateListOfConveniencePlusOrMinus(listOfConvenience);
      listOfCardItemPlusOrMinus.addAll(generateListOfConvenienceCheckBox(listOfConvenience));
      return listOfConvenience;
    }




 Widget generateListOfConveniencesCard(){

   return FutureBuilder(
       future:  retreiveConveniences(),
       builder: (context,snapshot){
         switch (snapshot.connectionState){
           case ConnectionState.waiting:
             return const Center(
               child: CircularProgressIndicator(color: Colors.blue),
             );
           case ConnectionState.done:
           default:
           if (snapshot.hasError) {

             return Center(
               child: Text('Erreur: ${snapshot.error}'),
             );

            // return generateListOfConveniencesCard();
           }else if (snapshot.hasData){
             return  Container(
               height: 300,
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(45),
                   border: Border.all(color: AppColors.mainColor,
                       width: 2,
                       style: BorderStyle.solid)
               ),
               child: Scrollbar(
                 thumbVisibility: true, //always show scrollbar
                 thickness: 7, //width of scrollbar
                 radius: const Radius.circular(20), //corner radius of scrollbar
                 scrollbarOrientation: ScrollbarOrientation.right,
                 controller: scrollController,

                 child: SingleChildScrollView(
                     controller: scrollController,
                     child: Column(
                       children:  listOfCardItemPlusOrMinus,
                     )
                 ),
               ),
             );
           }else {
             return const Center(child: Text('No data'));
           }
         }
       }

   );
 }

  void _showSimpleDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const SimpleDialog(
            title: Text(''),
            children: [
              Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator())),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body:  FutureBuilder(
          future: initializing(),
          builder: (context , snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(

                child: Image.asset(
                  'assets/images/logomdpi.png',
                ),


              );
            }else{
              return  Form(
                  key: _formKey,

                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: SingleChildScrollView(

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          villeAndQuartierWidgets(),
                          const SizedBox(height: 10,),
                          propertyTypeWidgets(),

                          const SizedBox(height: 30.0,),

                          StatefulBuilder(builder: (context, funct) {
                            return
                              Container(

                                height: 45,
                                // width: 150,
                                margin: const EdgeInsets.only(left: 20, right: 20),

                                // padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: AppColors.mainColor
                                ),

                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppColors.mainColor,
                                    // foreground
                                    elevation: 10,
                                    shape: BeveledRectangleBorder(),
                                    alignment: Alignment.centerRight,


                                  ),

                                  onPressed: () {
                                    showDatePicker(context: context,
                                      initialDate:dateTimeChoosen,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2025),
                                      locale: Locale("fr")
                                    ).then((value) {
                                      dateTimeChoosen = value!;
                                      funct(() =>
                                      {
                                        //dateDeLiberation = DateFormat.yMd().format(value!)
                                        dateDeLiberation = formatDatePresentation(value!.toString())
                                      });
                                    });
                                  },
                                  //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.date_range_rounded),
                                      const SizedBox(width: 15,),
                                      Text('Libération prévue le: $dateDeLiberation'),
                                    ],

                                    //majDate(date)
                                  ),
                                ),

                              );
                          }),


                          const SizedBox(height: 25.0,),

                          generateListOfConveniencesCard(),


                          const SizedBox(height: 40.0,),

                          TextFormField(
                            controller: _prixController..text=prix,
                            decoration: const InputDecoration(
                              labelText: "Prix",
                              labelStyle: TextStyle(fontSize: 20,
                                  color: Colors.black54),

                              border: OutlineInputBorder(),

                            ),

                            keyboardType: TextInputType.number,
                            maxLength: 7,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },

                          ),

                          const SizedBox(height: 20.0,),

                          TextFormField(
                            controller: _localisationController..text=localisation!,
                            decoration: const InputDecoration(
                              labelText: "Localisation. Ex: à proximité de, à 100m de",
                              labelStyle: TextStyle(fontSize: 20,
                                  color: Colors.black54),
                              border: OutlineInputBorder(),

                            ),
                            keyboardType: TextInputType.multiline,
                            maxLength: 150,
                            maxLines: 5,

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Décrivez la localisation';
                              }
                              return null;
                            },

                          ),

                          const SizedBox(height: 20.0,),
                          TextFormField(
                            controller: _commentaireController..text=commentaire!,
                            decoration: const InputDecoration(
                              labelText: "Commentaires",
                              labelStyle: TextStyle(fontSize: 20,
                                  color: Colors.black54),
                              border: OutlineInputBorder(),

                            ),
                            keyboardType: TextInputType.multiline,
                            maxLength: 150,
                            maxLines: 5,

                          ),

                          const SizedBox(height: 20.0,),

                          Container(
                            decoration: BoxDecoration(
                                border: Border(left: BorderSide(
                                    width: 5, color: AppColors.mainColor))
                            ),


                            child: Column(
                              children: [
                                TextFormField(

                                  decoration: const InputDecoration(
                                    labelText: "Contact du bailleur",
                                    //errorText: "Renseignez le contact",
                                    labelStyle: TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                    border: OutlineInputBorder(),

                                  ),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Renseignez le contact';
                                    }
                                    return null;
                                  },
                                  controller: _contactController..text=contact!,


                                ),

                                const SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: _conditionController..text=conditions!,
                                  decoration: const InputDecoration(
                                    labelText: "Conditions du bailleur",
                                    // errorText: "Renseignez les conditions du bailleur",
                                    labelStyle: TextStyle(
                                        fontSize: 20, color: Colors.black54),
                                    border: OutlineInputBorder(),

                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLength: 150,
                                  maxLines: 5,

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Renseignez les conditions du bailleur';
                                    }
                                    return null;
                                  },

                                ),

                                const SizedBox(height: 20.0,),


                                Container(

                                    width: 215,


                                    child: StatefulBuilder(
                                        builder: (context, funct) {
                                          return CheckboxListTile(
                                              value: _accord,
                                              activeColor: Colors.pink,
                                              title: MediumText(
                                                text: 'J\'ai l\'accord du bailleur',
                                                color: Colors.pink,),

                                              onChanged: (v) {
                                                funct(() {
                                                  _accord = v!;
                                                });
                                              });
                                        })
                                ),


                              ],
                            ),
                          ),


                          const SizedBox(height: 15.0,),

                          ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: AppColors.mainColor, // foreground
                                elevation: 10,
                                shape: const StadiumBorder()
                            ),

                            onPressed: validateButtonEnabled?() {
                              _formKey.currentState!.validate();

                              if(villeSelectionnee.compareTo('Choisir la ville')==0 || quartierSelectionne.compareTo('Choisir le quartier')==0){
                                Fluttertoast.showToast(
                                    msg: "Définissez la localité",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 20,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else if(typeSelectionne.compareTo('Choisir le type')==0 ){
                                Fluttertoast.showToast(
                                    msg: "Définissez le type de bien",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 20,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                              else if(dateTimeChoosen.year==1900){
                                Fluttertoast.showToast(
                                    msg: "Définissez la date de libération ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 20,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }else if (!_accord) {
                                Fluttertoast.showToast(
                                    msg: "L'accord du bailleur est requis",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 20,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else {


                                prix = _prixController.text;
                                localisation = _localisationController.text;
                                commentaire = _commentaireController.text;
                                contact = _contactController.text;
                                conditions = _conditionController.text;
                                //print('nbConvList:${nbConvList.length}');

                               // print('newConvIDs: ${listOfConvenience.length}');
                                recupConvIdsDeleted();
                                recupConvIdsUpdated();

                                //String convIDs = recupConvIdsAndCount();


                               /*  print('checkedConvIds:$checkedConvIds');


                                print('updatedConvIds:$updatedConvIds');
                                print('nbConvUpdated:$nbConvUpdated');


                                print('deletedConvIds:$deletedConvIds');
*/
                                newConvIDs=recupConvIdsAndCount();
                               /* print(newConvIDs);
                                print(newConvNb);*/
                                if(newConvIDs.isEmpty && updatedConvIds.isEmpty){ // si aucune convenience n'est sélectionné
                                  Fluttertoast.showToast(
                                      msg: "Veuillez renseigner les commodités",

                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 20,
                                      backgroundColor: Colors.blue,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }else {

                                    validateButtonEnabled=false;



                                  _showSimpleDialog();
                                  update().then((value) async {

                                    if (value.statusCode == 200) {
                                      releaseGoodPubOk = true;
                                      if (updatedConvIds.isNotEmpty) {
                                        for (var id in updatedConvIds) {
                                          await updateReleaseGoodConvenience(id)
                                              .then((value) =>
                                          {
                                            if(value.statusCode != 200) {
                                              otherPubOk = false,

                                            }
                                          });
                                        }
                                      }

                                      if (deletedConvIds.isNotEmpty) {
                                        for (var id in deletedConvIds) {
                                          await deleteReleaseGoodConvenience(
                                              id);
                                        }
                                      }


                                      if (otherPubOk) {
                                        Fluttertoast.showToast(
                                            msg: "Enregistré avec succès",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 20,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "L'enregistrement de certaines informations a échoué. Vérifiez",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 20,
                                            backgroundColor: Colors.red[50],
                                            textColor: Colors.white,
                                            fontSize: 16.0
                                        );
                                      }
                                    } else {
                                      releaseGoodPubOk = false;
                                      Fluttertoast.showToast(
                                          msg: "Echec d'enregistrement. Réessayer",
                                          //msg: value.reasonPhrase+value.statusCode.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );

                                     /* setState(() {

                                        validerCircularVisible = false;
                                      });*/
                                    }
                                  }).whenComplete(() =>
                                  {
                                  _dismissDialog(),
                                  validateButtonEnabled = true,
                                    if(releaseGoodPubOk){
                                      Get.offAllNamed(
                                          RouteName.mesPubs,

                                      )
                                      //context.go("/home/mesPubs")

                                    }
                                  });
                                }
                              }
                            }:null,
                            child: SizedBox(
                              width: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Publier'),

                                  SizedBox(height:15, width:15, child: Visibility(visible:validerCircularVisible,child: CircularProgressIndicator(color: Colors.blue,)))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                    ),
                  )
              );
            }
          },

      ),

      /*body: Container(
        color: AppColors.mainColor2,
        padding: const EdgeInsets.only(
            top: 20, left: 15, right: 15),
        child: Column(
          children: [
            Container(
              height: 735,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: Colors.white,
              ),
              child: SingleChildScrollView(

                child: Form(
                  key: _formKey,
                  child: Column(

                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                 villeAndQuartierWidgets(),
                      const SizedBox(height: 10,),

                      propertyTypeWidgets(),

                      const SizedBox(height: 30.0,),
                      StatefulBuilder(builder: (context, funct) {
                        return ListTile(

                          title: MediumText(text: "Chambre",),
                          //title: MediumText(text: widget.title),
                          trailing: SizedBox(
                            width: 200,
                            child: Wrap(alignment: WrapAlignment.start,

                              children: [
                                Row(
                                  children: <Widget>[
                                    IconButton(onPressed: () {
                                      if (nbChambre > 0) {
                                        funct(() {
                                          nbChambre--;
                                        });
                                      }
                                    }, icon: const Icon(Icons.remove)),
                                    MediumText(text: "$nbChambre"),
                                    IconButton(onPressed: () {
                                      funct(() {
                                        nbChambre++;
                                      });
                                    }, icon: const Icon(Icons.add)),


                                  ],
                                )
                              ],),
                          ),
                        );
                      }),

                      const SizedBox(height: 30.0,),

                  StatefulBuilder(builder: (context, funct) {
                    return
                      Container(

                        height: 45,
                       // width: 150,
                        margin: const EdgeInsets.only(left: 20, right: 20),

                        // padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: AppColors.mainColor
                        ),

                        child: ElevatedButton(

                          style: ElevatedButton.styleFrom(
                            primary: AppColors.mainColor,
                            // background
                            onPrimary: Colors.white,
                            // foreground
                            elevation: 10,
                            shape: BeveledRectangleBorder(),
                            alignment: Alignment.centerRight,


                          ),

                          onPressed: () {
                            showDatePicker(context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            ).then((value) {
                              dateTimeChoosen = value!;
                              funct(() =>
                              {
                                //dateDeLiberation = DateFormat.yMd().format(value!)
                                dateDeLiberation = formatDatePresentation(value!.toString())
                              });
                            });
                          },
                          //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
                          child: Row(
                            children: [
                              Icon(Icons.date_range_rounded),
                              SizedBox(width: 15,),
                              Text('Libération prévue le: $dateDeLiberation'),
                            ],

                            //majDate(date)
                          ),
                        ),
                        //child: SmallText(text: 'Se Connecter'),
                        // child:TextButton(onPressed: (){}, child: SmallText(text: 'Connexion'),),
                      );
                  }),


                      SizedBox(height: 25.0,),

                     generateListOfConveniencesCard(),


                      SizedBox(height: 40.0,),

                      TextFormField(
                        controller: _prixController..text=prix,
                        decoration: const InputDecoration(
                          labelText: "Prix",
                          labelStyle: TextStyle(fontSize: 20,
                              color: Colors.black54),
                          // errorText: "Renseignez le prix",
                          border: OutlineInputBorder(),

                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                        // initialValue: '25000',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 20.0,),
                      TextFormField(
                        controller: _localisationController..text=localisation!,
                        decoration: const InputDecoration(
                          labelText: "Localisation. Ex: à proximité de, à 100m de",
                          labelStyle: TextStyle(fontSize: 20,
                              color: Colors.black54),
                          border: OutlineInputBorder(),

                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: 150,
                        maxLines: 5,

                      ),

                      SizedBox(height: 20.0,),
                      TextFormField(
                        controller: _commentaireController..text=commentaire!,
                        decoration: const InputDecoration(
                          labelText: "Commentaires",
                          labelStyle: TextStyle(fontSize: 20,
                              color: Colors.black54),
                          border: OutlineInputBorder(),

                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: 150,
                        maxLines: 5,

                      ),

                      SizedBox(height: 20.0,),

                      Container(
                        decoration: BoxDecoration(
                            border: Border(left: BorderSide(
                                width: 5, color: AppColors.mainColor))
                        ),


                        child: Column(
                          children: [
                            TextFormField(

                              decoration: const InputDecoration(
                                labelText: "Contact du bailleur",
                                //errorText: "Renseignez le contact",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                border: OutlineInputBorder(),

                              ),
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Renseignez le contact';
                                }
                                return null;
                              },
                              controller: _contactController..text=contact!,


                            ),

                            SizedBox(height: 20.0,),
                            TextFormField(
                              controller: _conditionController..text=conditions!,
                              decoration: const InputDecoration(
                                labelText: "Conditions du bailleur",
                                // errorText: "Renseignez les conditions du bailleur",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.black54),
                                border: OutlineInputBorder(),

                              ),
                              keyboardType: TextInputType.multiline,
                              maxLength: 150,
                              maxLines: 5,

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Renseignez les conditions du bailleur';
                                }
                                return null;
                              },

                            ),

                            SizedBox(height: 20.0,),


                            Container(

                                width: 215,


                                child: StatefulBuilder(
                                    builder: (context, funct) {
                                      return CheckboxListTile(
                                          value: _accord,
                                          activeColor: Colors.pink,
                                          title: MediumText(
                                            text: 'J\'ai l\'accord du bailleur',
                                            color: Colors.pink,),

                                          onChanged: (v) {
                                            funct(() {
                                              _accord = v!;
                                            });
                                          });
                                    })
                            ),


                          ],
                        ),
                      ),


                        SizedBox(height: 15.0,),




                      *//*


                      StreamBuilder<Widget>(
                          stream: null,
                          builder: (context, snapshot) {
                            return futureListPropertyType();
                          }
                      ),

                      SizedBox(height: 30.0,),


                      StreamBuilder<Widget>(
                          stream: null,
                          builder: (context, snapshot) {
                            return datePicker();
                          }
                      ),


                      SizedBox(height: 25.0,),


                      StreamBuilder<Widget>(
                          stream: null,
                          builder: (context, snapshot) {
                            return chambreTile();
                          }
                      ),

                     *//*

                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 15.0,),
            Container(
              height: 45,
              width: 300,
              margin: const EdgeInsets.only(left: 20, right: 20),
              // padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: AppColors.mainColor
              ),

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                    primary: AppColors.mainColor, // background
                    onPrimary: Colors.white, // foreground
                    elevation: 10,
                    shape: StadiumBorder()
                ),

                onPressed: () {
                  _formKey.currentState!.validate();
                  if (!_accord) {
                    Fluttertoast.showToast(
                        msg: "L'accord du bailleur est requis",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 20,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  } else {
                    //prix = int.parse(_prixController.text);
                    prix = _prixController.text;
                    localisation = _localisationController.text;
                    commentaire = _commentaireController.text;
                    contact = _contactController.text;
                    conditions = _conditionController.text;


                    enregistrer().then((value) {
                     *//* if (value.statusCode == 201) {
                        Fluttertoast.showToast(
                            msg: "Publié avec succès",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 20,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                        context.go('/mainPage');
                      } else {
                        Fluttertoast.showToast(
                            msg: "Echec de publication.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 20,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }*//*


                    });
                  }
                },
                child: Text('Valider'),
              ),
            ),

          ],
        ),
      ),*/
    );
  }

    @override
  void initState() {
    super.initState();
    validateButtonEnabled=true; validerCircularVisible=false;
  }
}



const baseUrl = apiUrl;

List<String> listOfCityName = ['Choisir la ville'];
List<int> listOfCityId = <int>[];

List<String> retreiverListOfQuartierName = [];
List<int> retreiverListOfQuartierId = [];

List<String> listOfQuartierName = ['Choisir le quartier'];
List<int> listOfQuartierId = <int>[];

List<String> listOfProperty = ['Choisir le type'];
List<int> listOfPropertyId = <int>[];



var cityId = 1,
    countryId = 1,
    quartierId = 0,
    propertyId = 0;


late ReleaseGoodModel3 releaseGood;

TextEditingController _prixController = TextEditingController();
TextEditingController _contactController = TextEditingController();
TextEditingController _conditionController = TextEditingController();
TextEditingController _localisationController = TextEditingController();
TextEditingController _commentaireController = TextEditingController();
//TextEditingController _chambreController=TextEditingController();

String prixErreurMsg = "",
    contactErreurMsg = "";
var _formKey = GlobalKey<FormState>();


List<Map> convMap=[];

List<Widget> listOfCardItemPlusOrMinus=[];

List<Widget> listOfCardItemCheckBox=[];

List<Array> convArray=[];

bool _checkValue=false;

late DateTime dateTimeChoosen;

bool _accord=true;




List<Conveniences> listOfConvenience=[];


List<int> nbConvList=[];
List<int> nbConvUpdated=[];
List<int> nbConvDeleted=[];

List<int> updatedConvIds=[];
List<int> deletedConvIds=[];
List<int> checkedConvIds=[];
List<int> rgcIds=[];

int nbChambre=0,nbConvPlusOrMinus=0;

bool otherPubOk=true, releaseGoodPubOk=true;

/*String villeSelectionnee = 'Choisir la ville',
    quartierSelectionne = 'Choisir le quartier',
    typeSelectionne = 'Choisir le type';*/

late String villeSelectionnee, quartierSelectionne , typeSelectionne ;

String? localisation, dateDeLiberation;
late String prix;
String? commentaire='',contact='',conditions='';

String newConvNb="";

ScrollController scrollController=ScrollController();

bool validateButtonEnabled=true, validerCircularVisible=false;

String newConvIDs="";