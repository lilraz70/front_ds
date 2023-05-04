import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/models/PropertyTypeModel.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:front_ds/widgets/cardItemCheckbox.dart';
import 'package:front_ds/widgets/cardItemPlusOuMoins.dart';
import 'package:front_ds/widgets/mediumText.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../controllers/release_good_controller.dart';
import '../functions/utils.dart';
import '../models/Conveniences.dart';

class EnregisterReleaseGood extends StatefulWidget {
   EnregisterReleaseGood({Key? key}) : super(key: key);

  @override
  State<EnregisterReleaseGood> createState() => _EnregisterReleaseGoodState();
}

class _EnregisterReleaseGoodState extends State<EnregisterReleaseGood> {
  ReleaseGoodController controller = Get.put(ReleaseGoodController());
  dynamic hasInternetConnection = checkConnexion();

  List<Widget> generateListOfConveniencePlusOrMinus(
      List<Conveniences> listOfConvenience) {
    List<Widget> list = [];

    for (var element in (listOfConvenience)) {
      if (element.morethanone == 1) {
        list.add(CardItemPlusOrMinus(
          position: listOfConvenience.indexOf(element),
          convenience: element,
          list: nbConvList,
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
          checkBoxValue: false,
        ));
        nbConvPlusOrMinus++;
      }
    }

    return list;
  }

  Widget chambreTile() {
    return StatefulBuilder(builder: (context, funct) {
      return ListTile(
        title: MediumText(
          text: "Chambre",
        ),
        //title: MediumText(text: widget.title),
        leading: Image.asset(
          'assets/icon/android/lit.png',
          color: AppColors.mainColor,
          height: 45,
          width: 45,
        ),
        trailing: SizedBox(
          width: 200,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        if (nbChambre > 0) {
                          funct(() {
                            nbChambre--;
                          });
                        }
                      },
                      icon: const Icon(Icons.remove)),
                  MediumText(text: "$nbChambre"),
                  IconButton(
                      onPressed: () {
                        funct(() {
                          nbChambre++;
                        });
                      },
                      icon: const Icon(Icons.add)),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  String recupConvIdsAndCount() {
    String ids = "";
    convNb = "";
    int i = 0;
    for (var count in nbConvList) {
      if (count > 0) {
        ids = "${listOfConvenience.elementAt(i).id},$ids";
        convNb = "$count,$convNb";
      }
      i++;
    }

    if (ids.isNotEmpty) {
      ids = ids.substring(0, ids.length - 1);
      convNb = convNb.substring(0, convNb.length - 1);
    }

    return ids.toString();
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
    dateDeLiberation = formatDatePresentation(DateTime.now().toString());
    return StatefulBuilder(builder: (context, funct) {
      return Container(
        height: 45,
        width: 150,
        margin: const EdgeInsets.only(left: 20, right: 20),

        // padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35), color: Colors.indigo),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.indigo,
            // foreground
            elevation: 10,
            shape: BeveledRectangleBorder(),
            alignment: Alignment.centerRight,
          ),

          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
            ).then((value) {
              dateTimeChoosen = value!;
              funct(() => {
                    //dateDeLiberation = DateFormat.yMd().format(value!)
                    dateDeLiberation = formatDatePresentation(value.toString())
                  });
            });
          },
          //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
          child: Row(
            children: [
              const Icon(Icons.date_range_rounded),
              const SizedBox(
                width: 15,
              ),
              Text('Libération prévue le: $dateDeLiberation'),
            ],

            //majDate(date)
          ),
        ),
        //child: SmallText(text: 'Se Connecter'),
        // child:TextButton(onPressed: (){}, child: SmallText(text: 'Connexion'),),
      );
    });
  }

  Future enregistrer() async {
    dateDeLiberation = formatDateBD(dateTimeChoosen);
    final uri = Uri.parse('$baseUrl/v1/release-goods');
    var request = http.MultipartRequest('POST', uri);
    request.fields['date_sorti_prevu'] = dateDeLiberation;
    request.fields['setcountry_id'] = countryId.toString();
    request.fields['city_id'] = cityId.toString();
    request.fields['quartier_id'] = quartierId.toString();
    request.fields['nb_chambre'] = nbChambre.toString();
    request.fields['cout'] = prix.toString();
    request.fields['loyer_augmentera'] = false.toString();
    request.fields['user_access'] = userAccess;
    request.fields['emergencylevel_id'] = 1.toString();
    request.fields['propertytype_id'] = propertyId.toString();
    request.fields['localisation'] =localisation;
    request.fields['commentaires'] = commentaire;
    request.fields['conditions_bailleur'] = conditions;
    request.fields['contact_bailleur'] = contact;
    request.fields['date_limite'] = dateDeLiberation;
    request.fields['conveniencetype_ids'] = convIDs;
    request.fields['conveniencetype_nb'] = convNb;

    request.headers.addAll({
    "Content-Type": "application/json",
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
    });
    if(controller.imageFile != null){
      request.files.add(
          await http.MultipartFile.fromPath('image_url', controller.imageFile!.path));
    }
    if(controller.listImagePath.isNotEmpty){
      for (String path in controller.listImagePath) {
        request.files.add(
            await http.MultipartFile.fromPath("other_image[][image_url]", path));
      }
    }
    var response = await request.send();
    return response;
  }

  Future retreiveDropdownQuartierInfo() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    String fullUrl = '$baseUrl/v1/quartiers-search/?&setcity=$cityId';
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

  Widget propertyTypeWidgets() {
    Future retreiveDropdownInfoPropertyType() async {
      if (listOfProperty.length == 1) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        // var city_id=1;
        String fullUrl = '${baseUrl}/v1/property-types';
        // print(fullUrl);
        final uri = Uri.parse(fullUrl);
        http.Response response2 = await http.get(uri, headers: headers);
        var data = jsonDecode(response2.body.toString());
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
        future: retreiveDropdownInfoPropertyType(),
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
                //print(snapshot.error);
                return propertyTypeWidgets();
                return Center(
                  child: Text('Erreur occured: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                // if(firstDrawerDisplay) {
                //typeSelectionne=listOfProperty.elementAt(listOfPropertyId.indexOf(propertyId)); //+1 parce qu'il ya choisir le type en 1er. on pourra bien l'enlever après
                // }
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
                      if (newValue!.compareTo('Choisir le type') != 0) {
                        propertyId = listOfPropertyId[
                            listOfProperty.indexOf(newValue!) - 1];
                      }

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

  Widget villeAndQuartierWidgets() {
    Future retreiveDropdownCitiesInfo(int id) async {
      if (listOfCityName.length == 1) {
        Map<String, String> headers = {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };

        String fullUrl = '$baseUrl/v1/city-name/$id';

        //print(fullUrl);
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
                    //print(snapshot.error);

                    return futureListVille();
                    return Center(
                      child: Text('Erreur occured: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    /*if(firstDrawerDisplay) {
                      villeSelectionee=listOfCityName.elementAt(listOfCityId.indexOf(cityId)+1);
                    }*/
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
                          if (newValue!.compareTo('Choisir la ville') != 0) {
                            cityId = listOfCityId[listOfCityName
                                    .indexOf(newValue) -
                                1]; //-1 parce que listOfCityName commence avant listOfCityId
                          }
                          //chargerLesQuartiers=true;
                          retreiveDropdownQuartierInfo().then((value) {
                            majListQuartier(retreiverListOfQuartierName);
                            //listOfQuartierName=retreiverListOfQuartierName;
                            // chargerLesQuartiers=false;
                          });

                          villeSelectionee = newValue;
                          quartierSelectionne = 'Choisir le quartier';
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
                          if (newValue!.compareTo('Choisir le quartier') != 0) {
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

  Future retreiveConveniences() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

// var city_id=1;
    String fullUrl = '${baseUrl}/v1/convenience-types';

    // print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.get(uri, headers: headers);
    //var data = jsonDecode(response2.body.toString())['data'];
    final List data = jsonDecode(response2.body.toString())['data'];
    listOfConvenience = data.map((e) => Conveniences.fromJson(e)).toList();

    for (var element in listOfConvenience) {
      // listOfConvenienceIds.add(element.id);
      nbConvList.add(0);
    }
    listOfConvenience.sort((a, b) => a.intitule.compareTo(b.intitule));

    listOfCardItemPlusOrMinus =
        generateListOfConveniencePlusOrMinus(listOfConvenience);
    listOfCardItemPlusOrMinus
        .addAll(generateListOfConvenienceCheckBox(listOfConvenience));
    return listOfConvenience;
  }
  Widget generateListOfConveniencesCard() {
    return FutureBuilder(
        future: retreiveConveniences(),
        builder: (context, snapshot) {
          return Container(
            height: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                border: Border.all(
                    color: Colors.indigo,
                    width: 2,
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

              child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: listOfCardItemPlusOrMinus,
                  )),
            ),
          );
        });
  }
/*  Widget generateListOfConveniencesCard() {
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
                if (snapshot.error.toString().contains('FormatException')) {
                  return generateListOfConveniencesCard();
                } else {
                  return Center(
                    child: Text('Erreur : ${snapshot.error}'),
                  );
                }
              } else if (snapshot.hasData) {
                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      border: Border.all(
                          color: Colors.indigo,
                          width: 2,
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

                    child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: listOfCardItemPlusOrMinus,
                        )),
                  ),
                );
              } else {
                return const Center(child: Text('No data'));
              }
          }
        });
  }*/

  void _showSimpleDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const SimpleDialog(
            title: Text('Patientez SVP...'),
            children: [
              Center(
                  child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator())),
            ],
          );
        });
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    validateButtonEnabled = true;
    validerCircularVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;
 return   GetBuilder<ReleaseGoodController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Title(
            color: Colors.white,
            child: const Text(
              'Publier une libération',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        body: SafeArea(
          child: Form(
              key: _formKey,
              child: Container(
                margin:  EdgeInsets.only(
                    left: devicewidth * 0.040, top: deviceHeight * 0.040, right: devicewidth * 0.040, bottom: deviceHeight * 0.010),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.imageFile == null)
                        Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SizedBox(
                            width: devicewidth * 0.80,
                            height: deviceHeight * 0.1,
                            child: InkWell(
                              onTap: (() {
                                controller.getImage();
                              }),
                              child: Column(
                                children: [
                                  15.height,
                                  const Icon(Icons.add_to_photos),
                                  3.height,
                                  const Text('Ajouter la photo par defaut'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (controller.imageFile != null)
                        Container(
                          width: devicewidth * 0.80,
                          height: deviceHeight * 0.2,
                          decoration: BoxDecoration(
                              image: controller.imageFile == null
                                  ? null
                                  : DecorationImage(
                                  image: FileImage(
                                      controller.imageFile ?? File('')),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.black38,
                              ),
                              onPressed: () {
                                controller.getImage();
                              },
                            ),
                          ),
                        ),
                      50.height,
                      Obx(() {
                        if (controller.selectedFileCount.value > 0) {
                          return Row(
                            children: [
                              SizedBox(
                                width: devicewidth * 0.699,
                                child: SizedBox(
                                    height: deviceHeight * 0.1,
                                    width: devicewidth * 0.1,
                                    child: GridView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                        controller.selectedFileCount.value,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 10),
                                        itemBuilder: (context, index) {
                                          return Stack(children: [
                                            Image.file(
                                              File(controller.listImagePath[index]),
                                              fit: BoxFit.cover,
                                              height: deviceHeight * 0.1,
                                              width: devicewidth * 0.2,
                                            ),
                                            InkWell(
                                                onTap: (() {
                                                  controller.listImagePath.remove(
                                                      controller
                                                          .listImagePath[index]);
                                                  controller
                                                      .selectedFileCount.value =
                                                      controller
                                                          .listImagePath.length;
                                                  controller.onInit();
                                                }),
                                                child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                    Colors.grey.shade400,
                                                    child: const Icon(
                                                      Icons.remove,
                                                      size: 10,
                                                      color: Colors.red,
                                                    ))),
                                          ]);
                                        })),
                              ),
                              InkWell(
                                onTap: (() {
                                  controller.selectedMultipleImage();
                                }),
                                child: Card(
                                  elevation: 0,
                                  shape: const  RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                   BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: SizedBox(
                                      width: devicewidth * 0.2,
                                      height: devicewidth * 0.2,
                                      child: const  Center(
                                        child: Icon(Icons.add_to_photos),
                                      )),
                                ),
                              )
                            ],
                          );
                        } else {
                          return InkWell(
                            onTap: (() {
                              controller.selectedMultipleImage();
                            }),
                            child: Card(
                              elevation: 0,
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius:
                                 BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                width: devicewidth * 0.80,
                                height: devicewidth * 0.2,
                                child: Column(
                                  children: [
                                    15.height,
                                   const Icon(Icons.add_to_photos),
                                    3.height,
                                  const  Text('Ajouter des photos'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                      50.height,
                      villeAndQuartierWidgets(),
                      const SizedBox(
                        height: 10,
                      ),
                      // Type de maison
                      propertyTypeWidgets(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      StatefulBuilder(builder: (context, funct) {
                        return Container(
                          height: 45,
                          // width: 150,
                          margin: const EdgeInsets.only(left: 20, right: 20),

                          // padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: AppColors.mainColor),

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.indigo,
                              // foreground
                              elevation: 10,
                              shape: const BeveledRectangleBorder(),
                              alignment: Alignment.centerRight,
                            ),
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                  locale: const Locale("fr"))
                                  .then((value) {
                                dateTimeChoosen = value!;
                                funct(() => {
                                  //dateDeLiberation = DateFormat.yMd().format(value!)
                                  dateDeLiberation =
                                      formatDatePresentation(value.toString())
                                });
                              });
                            },
                            //child: MediumText(text: 'Date de Liberation:\n $dateDeLiberation'),
                            child: Row(
                              children: [
                                const Icon(Icons.date_range_rounded),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text('Libération prévue le: $dateDeLiberation'),
                              ],
                              //majDate(date)
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 25.0,
                      ),
                      generateListOfConveniencesCard(),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _prixController,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          labelText: "Prix",
                          hintText:
                          "Prix",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: Colors.grey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor2,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          fillColor: Colors.grey.withOpacity(.1),
                          filled: true,
                          contentPadding: const EdgeInsets.all(
                            10,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 7,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Entrez un prix svp';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _localisationController,
                        decoration:InputDecoration(
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          labelText: "Localisation",
                          hintText:
                          "Localisation. Ex: à proximité de, à 100m de",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: Colors.grey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor2,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          fillColor: Colors.grey.withOpacity(.1),
                          filled: true,
                          contentPadding: const EdgeInsets.all(
                            10,
                          ),
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
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: _commentaireController,
                        decoration:InputDecoration(
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          labelText: "Commentaire",
                          hintText:
                          "Commentaire",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins-Regular",
                            color: whiteColor,
                          ).copyWith(
                              color:
                              AppColors.mainColor.withOpacity(.6)),
                          border: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: Colors.grey,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(
                              context,
                              color: AppColors.mainColor2,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(
                              7,
                            ),
                          ),
                          fillColor: Colors.grey.withOpacity(.1),
                          filled: true,
                          contentPadding: const EdgeInsets.all(
                            10,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: 150,
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            decoration:InputDecoration(
                              labelStyle: const TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins-Regular",
                                color: whiteColor,
                              ).copyWith(
                                  color:
                                  AppColors.mainColor.withOpacity(.6)),
                              labelText: "Contact du bailleur",
                              hintText:
                              "Contact du bailleur",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins-Regular",
                                color: whiteColor,
                              ).copyWith(
                                  color:
                                  AppColors.mainColor.withOpacity(.6)),
                              border: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: Colors.grey,
                                  width: .5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: AppColors.mainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: AppColors.mainColor2,
                                  width: .5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              fillColor: Colors.grey.withOpacity(.1),
                              filled: true,
                              contentPadding: const EdgeInsets.all(
                                10,
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Renseignez le contact';
                              }
                              return null;
                            },
                            controller: _contactController,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _conditionController,
                            decoration:InputDecoration(
                              labelStyle: const TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins-Regular",
                                color: whiteColor,
                              ).copyWith(
                                  color:
                                  AppColors.mainColor.withOpacity(.6)),
                              labelText: "Condition de bailleur",
                              hintText:
                              "Condition de bailleur",
                              hintStyle: const TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins-Regular",
                                color: whiteColor,
                              ).copyWith(
                                  color:
                                  AppColors.mainColor.withOpacity(.6)),
                              border: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: Colors.grey,
                                  width: .5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: AppColors.mainColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(
                                  context,
                                  color: AppColors.mainColor2,
                                  width: .5,
                                ),
                                borderRadius: BorderRadius.circular(
                                  7,
                                ),
                              ),
                              fillColor: Colors.grey.withOpacity(.1),
                              filled: true,
                              contentPadding: const EdgeInsets.all(
                                10,
                              ),
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
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                              width: 215,
                              child: StatefulBuilder(builder: (context, funct) {
                                return CheckboxListTile(
                                    value: _accord,
                                    activeColor: Colors.pink,
                                    title: MediumText(
                                      text: 'J\'ai l\'accord du bailleur',
                                      color: Colors.pink,
                                    ),
                                    onChanged: (v) {
                                      funct(() {
                                        _accord = v!;
                                      });
                                    });
                              })),
                        ],
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.mainColor, // foreground
                            elevation: 10,
                            shape: const StadiumBorder()),
                        onPressed: validateButtonEnabled
                            ? () {
                          _formKey.currentState!.validate();

                          if (villeSelectionee
                              .compareTo('Choisir la ville') ==
                              0 ||
                              quartierSelectionne
                                  .compareTo('Choisir le quartier') ==
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
                          } else if (dateTimeChoosen.year == 1900) {
                            Fluttertoast.showToast(
                                msg: "Définissez la date de libération ",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 20,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else if (!_accord) {
                            Fluttertoast.showToast(
                                msg: "L'accord du bailleur est requis",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 20,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            prix = int.parse(_prixController.text);
                            localisation = _localisationController.text;
                            commentaire = _commentaireController.text;
                            contact = _contactController.text;
                            conditions = _conditionController.text;

                            convIDs = recupConvIdsAndCount();
                            if (convIDs.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Veuillez renseigner les commodités",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 20,
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              validateButtonEnabled = false;
                              /*setState(() {
                         validateButtonEnabled=false;
                         validerCircularVisible=true;
                       });*/
                              _showSimpleDialog();
                              enregistrer().then((value) {
                                _dismissDialog();
                                validateButtonEnabled = true;
                                // print(value.reasonPhrase+value.statusCode.toString());
                                if (value.statusCode == 201) {
                                  showMessage(
                                      type: "success",
                                      title: "Publication reussi",
                                      message: "Publié avec succès");
                                  Get.offAllNamed(
                                    RouteName.myPubView,
                                  );
                                } else {
                                  showMessage(
                                      type: 'error',
                                      title: "Oups!!",
                                      message: "Echec de la publication. Réessayer");

                                  /* setState(() {
                             validateButtonEnabled = true;
                             validerCircularVisible = false;
                           });*/
                                }
                              });
                            }
                          }
                        }
                            : null,
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Publier'),
                              SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: Visibility(
                                      visible: validerCircularVisible,
                                      child: const CircularProgressIndicator(
                                        color: Colors.blue,
                                      )))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      );
    });
  }
}

List<String> listOfCityName = ['Choisir la ville'];
List<int> listOfCityId = <int>[];

List<String> retreiverListOfQuartierName = [];
List<int> retreiverListOfQuartierId = [];

List<String> listOfQuartierName = ['Choisir le quartier'];
List<int> listOfQuartierId = <int>[];

List<String> listOfProperty = ['Choisir le type'];
List<int> listOfPropertyId = <int>[];

late String villeSelectionee = 'Choisir la ville',
    quartierSelectionne = 'Choisir le quartier',
    typeSelectionne = 'Choisir le type';

var cityId = 1, countryId = 1, quartierId = 0, propertyId = 0;

TextEditingController _prixController = TextEditingController();
TextEditingController _contactController = TextEditingController();
TextEditingController _conditionController = TextEditingController();
//TextEditingController _chambreController = TextEditingController();
TextEditingController _localisationController = TextEditingController();
TextEditingController _commentaireController = TextEditingController();
//TextEditingController _chambreController=TextEditingController();

String prixErreurMsg = "", contactErreurMsg = "";
var _formKey = GlobalKey<FormState>();

List<Map> convMap = [];

List<Widget> listOfCardItemPlusOrMinus = [];

List<Widget> listOfCardItemCheckBox = [];

List<Array> convArray = [];

bool validateButtonEnabled = true, validerCircularVisible = false;

DateTime dateTimeChoosen = DateTime(1900, 1, 1);

bool _accord = false;

String dateDeLiberation = '';

List<Conveniences> listOfConvenience = [];

List<int> nbConvList = [];

int nbChambre = 0, prix = 0, nbConvPlusOrMinus = 0;

String localisation = '', commentaire = '', contact = '', conditions = '';

String convNb = "";

String convIDs = "";
ScrollController scrollController = ScrollController();

