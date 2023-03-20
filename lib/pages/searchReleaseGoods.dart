import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/Conveniences.dart';
import '../models/PropertyTypeModel.dart';
import '../models/ReleaseGoodModel3.dart';
import '../utils/colors.dart';
import '../widgets/cardItemCheckbox.dart';
import '../widgets/cardItemPlusOuMoins2.dart';
import '../widgets/displayReleaseGoodWidget.dart';
import '../widgets/titleSmallText.dart';

class SearchReleaseGoods extends StatefulWidget {
  const SearchReleaseGoods({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchReleaseGoods> createState() => _SearchReleaseGoodsState();
}

class _SearchReleaseGoodsState extends State<SearchReleaseGoods> {
  dynamic cityId = Get.arguments["cityId"];
  dynamic quartierId = Get.arguments["quartierId"];
  dynamic propertyId = Get.arguments["propertyId"];
  dynamic villeSelectionee = Get.arguments["villeSelectionnee"];
  dynamic quartierSelectionne = Get.arguments["quartierSelectionne"];
  dynamic typeSelectionne = Get.arguments["typeSelectionne"];

  @override
  void initState() {
    super.initState();
    convenienceWidget = generateScrollableConveniencesCard();
    chargerLesQuartiers = true;
    retreiveDropdownQuartierInfo().then((value) {
      majListQuartier(retreiverListOfQuartierName);
      chargerLesQuartiers = false;
      if (quartierId != 0) {
        quartierSelectionne = listOfQuartierName
            .elementAt(listOfQuartierId.indexOf(quartierId) + 1);
      }
    });

    WidgetsBinding.instance
        .addPostFrameCallback((_) async => {token, user['id']});
  }

/* void initialiseDrawer(){


   retreiveDropdownCitiesInfo(countryId).then((value) {
     villeSelectionee=listOfCityName.elementAt(listOfCityId.indexOf(cityId)+1); //+1 parce qu'il ya choisir la ville en 1er. on pourra bien l'enlever après car il faut toujours un choix de ville
   });


   retreiveDropdownInfoPropertyType().then((value) {

     typeSelectionne=listOfProperty.elementAt(listOfPropertyId.indexOf(propertyId)); //+1 parce qu'il ya choisir le type en 1er. on pourra bien l'enlever après
   });
 }*/

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

  Widget releaseGoodWidget() {
    Future retreiveReleaseGood(String fullUrl) async {
      if (initialize) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        http.Response response2 = await http.get(
          Uri.parse(fullUrl),
          headers: headers,
        );

        //  print(fullUrl);

        if (response2.statusCode == 200) {
          final List result = jsonDecode(response2.body)['data'];
          listOfReleaseGoodsInitial =
              result.map((e) => ReleaseGoodModel3.fromJson(e)).toList();
          initialize = false;
        } else {
          //return retreiveReleaseGood(fullUrl, token);
          //throw Exception(response2.reasonPhrase);
        }

        listOfReleaseGoodsToDisplay = triGeneral();

        setState(() {
          nbOfResult = listOfReleaseGoodsToDisplay.length;
        });
        return response2;
      } else {
        return 'ok';
      }
    }

    return FutureBuilder(
        future: retreiveReleaseGood(fullUrl),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                // print(snapshot.error);
                return Center(
                  child: Text('Erreur: ${snapshot.error}'),
                );
                //return releaseGoodWidget();
              } else if (snapshot.hasData) {
                return const DisplayReleaseWidget();
              } else {
                return const Center(child: Text('No data'));
              }
          }
        });
  }

  Widget villeAndQuartierWidgets() {
    Future retreiveDropdownCitiesInfo(int id) async {
      if (listOfCityName.length == 1) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        String fullUrl = '${baseUrl}v1/city-name/$id';

        // print(fullUrl);
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);

        var data = jsonDecode(response2.body.toString());

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

    return StatefulBuilder(builder: (context, funct) {
      void majListQuartier(List<String> list) {
        funct(() {
          listOfQuartierName = list;
        });
      }

      Widget futureListVille() {
        return FutureBuilder(
            future: retreiveDropdownCitiesInfo(1),
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
                          onChanged: (String? newValue) {}),
                      const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: Colors.blue)),
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
                    if (firstDrawerDisplay) {
                      villeSelectionee = listOfCityName
                          .elementAt(listOfCityId.indexOf(cityId) + 1);
                    }
                    return StatefulBuilder(builder: (context, funct) {
                      return DropdownButton<String>(
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
                          cityId = listOfCityId[listOfCityName
                                  .indexOf(newValue!) -
                              1]; //-1 parce que listOfCityName commence avant listOfCityId

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
                            child: Text(value),
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
                          icon: const Icon(Icons.arrow_downward),
                          items: const [],
                          hint: const Text('Chargement...'),
                          iconSize: 5,
                          elevation: 5,
                          onChanged: (String? newValue) {}),
                      const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(color: Colors.blue)),
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
                        icon: const Icon(Icons.arrow_downward),
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

                          funct(() => {quartierSelectionne = newValue});
                        },
                        items: listOfQuartierName
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(value)),

                            //Text(value,textAlign: TextAlign.center,),
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
            height: 5,
          ),
          futureListQuartier()
        ],
      );
    });
  }

  Widget futureListPropertyType() {
    Future retreiveDropdownInfoPropertyType() async {
      if (listOfProperty.length == 1) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        // var city_id=1;
        String fullUrl = '${baseUrl}v1/property-types';

        //   print(fullUrl);
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);

        var data = jsonDecode(response2.body.toString());
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
                      onChanged: (String? newValue) {}),
                  const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(color: Colors.blue)),
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
                if (firstDrawerDisplay) {
                  typeSelectionne = listOfProperty.elementAt(listOfPropertyId
                          .indexOf(propertyId) +
                      1); //+1 parce qu'il ya choisir le type en 1er. on pourra bien l'enlever après
                }

                firstDrawerDisplay = false;
                return StatefulBuilder(builder: (context, funct) {
                  return DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward),
                    //items: listOfCity.cast(),
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
                      propertyId = listOfPropertyId[
                          listOfProperty.indexOf(newValue!) - 1];

                      funct(() => {typeSelectionne = newValue});

                      //quartierSelectionne=newValue;
                    },
                    items: listOfProperty
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
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

  List<ReleaseGoodModel3> triChambre(
      List<ReleaseGoodModel3> listOfReleaseGoodModel, num nb) {
    final listTri = listOfReleaseGoodModel.where((element) {
      return element.nbChambre == nb;
    }).toList();

    return listTri;
  }

  List<ReleaseGoodModel3> triPrix(
      List<ReleaseGoodModel3> listOfReleaseGoodModel) {
    if (_prixController.text.isNotEmpty) {
      num prix = num.parse(_prixController.text);
      final listTri = listOfReleaseGoodModel.where((element) {
        return int.parse(element.cout!) <= prix;
      }).toList();

      return listTri;
    } else {
      return listOfReleaseGoodModel;
    }
  }

  List<ReleaseGoodModel3> triPeriode(
      List<ReleaseGoodModel3> listOfReleaseGoodModel) {
    if (periodActive) {
      final listTri = listOfReleaseGoodModel.where((element) {
        DateTime dateTimeSortiPrevu = DateTime.parse(element.dateSortiPrevu!);
        return dateTimeSortiPrevu.year == dateTimeChoosen.year &&
            dateTimeSortiPrevu.month == dateTimeChoosen.month;
      }).toList();

      return listTri;
    } else {
      return listOfReleaseGoodModel;
    }
  }

  List<ReleaseGoodModel3> triConvenience(
      List<ReleaseGoodModel3> listOfReleaseGoodModel) {
    List<int> listOfReleaseGoodConvIds = <int>[];
    List<int> listOfReleaseGoodConvNbs = <int>[];
    bool checkCorrespondance() {
      bool correspondance = true;

      for (var id in listOfChoosenConvenienceIds) {
        if (!listOfReleaseGoodConvIds.contains(id)) {
          correspondance = false;
          break;
        } else {
          // si l'id choisi est dans les conveniences du good
          //verifier le nombre à la position de id
          if (listOfChoosenConvenienceNbs
                  .elementAt(listOfChoosenConvenienceIds.indexOf(id)) >
              listOfReleaseGoodConvNbs
                  .elementAt(listOfReleaseGoodConvIds.indexOf(id))) {
            correspondance = false;
          }
        }
      }
      return correspondance;
    }

    final listTri = listOfReleaseGoodModel.where((releaseGood) {
      listOfReleaseGoodConvIds.clear();
      listOfReleaseGoodConvNbs.clear();

      for (int i = 0; i < releaseGood.releasegoodconvenience!.length; i++) {
        listOfReleaseGoodConvIds.add(int.parse(releaseGood
            .releasegoodconvenience!
            .elementAt(i)
            .conveniencetypeId
            .toString()));
        listOfReleaseGoodConvNbs.add(int.parse(releaseGood
            .releasegoodconvenience!
            .elementAt(i)
            .number
            .toString()));
      }

      //listOfReleaseGoodConvIds.
      //   print(listOfReleaseGoodConvIds);
      return checkCorrespondance();
    }).toList();

    return listTri;
  }

  List<ReleaseGoodModel3> triLocalite(
      List<ReleaseGoodModel3> listOfreleaseGoodModel) {
    bool checkLocalite(ReleaseGoodModel3 releaseGood) {
      bool coorespondance = false;
      if (releaseGood.city?.intitule?.compareTo(villeSelectionee) == 0) {
        if (quartierSelectionne.compareTo("Tous les quartiers") == 0) {
          coorespondance = true;
        } else if (releaseGood.quartier?.intitule
                ?.compareTo(quartierSelectionne) ==
            0) {
          coorespondance = true;
        }
      }

      return coorespondance;
    }

    final listTri = listOfreleaseGoodModel.where((element) {
      return checkLocalite(element);
    }).toList();

    return listTri;
  }

  List<ReleaseGoodModel3> triPropertyType(
      List<ReleaseGoodModel3> listOfreleaseGoodModel) {
    final listTri = listOfreleaseGoodModel.where((element) {
      return element.propertytype?.intitule?.compareTo(typeSelectionne) == 0;
    }).toList();

    return listTri;
  }

  void recupConvIdsAndCount() {
    int i = 0;
    listOfChoosenConvenienceIds.clear();
    listOfChoosenConvenienceNbs.clear();
    for (var count in nbConvList) {
      if (count > 0) {
        listOfChoosenConvenienceIds.add(listOfConvenience.elementAt(i).id);
        listOfChoosenConvenienceNbs.add(count);
      }
      i++;
    }
  }

  List<ReleaseGoodModel3> triGeneral() {
    nbOfResult = 0;
    recupConvIdsAndCount();

    late List<ReleaseGoodModel3> listReleaseGoodModel = <ReleaseGoodModel3>[];

    listReleaseGoodModel = triLocalite(listOfReleaseGoodsInitial);
    listReleaseGoodModel = triPropertyType(listReleaseGoodModel);

    if (!premierTri) {
      listReleaseGoodModel = triPeriode(listReleaseGoodModel);

      listReleaseGoodModel = triPrix(listReleaseGoodModel);

      listReleaseGoodModel = triConvenience(listReleaseGoodModel);
    } else {
      // au premier tri pour l'affichage on aura pas de message si le resultat est vide
      if (listReleaseGoodModel.isEmpty) {
        Fluttertoast.showToast(
            msg: "Aucune correspondance trouvée",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      premierTri = false;
    }

    return listReleaseGoodModel;
  }

  List<Widget> generateListOfConveniencePlusOrMinus(
      List<Conveniences> listOfConvenience) {
    List<Widget> list = [];

    for (var element in (listOfConvenience)) {
      if (element.morethanone == 1) {
        list.add(CardItemPlusOrMinus2(
          position: listOfConvenience.indexOf(element),
          convenience: element,
          list: nbConvList,
          counter: nbConvList[listOfConvenience.indexOf(element)],
        ));
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
        list.add(CardItemCheckBox(
            position: listOfConvenience.indexOf(element),
            convenience: element,
            list: nbConvList,
            checkBoxValue: (nbConvList[listOfConvenience.indexOf(element)] == 1)
                ? true
                : false));
        nbConvPlusOrMinus++;
      }
    }

    return list;
  }

  Widget generateScrollableConveniencesCard() {
    Future retreiveConveniences() async {
      //if(premierChargeConvenience) {
      if (listOfConvenience.isEmpty) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

// var city_id=1;
        String fullUrl = '${baseUrl}v1/convenience-types';

        // print(fullUrl);
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);

        if (response2.statusCode == 200) {
          final List data = jsonDecode(response2.body.toString())['data'];

          listOfConvenience =
              data.map((e) => Conveniences.fromJson(e)).toList();

          for (var element in listOfConvenience) {
            listOfConvenienceIds.add(element.id);
            nbConvList.add(0);
          }

          listOfConvenience.sort((a, b) => a.intitule.compareTo(b.intitule));
        } else {
          //return retreiveReleaseGood(fullUrl, token);
          throw Exception(response2.reasonPhrase);
        }
      }
      return listOfConvenience;
    }

    return FutureBuilder(
        future: retreiveConveniences(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                /*return Center(
                  child: Text('Erreur occured: ${snapshot.error}'),
                );*/
                return generateScrollableConveniencesCard(); // des erreurs sont générées quand la response est mal chargée. donc recommencer la construction du widget
              } else if (snapshot.hasData) {
                //premierChargeConvenience=false; // chargement des conveninces reussie mettre à false pour ne pas recharger à l'appel suivant
                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(
                          color: AppColors.mainColor,
                          width: 1,
                          style: BorderStyle.solid)),
                  child: Scrollbar(
                    thumbVisibility: true,
                    //always show scrollbar
                    thickness: 7,
                    //width of scrollbar
                    radius: const Radius.circular(20),
                    //corner radius of scrollbar
                    scrollbarOrientation: ScrollbarOrientation.right,
                    controller: scrollController,

                    child: ListView.builder(
                      primary: false,
                      controller: scrollController,
                      itemCount: listOfCardItemPlusOrMinus.length,
                      itemBuilder: (context, i) {
                        return listOfCardItemPlusOrMinus[i];
                      },
                      //children: listOfCardItemPlusOrMinus
                    ),
                  ),
                );
              } else {
                return const Center(child: Text('No data'));
              }
          }
        });
  }

  Widget getDateRangePicker() {
    return SizedBox(
      height: 200,
      child: Card(
          elevation: 15,
          child: SfDateRangePicker(
            view: DateRangePickerView.decade,
            selectionMode: DateRangePickerSelectionMode.range,

            //onSelectionChanged: selectionChanged,
          )),
    );
  }

  /* Widget villeAndQuartierWidgets() {




    return StatefulBuilder(builder: (context, funct){
      void majListQuartier(List<String> list){

        funct(() {
          listOfQuartierName=list;
        });

      }
      Future retreiveDropdownQuartierInfo( ) async {


//await Future.delayed(Duration(seconds: 30));
// print('retreiveReleaseGood $token');

        String tk='594|u2Rel1CfyBDaLRK36NXCDkP0XILHB5Sa1oqQxhT3';

        Map<String, String> headers={
          "Content-Type": "application/json",
          'Accept':'application/json',
          'Authorization': 'Bearer $tk',
        };

// var city_id=1;
        String fullUrl='${baseUrl}v1/quartiers-search/?&setcity=$cityId';

        print(fullUrl);
        final uri=Uri.parse(fullUrl);
        http.Response response2= await http.get(uri, headers: headers);


        var data= jsonDecode(response2.body.toString());


        retreiverListOfQuartierName=['Choisir le quartier'];
        retreiverListOfQuartierId=[];
        for (var element in (data as List)) {
          retreiverListOfQuartierName.add(element['intitule']);
          retreiverListOfQuartierId.add(element['id']);
        }



        listOfQuartierId=retreiverListOfQuartierId;
        //majListQuartier(retreiverListOfQuartierName);
        return data;
      }
      Widget futureListVille (){


        Future retreiveDropdownInfo( int id) async{


          //await Future.delayed(Duration(seconds: 30));
          // print('retreiveReleaseGood $token');

          String tk='594|u2Rel1CfyBDaLRK36NXCDkP0XILHB5Sa1oqQxhT3';

          Map<String, String> headers={
            "Content-Type": "application/json",
            'Accept':'application/json',
            'Authorization': 'Bearer $tk',
          };

          // var city_id=1;
          String fullUrl='${baseUrl}v1/city-name/$id';

          print(fullUrl);
          final uri=Uri.parse(fullUrl);
          http.Response response2= await http.get(uri, headers: headers);


          var data= jsonDecode(response2.body.toString());

          // print('${data['id']}');





          List<String> retreiverListOfCityName=['Choisir la ville'];
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

          return data;


        }
        return  FutureBuilder(

            future: retreiveDropdownInfo(1),
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Container(
                    child: Row(

                      children: [

                        DropdownButton<String>(
                            icon: const Icon(Icons.arrow_downward),
                            hint: Text("Chargement..."),
                            items: const [],
                            iconSize: 5,
                            elevation: 5,
                            onChanged:(String? newValue){

                            }
                        ),

                        CircularProgressIndicator(color: Colors.red),
                      ],
                    ),
                  );
                case ConnectionState.done:
                default:
                  if(snapshot.hasError) {
                    print(snapshot.error);
                    return  Center(
                      child: Text('Erreur occured: ${snapshot.error}'),
                    );

                  }else if(snapshot.hasData) {


                    return
                      StatefulBuilder(builder: (context, funct){
                        return  DropdownButton<String>(
                          icon: const Icon(Icons.arrow_downward),
                          hint: Text("Choisir la ville"),
                          iconSize: 5,
                          elevation: 5,

                          value: villeSelectionee,
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16
                          ),
                          underline: Container(
                            height: 2,
                            color: AppColors.mainColor,
                          ),

                          onChanged:(String? newValue){

                            cityId=listOfCityId[listOfCityName.indexOf(newValue!)-1]; //-1 parce que listOfCityName commence avant listOfCityId
                            //print(cityId);
                            //funct(()=>{
                            retreiveDropdownQuartierInfo().then((value) {
                              majListQuartier(retreiverListOfQuartierName);
                              //listOfQuartierName=retreiverListOfQuartierName;

                            });

                            villeSelectionee=newValue;
                            //  });

                            quartierSelectionne='Choisir le quartier';
                            //});

                            // villeSelectionee=newValue;
                          },
                          items: listOfCityName.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                        );

                      }
                      );





                  }else {
                    return
                      const Center(child: Text('No data'));
                  }
              }
            }
        );
      }

      Widget futureListQuartier(){


        return FutureBuilder(

            future: retreiveDropdownQuartierInfo(),
            builder: (context,snapshot){
              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                  return Container(
                    child: Row(

                      children: [

                        DropdownButton<String>(
                            icon: const Icon(Icons.arrow_downward),
                            items: const [],
                            hint: Text('Chargement...'),
                            iconSize: 5,
                            elevation: 5,
                            onChanged:(String? newValue){

                            }
                        ),

                        CircularProgressIndicator(color: Colors.red),
                      ],
                    ),
                  );
                case ConnectionState.done:
                default:
                  if(snapshot.hasError) {
                    print(snapshot.error);

                    return  Center(
                      child: Text('Erreur occured: ${snapshot.error}'),
                    );

                  }else if(snapshot.hasData) {



                    return


                      StatefulBuilder(builder: (context, funct){
                        return  DropdownButton<String>(
                          icon: const Icon(Icons.arrow_downward),
                          //items: listOfCity.cast(),
                          iconSize: 5,
                          elevation: 5,
                          value: quartierSelectionne,
                          underline: Container(
                            height: 2,
                            color: AppColors.mainColor,
                          ),
                          onChanged:(String? newValue){
                            quartierId=listOfQuartierId[listOfQuartierName.indexOf(newValue!)-1];


                            funct(()=>{
                              quartierSelectionne=newValue
                            });



                            //quartierSelectionne=newValue;

                          },
                          items: listOfQuartierName.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),

                        );
                      });




                  }else {
                    return
                      const Center(child: Text('No data'));
                  }
              }
            }
        );
      }
      return  Column(children: [
        futureListVille(),
        SizedBox(height: 15,),
        futureListQuartier()
      ],);
    });

  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Title(
          color: Colors.white,
          child: Text('Disponibles ($nbOfResult)'),
        ),
        elevation: 15,
        leading: Container(
            padding: const EdgeInsets.all(3),
            child: IconButton(
              onPressed: () {
                listOfCardItemPlusOrMinus =
                    generateListOfConveniencePlusOrMinus(listOfConvenience);
                listOfCardItemPlusOrMinus.addAll(
                    generateListOfConvenienceCheckBox(listOfConvenience));
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Image.asset('assets/icon/android/choix.png',
                  color: Colors.white),
            )),
      ),
      drawer: Drawer(
          elevation: 15,
          child: SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.only(right: 5, left: 5, top: 50, bottom: 20),
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    child: IconButton(
                      onPressed: () {
                        Get.offAllNamed(RouteName.navigationView);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  TitleSmallText(
                    text: 'Préférences',
                    color: Colors.indigo,
                  ).center(),
                  Divider(
                    height: 10,
                    color: AppColors.mainColor2,
                    thickness: 1,
                    endIndent: 100,
                  ),
                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      villeAndQuartierWidgets(),
                      futureListPropertyType(),
                      const SizedBox(
                        height: 15.0,
                      ),
                      StatefulBuilder(builder: (context, funct) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: dateColor,
                                // foreground
                                elevation: 10,
                                shape: const BeveledRectangleBorder(),
                                alignment: Alignment.centerRight,
                              ),

                              onPressed: periodActive
                                  ? () {
                                      showMonthYearPicker(
                                        context: context,
                                        initialDate: dateTimeChoosen,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2025),
                                        locale: const Locale("fr", "FR"),
                                      ).then((date) {
                                        if (date != null) {
                                          funct(() => {
                                                periodActive = true,
                                                periodeDeLiberation =
                                                    DateFormat.yMMM()
                                                        .format(date),
                                                dateTimeChoosen = date
                                              });
                                        }
                                      });

                                      /* showDialog(context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                              title: Text(''),
                                              content: Column(

                                                children: <Widget>[

                                                  SizedBox(
                                                    height:200,
                                                    width: 400,
                                                    child: ListView(
                                                      // shrinkWrap: true,
                                                      children: [
                                                        getDateRangePicker(),
                                                        MaterialButton(
                                                          child: Text("OK"),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  )

                                                ],
                                              ));
                                        });*/
                                      /* SfDateRangePicker(
                                      view: DateRangePickerView.year,
                                    );*/
                                    }
                                  : null,
                              //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
                              child: Row(
                                children: [
                                  const Icon(Icons.date_range_rounded),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Période: $periodeDeLiberation'),
                                ],

                                //majDate(date)
                              ),
                            ),
                            Checkbox(
                                value: periodActive,
                                onChanged: (value) {
                                  funct(() => {
                                        periodActive = value!,
                                        if (value)
                                          {
                                            periodeDeLiberation =
                                                periodeDeLiberation =
                                                    DateFormat.yMMM().format(
                                                        dateTimeChoosen),
                                            dateColor = Colors.indigo
                                          }
                                        else
                                          {
                                            periodeDeLiberation = 'Aucune',
                                            dateColor = Colors.grey
                                          }
                                      });
                                })
                          ],
                        );
                      }),

                      /*  StatefulBuilder(builder: (context, funct) {
          return CheckboxListTile(
              value: periodActive,
              title: Text('Activer la période'),
              onChanged: (value){
                funct(() =>
                {
                  periodActive=value!

                });
              });
        }),*/

                      const SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          controller: _prixController,
                          decoration: const InputDecoration(
                            labelText: "Prix maximum",
                            labelStyle:
                                TextStyle(fontSize: 15, color: Colors.black54),
                            // errorText: "Renseignez le prix",
                            border: UnderlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 7,
                          validator: (value) {
                            if (int.parse(value!) < 0) {
                              return 'Entrez une valeur correct';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      convenienceWidget,
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.indigo,
                            // foreground
                            elevation: 10,
                            shape: const StadiumBorder()),
                        onPressed: () {
                          if (villeSelectionee.compareTo('Choisir la ville') ==
                              0) {
                            Fluttertoast.showToast(
                                msg: "Définissez la localité",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 20,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (typeSelectionne
                                  .compareTo('Choisir le type') ==
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
                            List<ReleaseGoodModel3> result = triGeneral();
                            nbOfResult = result.length;
                            if (nbOfResult! > 0) {
                              setState(() {
                                listOfReleaseGoodsToDisplay = result;
                              });
                              Navigator.of(context).pop();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Aucune correspondance trouvée",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 20,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        },
                        child: const Text("Filtrer"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //),
          )),
      body: Container(
          //color: AppColors.mainColor2,
          padding:
              const EdgeInsets.only(top: 45, bottom: 20, left: 3, right: 3),
          child: releaseGoodWidget()),

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

class ResultCubit extends Cubit<String> {
  String nbOfResult = "";

  ResultCubit(String count) : super('') {
    nbOfResult = count;
  }

  void setNbOfResult(String str) {
    nbOfResult = str;
  }

  void updateNbOfResult() => emit(nbOfResult);
}

var scaffoldKey = GlobalKey<ScaffoldState>();
late Widget convenienceWidget;
var fullUrl = '${apiUrl}v1/release-goods';
//Map<String, dynamic> goods;

bool firstDrawerDisplay = true;
const baseUrl = apiUrl;

const double iconContainerH = 70.0;
const double convenienceSpace = 25.0;
const double convenienceSize = 47.0;
late List<ReleaseGoodModel3> listOfReleaseGoodsInitial;
late List<ReleaseGoodModel3> listOfReleaseGoodsToDisplay;
TextEditingController _prixController = TextEditingController();

bool initialize = true;

List<String> listOfCityName = ['Choisir la ville'];
List<int> listOfCityId = <int>[];

List<String> retreiverListOfQuartierName = [];
List<int> retreiverListOfQuartierId = [];

List<String> listOfQuartierName = ['Tous les quartiers'];
List<int> listOfQuartierId = <int>[];

List<String> listOfProperty = ['Choisir le type'];
List<int> listOfPropertyId = <int>[];

late String villeSelectionee,
    quartierSelectionne = 'Tous les quartiers',
    typeSelectionne;

int nbChambre = 0;
double prix = 25000;

num? nbOfResult = 0;

List<Map> convMap = [];

List<Widget> listOfCardItemPlusOrMinus = [];

List<Widget> listOfCardItemCheckBox = [];

List<Array> convArray = [];

bool _checkValue = false;

DateTime dateTimeChoosen = DateTime.now();

bool _accord = false;

String periodeDeLiberation = 'Aucune';

List<Conveniences> listOfConvenience = [];

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

int cityId = 0, quartierId = 0, propertyId = 0, countryId = 1;
ScrollController scrollController = ScrollController();

bool premierTri = true;
bool periodActive = false;

MaterialColor dateColor = Colors.indigo;
// bool premierChargeConvenience=true;
