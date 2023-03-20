import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/models/BookReleaseGoodModel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/custum_tag.dart';
import '../components/image_container.dart';
import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/ReleaseGoodModel3.dart';
import '../pages/home.dart';
import '../utils/colors.dart';
import 'mediumText.dart';

class DetailsWidgetView extends StatefulWidget {
  const DetailsWidgetView({
    Key? key,
  }) : super(key: key);

  @override
  DetailsWidgetState createState() => DetailsWidgetState();
}

class DetailsWidgetState extends State<DetailsWidgetView> {
  ReleaseGoodModel3 releaseGoodDetails = Get.arguments['releaseGood'];
  late Iterable<BookReleaseGoodModel> listOfBookReleaseGoodModel;
  String textButtonSouscrire = 'Souscrire';
  late BookReleaseGoodModel userBookReleaseGoodModel;
  List<Releasegoodconvenience> listOfReleaseGoodConvenience = [];
  bool circularVisibility = false, souscrireEnabled = true;

  String formatDatePresentation(String? dateStr) {
    var outputFormat = DateFormat('dd-MMM-yyyy', 'fr');
    DateTime dateTime = DateTime.parse(dateStr!);

    var outputDate = outputFormat.format(dateTime);
    return outputDate;
  }

  Future souscrire(num? releasegoodId, String userAccess) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
// var city_id=1;
    String fullUrl =
        '${apiUrl}v1/bookreleasegoods?releasegood_id=$releasegoodId&user_id=$userAccess';

    // print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.post(uri, headers: headers);

    //var data = jsonDecode(response2.body.toString());

    return response2;
  }

  Widget buttonText(num? releasegoodId, int userId) {
    Future retreiveUserSouscription(num? releasegoodId, int userId) async {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      //  print('userId: $userId');
      String fullUrl = '${apiUrl}v1/bookreleasegoods';

      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.get(uri, headers: headers);

      //print('releasegoodID: $releasegoodId');

      final List data = jsonDecode(response2.body)['data'];
      listOfBookReleaseGoodModel =
          data.map((e) => BookReleaseGoodModel.fromJson(e)).toList();

      // print('${listOfBookReleaseGoodModel.length}');

      final matchingBookReleaseGood =
          listOfBookReleaseGoodModel.firstWhereOrNull((element) {
        return int.parse(element.userId.toString()) == userId &&
            int.parse(element.releasegoodId.toString()) == releasegoodId;
      });
      if (matchingBookReleaseGood == null) {
        textButtonSouscrire = "Réserver";
      } else {
        textButtonSouscrire = "Déjà réservé. Annuler";
        userBookReleaseGoodModel = matchingBookReleaseGood;
      }

      //  print('releasegoodID: $releasegoodId');
      return response2;
    }

    return FutureBuilder(
        future: retreiveUserSouscription(releasegoodId, userId),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(color: Colors.indigo)),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                // print(snapshot.error);
                /* return Center(
                  child: Text('Erreur occured: ${snapshot.error}'),
                );*/
                return MediumText(
                    text: textButtonSouscrire, color: Colors.green);
              } else if (snapshot.hasData) {
                return MediumText(
                    text: textButtonSouscrire, color: Colors.green);
              } else {
                return MediumText(
                    text: textButtonSouscrire, color: Colors.green);
              }
          }
        });
  }

  Future annulerSouscription(num? bookReleasegoodId) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

// var city_id=1;
    String fullUrl = '${apiUrl}v1/bookreleasegoods/$bookReleasegoodId';

    //print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.delete(uri, headers: headers);

    //var data = jsonDecode(response2.body.toString());

    return response2;
  }

/*  Widget dialogDetails(ReleaseGoodModel3 releaseGood) {

    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceText = MediaQuery.textScaleFactorOf(context);
    return SingleChildScrollView(
      child:  Container(
         // padding: const EdgeInsets.all(20.5),
          decoration: BoxDecoration(
            borderRadius:  const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10)),
            color: Colors.grey.shade100,
          ),
          child:
        Column(
          children: [
            releaseGood.image_url != null
                ? Image.network(
              "${baseResourceUrl}${releaseGood.image_url}",
              fit: BoxFit.cover,
              height: deviceHeight * 0.2,
              width: deviceWidth * 0.90,
            )
                : Image.asset(
              "assets/images/logomdpi.png",
              fit: BoxFit.cover,
              height: deviceHeight * 0.2,
              width: deviceWidth * 0.90,
            ),
        20.height,
        MediumText(
        text:
        'Libre le: ${formatDatePresentation(releaseGood.dateSortiPrevu)}',
          color: Colors.indigo,
          size: 20),
            20.height,
            SizedBox(
              width: 350,
              height: 600,
              child: ListView(
                 // controller: scrollController,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 230,
                      child:ListView(

                        children: [
                          Row(
                            children: [
                              MediumText(
                                text: 'Type: ',
                                color: AppColors.mainColor,
                              ),
                              Text('${releaseGood.propertytype?.intitule}')
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Quartier: ',
                                color: AppColors.mainColor,
                              ),
                              Text('${releaseGood.quartier?.intitule}')
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Localisation: ',
                                color: AppColors.mainColor,
                              ),
                              Flexible(
                                  child: Text(
                                    '${releaseGood.localisation}',
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Prix: ',
                                color: AppColors.mainColor,
                              ),
                              Text('${releaseGood.cout}')
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Commentaires: ',
                                color: AppColors.mainColor,
                              ),
                              Flexible(
                                  child: Text(releaseGood.commentaires
                                      .toString()
                                      .compareTo('null') ==
                                      0
                                      ? '---'
                                      : '${releaseGood.commentaires}'))
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              MediumText(
                                text: 'Conditions: ',
                                color: AppColors.mainColor,
                              ),
                              Flexible(
                                  child:
                                  Text('${releaseGood.conditionsBailleur}'))
                            ],
                          ),

                          */ /*  Text('Quartier: ${releaseGood.quartier?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('Localisation: ${releaseGood.localisation}',style: TextStyle(fontSize: 18, color: Colors.grey),maxLines: 20,),
                        Text('Prix: ${releaseGood.cout}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text("Commentaire: ${releaseGood.commentaires?.compareTo('null')==0 ? '${releaseGood.commentaires}' : '---'}",style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('Conditions: ${releaseGood.conditionsBailleur}',style: TextStyle(fontSize: 18, color: Colors.grey)),
*/ /*
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MediumText(
                      text: 'Les commodités',
                      color: Colors.indigo,
                      size: 17,
                    ),
                    Container(
                      height: 200,
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      child: Scrollbar(
                        thumbVisibility: true,
                        //always show scrollbar
                        thickness: 3,
                        //width of scrollbar
                        radius: const Radius.circular(20),
                        //corner radius of scrollbar
                        scrollbarOrientation: ScrollbarOrientation.right,


                        child: ListView.builder(

                            itemCount: listOfReleaseGoodConvenience.length,
                            itemBuilder: (context, i) {
                              */ /* return ListTile(
                                leading: Icon(Icons.circle,color: Colors.blueGrey,size: 10,),
                                title: MediumText(text: '${releaseGood.releasegoodconvenience?.elementAt(i).conveniencetype?.intitule}',color: Colors.blueGrey,),
                              );*/ /*
                              return SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      color: AppColors.mainColor,
                                      size: 7,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    MediumText(
                                      text: convenienceText(
                                          listOfReleaseGoodConvenience
                                              .elementAt(i)),
                                      color: AppColors.mainColor,
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        MediumText(text: 'Code: ', color: Colors.blue, size: 13),
                        Text(
                          releaseGood.libelle.toString(),
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: IconButton(
                              onPressed: () async {
                                await FlutterClipboard.copy(
                                    releaseGood.libelle.toString())
                                    .then((value) => {
                                  Fluttertoast.showToast(
                                      msg: "Copié !",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 20,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                });
                              },
                              icon: const Icon(
                                Icons.copy,
                                size: 15,
                              )),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await launch("tel:0022674783108");
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                              size: 20,
                            )),
                        Column(
                          children: [
                            TextButton(
                                onPressed: souscrireEnabled
                                    ? () {
                                  setState(() {
                                    circularVisibility = true;
                                    souscrireEnabled = false;
                                  });

                                  if (textButtonSouscrire
                                      .compareTo('Réserver') ==
                                      0) {
                                    souscrire(releaseGood.id, userAccess)
                                        .then((value) => {
                                      if (value.statusCode == 201)
                                        {
                                          Fluttertoast.showToast(
                                              msg: "Réservé !",
                                              toastLength:
                                              Toast.LENGTH_LONG,
                                              gravity:
                                              ToastGravity.CENTER,
                                              timeInSecForIosWeb: 20,
                                              backgroundColor:
                                              Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0),
                                          setState(() {
                                            circularVisibility =
                                            false;
                                            souscrireEnabled = true;
                                            textButtonSouscrire =
                                            "Annuler réservation";
                                          }),
                                        }
                                      else
                                        {
                                          Fluttertoast.showToast(
                                              msg:
                                              "Echec de réservation. ${value.reasonPhrase}",
                                              toastLength:
                                              Toast.LENGTH_LONG,
                                              gravity:
                                              ToastGravity.CENTER,
                                              timeInSecForIosWeb: 20,
                                              backgroundColor:
                                              Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0),
                                          setState(() {
                                            circularVisibility =
                                            false;
                                            souscrireEnabled = true;
                                          }),
                                        }
                                    });
                                  } else {
                                    annulerSouscription(
                                        userBookReleaseGoodModel.id)
                                        .then((value) => {
                                      if (value.statusCode == 204)
                                        {
                                          Fluttertoast.showToast(
                                              msg:
                                              "Réservation annulée.",
                                              toastLength:
                                              Toast.LENGTH_LONG,
                                              gravity:
                                              ToastGravity.CENTER,
                                              timeInSecForIosWeb: 20,
                                              backgroundColor:
                                              Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0),
                                          setState(() {
                                            circularVisibility =
                                            false;
                                            souscrireEnabled = true;
                                            textButtonSouscrire =
                                            "Réserver";
                                          }),
                                        }
                                      else
                                        {
                                          Fluttertoast.showToast(
                                              msg:
                                              "Echec. Veuillez réessayez",
                                              toastLength:
                                              Toast.LENGTH_LONG,
                                              gravity:
                                              ToastGravity.CENTER,
                                              timeInSecForIosWeb: 20,
                                              backgroundColor:
                                              Colors.green,
                                              textColor: Colors.white,
                                              fontSize: 16.0),
                                          setState(() {
                                            circularVisibility =
                                            false;
                                            souscrireEnabled = true;
                                          }),
                                        }
                                    });
                                  }
                                }
                                    : null,
                                //child: MediumText(text:textButtonSouscrire,color: Colors.green,size: 17)),
                                child: buttonText(releaseGood.id, user['id'])),
                            //Visibility(visible:circularVisibility,child: CircularProgressIndicator(color: AppColors.mainColor2,))
                          ],
                        )
                      ],
                    ),
                  ]),
            ),
           */ /* AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: MediumText(
                  text:
                  'Libre le: ${formatDatePresentation(releaseGood.dateSortiPrevu)}',
                  color: Colors.indigo,
                  size: 20),
              content: Scrollbar(
                thumbVisibility: true,
                //always show scrollbar
                thickness: 5,
                //width of scrollbar
                radius: const Radius.circular(20),
                //corner radius of scrollbar
                scrollbarOrientation: ScrollbarOrientation.right,
                controller: scrollController3,
                child: Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  width: 350,
                  height: 600,
                  child: ListView(
                      controller: scrollController,
                      //crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 230,
                          child: Scrollbar(
                            thumbVisibility: true,
                            //always show scrollbar
                            thickness: 3,
                            //width of scrollbar
                            radius: const Radius.circular(20),
                            //corner radius of scrollbar
                            scrollbarOrientation: ScrollbarOrientation.right,
                            controller: scrollController,
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Type: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Text('${releaseGood.propertytype?.intitule}')
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Quartier: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Text('${releaseGood.quartier?.intitule}')
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Localisation: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Flexible(
                                        child: Text(
                                          '${releaseGood.localisation}',
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Prix: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Text('${releaseGood.cout}')
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Commentaires: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Flexible(
                                        child: Text(releaseGood.commentaires
                                            .toString()
                                            .compareTo('null') ==
                                            0
                                            ? '---'
                                            : '${releaseGood.commentaires}'))
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    MediumText(
                                      text: 'Conditions: ',
                                      color: AppColors.mainColor,
                                    ),
                                    Flexible(
                                        child:
                                        Text('${releaseGood.conditionsBailleur}'))
                                  ],
                                ),

                                */ /**/ /*  Text('Quartier: ${releaseGood.quartier?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('Localisation: ${releaseGood.localisation}',style: TextStyle(fontSize: 18, color: Colors.grey),maxLines: 20,),
                        Text('Prix: ${releaseGood.cout}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text("Commentaire: ${releaseGood.commentaires?.compareTo('null')==0 ? '${releaseGood.commentaires}' : '---'}",style: TextStyle(fontSize: 18, color: Colors.grey)),
                        Text('Conditions: ${releaseGood.conditionsBailleur}',style: TextStyle(fontSize: 18, color: Colors.grey)),
*/ /**/ /*
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MediumText(
                          text: 'Les commodités',
                          color: Colors.indigo,
                          size: 17,
                        ),
                        Container(
                          height: 200,
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                          child: Scrollbar(
                            thumbVisibility: true,
                            //always show scrollbar
                            thickness: 3,
                            //width of scrollbar
                            radius: const Radius.circular(20),
                            //corner radius of scrollbar
                            scrollbarOrientation: ScrollbarOrientation.right,
                            controller: scrollController2,

                            child: ListView.builder(
                                controller: scrollController2,
                                itemCount: listOfReleaseGoodConvenience.length,
                                itemBuilder: (context, i) {
                                  */ /**/ /* return ListTile(
                                leading: Icon(Icons.circle,color: Colors.blueGrey,size: 10,),
                                title: MediumText(text: '${releaseGood.releasegoodconvenience?.elementAt(i).conveniencetype?.intitule}',color: Colors.blueGrey,),
                              );*/ /**/ /*
                                  return SizedBox(
                                    height: 30,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Icon(
                                          Icons.circle,
                                          color: AppColors.mainColor,
                                          size: 7,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        MediumText(
                                          text: convenienceText(
                                              listOfReleaseGoodConvenience
                                                  .elementAt(i)),
                                          color: AppColors.mainColor,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            MediumText(text: 'Code: ', color: Colors.blue, size: 13),
                            Text(
                              releaseGood.libelle.toString(),
                              style: TextStyle(fontSize: 13),
                            ),
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: IconButton(
                                  onPressed: () async {
                                    await FlutterClipboard.copy(
                                        releaseGood.libelle.toString())
                                        .then((value) => {
                                      Fluttertoast.showToast(
                                          msg: "Copié !",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 20,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                    size: 15,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  await launch("tel:0022674783108");
                                },
                                icon: const Icon(
                                  Icons.call,
                                  color: Colors.green,
                                  size: 20,
                                )),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: souscrireEnabled
                                        ? () {
                                      setState(() {
                                        circularVisibility = true;
                                        souscrireEnabled = false;
                                      });

                                      if (textButtonSouscrire
                                          .compareTo('Réserver') ==
                                          0) {
                                        souscrire(releaseGood.id, userAccess)
                                            .then((value) => {
                                          if (value.statusCode == 201)
                                            {
                                              Fluttertoast.showToast(
                                                  msg: "Réservé !",
                                                  toastLength:
                                                  Toast.LENGTH_LONG,
                                                  gravity:
                                                  ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 20,
                                                  backgroundColor:
                                                  Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0),
                                              setState(() {
                                                circularVisibility =
                                                false;
                                                souscrireEnabled = true;
                                                textButtonSouscrire =
                                                "Annuler réservation";
                                              }),
                                            }
                                          else
                                            {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Echec de réservation. ${value.reasonPhrase}",
                                                  toastLength:
                                                  Toast.LENGTH_LONG,
                                                  gravity:
                                                  ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 20,
                                                  backgroundColor:
                                                  Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0),
                                              setState(() {
                                                circularVisibility =
                                                false;
                                                souscrireEnabled = true;
                                              }),
                                            }
                                        });
                                      } else {
                                        annulerSouscription(
                                            userBookReleaseGoodModel.id)
                                            .then((value) => {
                                          if (value.statusCode == 204)
                                            {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Réservation annulée.",
                                                  toastLength:
                                                  Toast.LENGTH_LONG,
                                                  gravity:
                                                  ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 20,
                                                  backgroundColor:
                                                  Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0),
                                              setState(() {
                                                circularVisibility =
                                                false;
                                                souscrireEnabled = true;
                                                textButtonSouscrire =
                                                "Réserver";
                                              }),
                                            }
                                          else
                                            {
                                              Fluttertoast.showToast(
                                                  msg:
                                                  "Echec. Veuillez réessayez",
                                                  toastLength:
                                                  Toast.LENGTH_LONG,
                                                  gravity:
                                                  ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 20,
                                                  backgroundColor:
                                                  Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0),
                                              setState(() {
                                                circularVisibility =
                                                false;
                                                souscrireEnabled = true;
                                              }),
                                            }
                                        });
                                      }
                                    }
                                        : null,
                                    //child: MediumText(text:textButtonSouscrire,color: Colors.green,size: 17)),
                                    child: buttonText(releaseGood.id, user['id'])),
                                //Visibility(visible:circularVisibility,child: CircularProgressIndicator(color: AppColors.mainColor2,))
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ),
            ),*/ /*
          ],
        ),
      )
    );
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    circularVisibility = false;
    souscrireEnabled = true;
    textButtonSouscrire = 'Réserver';
  }

  @override
  Widget build(BuildContext context) {
    String convenienceText(Releasegoodconvenience? releasegoodconvenience) {
      String text = '';
      if (releasegoodconvenience?.conveniencetype?.morethanone == '1') {
        text =
            '${releasegoodconvenience?.conveniencetype?.intitule} x${releasegoodconvenience?.number}';
      } else {
        text = '${releasegoodconvenience?.conveniencetype?.intitule}';
      }

      return text;
    }

    List<Releasegoodconvenience> sortList(
        List<Releasegoodconvenience> listOfReleaseGood) {
      listOfReleaseGood.sort((a, b) => a.conveniencetype!.intitule!
          .compareTo(b.conveniencetype!.intitule!)); //par ordre alphabétique
      //  listOfReleaseGood.sort((a,b) => b.conveniencetype!.morethanone!.compareTo(a.conveniencetype!.morethanone!)); // selon qu'il soit dénombrable ou non
      return listOfReleaseGood;
    }

    listOfReleaseGoodConvenience =
        sortList(releaseGoodDetails.releasegoodconvenience!);
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceText = MediaQuery.textScaleFactorOf(context);
    return ImageContainer(
        widht: double.infinity,
        imageUrl: releaseGoodDetails.image_url,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: InkWell(
              onTap: (() {
                Get.offAllNamed(RouteName.navigationView);
              }),
              child: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          extendBodyBehindAppBar: true,
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.20,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MediumText(
                              text: 'Code: ', color: Colors.blue, size: 13),
                          Text(
                            releaseGoodDetails.libelle.toString(),
                            style: TextStyle(fontSize: 13),
                          ),
                          SizedBox(
                            height: 25,
                            width: 25,
                            child: IconButton(
                                onPressed: () async {
                                  await FlutterClipboard.copy(
                                          releaseGoodDetails.libelle.toString())
                                      .then((value) => {
                                            Fluttertoast.showToast(
                                                msg: "Copié !",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 20,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                                fontSize: 16.0)
                                          });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 15,
                                )),
                          ),
                          const Spacer(),
                          CustumTag(
                              backgroundColor: Colors.grey.shade200,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        TextButton(
                                            onPressed: souscrireEnabled
                                                ? () {
                                              setState(() {
                                                circularVisibility = true;
                                                souscrireEnabled = false;
                                              });

                                              if (textButtonSouscrire
                                                  .compareTo(
                                                  'Réserver') ==
                                                  0) {
                                                souscrire(
                                                    releaseGoodDetails.id,
                                                    userAccess)
                                                    .then((value) => {
                                                  if (value
                                                      .statusCode ==
                                                      201)
                                                    {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "Réservé !",
                                                          toastLength:
                                                          Toast
                                                              .LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb:
                                                          20,
                                                          backgroundColor:
                                                          Colors
                                                              .green,
                                                          textColor:
                                                          Colors
                                                              .white,
                                                          fontSize:
                                                          16.0),
                                                      setState(() {
                                                        circularVisibility =
                                                        false;
                                                        souscrireEnabled =
                                                        true;
                                                        textButtonSouscrire =
                                                        "Annuler réservation";
                                                      }),
                                                    }
                                                  else
                                                    {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "Echec de réservation. ${value.reasonPhrase}",
                                                          toastLength:
                                                          Toast
                                                              .LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb:
                                                          20,
                                                          backgroundColor:
                                                          Colors
                                                              .green,
                                                          textColor:
                                                          Colors
                                                              .white,
                                                          fontSize:
                                                          16.0),
                                                      setState(() {
                                                        circularVisibility =
                                                        false;
                                                        souscrireEnabled =
                                                        true;
                                                      }),
                                                    }
                                                });
                                              } else {
                                                annulerSouscription(
                                                    userBookReleaseGoodModel
                                                        .id)
                                                    .then((value) => {
                                                  if (value
                                                      .statusCode ==
                                                      204)
                                                    {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "Réservation annulée.",
                                                          toastLength:
                                                          Toast
                                                              .LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb:
                                                          20,
                                                          backgroundColor:
                                                          Colors
                                                              .green,
                                                          textColor:
                                                          Colors
                                                              .white,
                                                          fontSize:
                                                          16.0),
                                                      setState(() {
                                                        circularVisibility =
                                                        false;
                                                        souscrireEnabled =
                                                        true;
                                                        textButtonSouscrire =
                                                        "Réserver";
                                                      }),
                                                    }
                                                  else
                                                    {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                          "Echec. Veuillez réessayez",
                                                          toastLength:
                                                          Toast
                                                              .LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb:
                                                          20,
                                                          backgroundColor:
                                                          Colors
                                                              .green,
                                                          textColor:
                                                          Colors
                                                              .white,
                                                          fontSize:
                                                          16.0),
                                                      setState(() {
                                                        circularVisibility =
                                                        false;
                                                        souscrireEnabled =
                                                        true;
                                                      }),
                                                    }
                                                });
                                              }
                                            }
                                                : null,
                                            //child: MediumText(text:textButtonSouscrire,color: Colors.green,size: 17)),
                                            child: buttonText(
                                                releaseGoodDetails.id, user['id'])),
                                        //Visibility(visible:circularVisibility,child: CircularProgressIndicator(color: AppColors.mainColor2,))
                                      ],
                                    ),
                                  const  Text("ou"),
                                    IconButton(
                                        onPressed: () async {
                                          await launch("tel:0022674783108");
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.green,
                                          size: 20,
                                        )),
                                  ],
                                ),

                              ]),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MediumText(
                          text:
                              'Libre le: ${formatDatePresentation(releaseGoodDetails.dateSortiPrevu)}',
                          color: Colors.indigo,
                          size: 20),
                      20.height,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                MediumText(
                                  text: 'Type  ',
                                  color: AppColors.mainColor,
                                ),
                                10.height,
                                Text(
                                    '${releaseGoodDetails.propertytype?.intitule}')
                              ],
                            ),
                            Column(
                              children: [
                                MediumText(
                                  text: 'Quartier ',
                                  color: AppColors.mainColor,
                                ),
                                10.height,
                                Text('${releaseGoodDetails.quartier?.intitule}')
                              ],
                            ),
                          ]),
                      20.height,
                      Row(
                        children: [
                          MediumText(
                            text: 'Prix: ',
                            color: AppColors.mainColor,
                          ),
                          Text('${releaseGoodDetails.cout}')
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          MediumText(
                            text: 'Localisation : ',
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                      5.height,
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.20),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                              '${releaseGoodDetails.localisation}',
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          MediumText(
                            text: 'Commentaires: ',
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                      5.height,
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.25),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(releaseGoodDetails.commentaires
                                            .toString()
                                            .compareTo('null') ==
                                        0
                                    ? '---'
                                    : '${releaseGoodDetails.commentaires}'))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          MediumText(
                            text: 'Conditions: ',
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                      5.height,
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.20),
                        child: Row(
                          children: [
                            Flexible(
                                child: Text(
                                    '${releaseGoodDetails.conditionsBailleur}'))
                          ],
                        ),
                      ),
                     20.height,
                      MediumText(
                        text: 'Les commodités',
                        color: Colors.indigo,
                        size: 17,
                      ),
                      Container(
                        height: 200,
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 10),
                        child: Scrollbar(
                          thumbVisibility: true,
                          //always show scrollbar
                          thickness: 3,
                          //width of scrollbar
                          radius: const Radius.circular(20),
                          //corner radius of scrollbar
                          scrollbarOrientation: ScrollbarOrientation.right,

                          child: ListView.builder(
                              itemCount: listOfReleaseGoodConvenience.length,
                              itemBuilder: (context, i) {
                                /* return ListTile(
                                leading: Icon(Icons.circle,color: Colors.blueGrey,size: 10,),
                                title: MediumText(text: '${releaseGood.releasegoodconvenience?.elementAt(i).conveniencetype?.intitule}',color: Colors.blueGrey,),
                              );*/
                                return SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: AppColors.mainColor,
                                        size: 7,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      MediumText(
                                        text: convenienceText(
                                            listOfReleaseGoodConvenience
                                                .elementAt(i)),
                                        color: AppColors.mainColor,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          itemCount: releaseGoodDetails.images?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.25),
                          itemBuilder: ((context, item) {
                            if (releaseGoodDetails.images?.length != null) {
                              return ImageContainer(
                                  widht:
                                      MediaQuery.of(context).size.width * 0.42,
                                  imageUrl: releaseGoodDetails.images![item]
                                      ['image_url']);
                            } else {
                              return const Text("");
                            }
                          })),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
