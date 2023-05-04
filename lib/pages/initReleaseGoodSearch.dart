import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/PropertyTypeModel.dart';
import '../utils/colors.dart';
import '../widgets/mediumText.dart';

class InitReleaseGoodSearch extends StatefulWidget {
  const InitReleaseGoodSearch({Key? key}) : super(key: key);

  @override
  State<InitReleaseGoodSearch> createState() => _InitReleaseGoodSearchState();
}

class _InitReleaseGoodSearchState extends State<InitReleaseGoodSearch> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget dialogInitialization() {
    return AlertDialog(
      backgroundColor: Colors.orange.withOpacity(0.2),
      elevation: 0,
      shadowColor: AppColors.mainColor,
      surfaceTintColor: AppColors.mainColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: MediumText(
        text: 'Faites vos Choix',
        color: AppColors.mainColor,
      ),
      content: SizedBox(
        //padding: const EdgeInsets.all(10),
        height: 300,
        child: Column(
          children: [
            villeAndQuartierWidgets(),
            futureListPropertyType(),
            const SizedBox(
              height: 50,
            ),
            TextButton(onPressed: () {
              if (villeSelectionee.compareTo('Choisir la ville') == 0) {
                Fluttertoast.showToast(
                    msg: "Définissez la localité",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 20,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else if (typeSelectionne.compareTo('Choisir le type') ==
                  0) {
                Fluttertoast.showToast(
                    msg: "Définissez le type de bien",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 20,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                setState(() {
                  isLoading = true;
                });
                Get.offAllNamed(RouteName.searchReleaseGood, arguments: {
                  "cityId": cityId,
                  "quartierId": quartierId,
                  "propertyId": propertyId,
                  "villeSelectionnee": villeSelectionee,
                  "quartierSelectionne": quartierSelectionne,
                  "typeSelectionne": typeSelectionne
                });
              }
            },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: isLoading == false ?  Text('Rechercher',
                  selectionColor: AppColors.mainColor2,
                  style:const TextStyle(color: Colors.white,)): const CircularProgressIndicator(),)
          ],
        ),
      ),
    );
  }

  Future retreiveDropdownQuartierInfo() async {
    if (chargerLesQuartiers) {
      //juste pour empêcher d'executer la requête serveur tant qu'une ville n'est pas sélectionnée

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

      retreiverListOfQuartierName = ['Tous les quartiers'];
      retreiverListOfQuartierId = [];
      for (var element in (data as List)) {
        retreiverListOfQuartierName.add(element['intitule']);
        retreiverListOfQuartierId.add(element['id']);
      }

      listOfQuartierId = retreiverListOfQuartierId;
      //majListQuartier(retreiverListOfQuartierName);
      return data;
    } else {
      return listOfQuartierName;
    }
  }

  void majListQuartier(List<String> list) {
    listOfQuartierName = list;
  }

  Widget villeAndQuartierWidgets() {
    return StatefulBuilder(builder: (context, funct) {
      void majListQuartier(List<String> list) {
        funct(() {
          listOfQuartierName = list;
        });
      }

      Widget futureListVille() {
        Future retreiveDropdownCitiesInfo(int id) async {
          if (listOfCityName.length == 1) {
            Map<String, String> headers = {
              "Content-Type": "application/json",
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            };

            String fullUrl = '${baseUrl}v1/city-name/$id';

            //  print(fullUrl);
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

        return FutureBuilder(
            future: retreiveDropdownCitiesInfo(1),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                          dropdownColor: Colors.orange.shade50,
                          icon: const Icon(Icons.arrow_downward),
                          hint: const Text("Chargement..."),
                          items: const [],
                          iconSize: 5,
                          elevation: 5,
                          onChanged: (String? newValue) {}),
                      const SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              CircularProgressIndicator(color: Colors.indigo)),
                    ],
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasError) {
                    //  print(snapshot.error);
                    return Center(
                      child: Text('Erreur: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return StatefulBuilder(builder: (context, funct) {
                      return DropdownButton<String>(
                        dropdownColor: Colors.orange.shade50,
                        icon: const Icon(Icons.arrow_downward),
                        hint: const Text("Choisir la ville"),
                        iconSize: 5,
                        elevation: 5,
                        alignment: Alignment.center,
                        value: villeSelectionee,
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 16),
                        underline: Container(
                          height: 2,
                          color: AppColors.mainColor,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue!.compareTo('Choisir la ville') != 0) {
                            cityId = listOfCityId[listOfCityName
                                    .indexOf(newValue) -
                                1]; //-1 parce que listOfCityName commence avant listOfCityId
                          }
                          chargerLesQuartiers = true;
                          retreiveDropdownQuartierInfo().then((value) {
                            majListQuartier(retreiverListOfQuartierName);
                            //listOfQuartierName=retreiverListOfQuartierName;
                            chargerLesQuartiers = false;
                          });

                          villeSelectionee = newValue;
                          quartierSelectionne = 'Tous les quartiers';
                          //});

                          // villeSelectionee=newValue;
                        },
                        items: listOfCityName
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                      );
                    });
                  } else {
                    return const Center(child: Text('No data'));
                  }
              }
            });
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
                          dropdownColor: Colors.orange.shade50,
                          icon: const Icon(Icons.arrow_downward),
                          hint: const Text("Chargement..."),
                          items: const [],
                          iconSize: 5,
                          elevation: 5,
                          onChanged: (String? newValue) {}),
                      const SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              CircularProgressIndicator(color: Colors.indigo)),
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
                    return StatefulBuilder(builder: (context, funct) {
                      return DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        dropdownColor: Colors.orange.shade50,
                        //items: listOfCity.cast(),
                        iconSize: 5,
                        elevation: 5,
                        alignment: Alignment.center,
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 16),
                        value: quartierSelectionne,
                        underline: Container(
                          height: 2,
                          color: AppColors.mainColor,
                        ),
                        onChanged: (String? newValue) {
                          if (newValue!.compareTo('Tous les quartiers') != 0) {
                            quartierId = listOfQuartierId[
                                listOfQuartierName.indexOf(newValue) - 1];
                          }
                          /* quartierId =
                            listOfQuartierId[listOfQuartierName.indexOf(
                                newValue!) - 1];*/

                          funct(() => {quartierSelectionne = newValue});

                          //quartierSelectionne=newValue;
                        },
                        items: listOfQuartierName
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                      );
                    });
                  } else {
                    return const Center(child: Text('No data'));
                  }
              }
            });
      }

      return Column(
        children: [
          futureListVille(),
          const SizedBox(
            height: 15,
          ),
          futureListQuartier()
        ],
      );
    });
  }

  Widget futureListPropertyType() {
    Future retreiveDropdownInfo() async {
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

    return FutureBuilder(
        future: retreiveDropdownInfo(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                      icon: const Icon(Icons.arrow_downward),
                      hint: const Text("Chargement..."),
                      dropdownColor: Colors.orange.shade50,
                      items: const [],
                      iconSize: 5,
                      elevation: 5,
                      onChanged: (String? newValue) {}),
                  const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(color: Colors.indigo)),
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
                return StatefulBuilder(builder: (context, funct) {
                  return DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward),
                    //items: listOfCity.cast(),
                    dropdownColor: Colors.orange.shade50,
                    iconSize: 5,
                    elevation: 5,
                    alignment: Alignment.center,
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 16),
                    value: typeSelectionne,
                    underline: Container(
                      height: 2,
                      color: AppColors.mainColor,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue!.compareTo('Choisir le type') != 0) {
                        propertyId = listOfPropertyId[
                            listOfProperty.indexOf(newValue) - 1];
                      }
                      funct(() => {typeSelectionne = newValue});

                      //quartierSelectionne=newValue;
                    },
                    items: listOfProperty
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                  );
                });
              } else {
                return const Center(child: Text('No data'));
              }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Title(
          color: Colors.white,
          child: const Text('Rechercher'),
        ),
        elevation: 15,
        leading: Container(
            padding: const EdgeInsets.all(3),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icon/android/choix.png',
                color: Colors.white,
              ),
            )),
      ),
      body: Center(
        child: dialogInitialization(),
      ),

      /* final prefs =  await SharedPreferences.getInstance();
        await prefs.setString('token', token as String);

        var fullUrl='${Values.apiUrl}v1/release-goods';

        String goods=FutureBuilder<String>(
            future: retreiveReleaseGood(fullUrl,token as String),
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Text('Waiting');
                case ConnectionState.done:
                default:
                  if(snapshot.hasError) {
                    return Text('Erreur occured: ${snapshot.error}');
                  }else if(snapshot.hasData) {
                    return Text('${snapshot.data}');
                  }else {
                    return const Text('No data');
                  }
              }
            }
        ) as String;


        Fluttertoast.showToast(
            msg: goods,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );*/
    );
  }
}

var scaffoldKey = GlobalKey<ScaffoldState>();
late Widget convenienceWidget;
var fullUrl = '${apiUrl}v1/release-goods';
//Map<String, dynamic> goods;

const baseUrl = apiUrl;

List<String> listOfCityName = ['Choisir la ville'];
List<int> listOfCityId = <int>[];

List<String> retreiverListOfQuartierName = [];
List<int> retreiverListOfQuartierId = [];

List<String> listOfQuartierName = ['Tous les quartiers'];
List<int> listOfQuartierId = <int>[];

List<String> listOfProperty = ['Choisir le type'];
List<int> listOfPropertyId = <int>[];

String villeSelectionee = 'Choisir la ville',
    quartierSelectionne = 'Tous les quartiers',
    typeSelectionne = 'Choisir le type';

var cityId = 3, countryId = 1, quartierId = 0, propertyId = 0;

int nbChambre = 0;
double prix = 25000;

num? nbOfResult = 0;

List<Map> convMap = [];

List<Widget> listOfCardItemPlusOrMinus = [];

List<Widget> listOfCardItemCheckBox = [];

List<Array> convArray = [];

bool _checkValue = false;

late DateTime dateTimeChoosen;

bool _accord = false;

String periodeDeLiberation = '';

// List<DataConveniences> listOfConvenience = [];

List<int> listOfConvenienceIds = <int>[];

List<int> listOfChoosenConvenienceIds = <int>[];
List<int> listOfChoosenConvenienceNbs = <int>[];

List<int> nbConvList = [];

int nbConvPlusOrMinus = 0;

String localisation = '', commentaire = '', contact = '', conditions = '';

String convNb = "";

bool chargerLesQuartiers = false;

final periodes = ["Ce mois", "Le mois prochain", "Autre"];
String valeurPeriode = "Ce mois";
