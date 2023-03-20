import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/models/BookReleaseGoodModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/ReleaseGoodModel3.dart';
import '../pages/home.dart';
import '../utils/colors.dart';
import 'mediumText.dart';

class DisplayReleaseWidgetInHome extends StatefulWidget {
  //ReleaseGoodModel listOfReleaseGoodsToDisplay;
  DisplayReleaseWidgetInHome({
    Key? key,
  }) : super(key: key);

  final ScrollController listViewscrollController = ScrollController();

  @override
  State<DisplayReleaseWidgetInHome> createState() =>
      _DisplayReleaseWidgetInHomeState();
}

String formatDatePresentation(String? dateStr) {
  var outputFormat = DateFormat('dd-MMM-yyyy', 'fr');
  DateTime dateTime = DateTime.parse(dateStr!);

  var outputDate = outputFormat.format(dateTime);
  return outputDate;
}

Future<void> scrollToTop() async {
/*  await Future.delayed(const Duration(milliseconds: 300));
  SchedulerBinding.instance.addPostFrameCallback((_) {
    scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn);
  });*/
}

class _DisplayReleaseWidgetInHomeState
    extends State<DisplayReleaseWidgetInHome> {
  void updateDisplay(List<ReleaseGoodModel3> releaseGoodModel) {
    setState(() {
      listOfReleaseGoodsToDisplay = releaseGoodModel;
    });
  }

  String retreiveConvenienceNb(List<Releasegoodconvenience>? list, int convID) {
    String number = '0';
    for (var element in list!) {
      if (int.parse(element.conveniencetypeId.toString()) == convID) {
        number = element.number.toString();
      }
    }

    return number;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceText = MediaQuery.textScaleFactorOf(context);
    return ListView.separated(
      itemCount: listOfReleaseGoodsToDisplay.length,
      // scrollDirection: Axis.horizontal,
      controller: widget.listViewscrollController,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: deviceHeight * 0.6,
              width: deviceWidth * 0.90,
              //padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: () {
                  // print(listOfReleaseGoodsToDisplay[index].releasegoodconvenience?.first.toJson());
                 /* showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        //return dialogDetails(listOfReleaseGoodsToDisplay[index]);
                        return DetailsWidget(
                            releaseGoodDetails:
                                listOfReleaseGoodsToDisplay[index]);
                      });*/
                  Get.offAllNamed(
                    RouteName.detailsWidgetView,
                    arguments: {
                       'releaseGood': listOfReleaseGoodsToDisplay[index], }
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 15,
                  color: Colors.white70,
                  child: Column(
                    children: [
                      20.height,
                      Padding(
                        padding: EdgeInsets.only(
                          right: deviceWidth * 0.020,
                          left: deviceWidth * 0.020,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatDatePresentation(
                                  listOfReleaseGoodsToDisplay[index]
                                      .dateSortiPrevu),
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                                '${listOfReleaseGoodsToDisplay[index].propertytype?.intitule}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      20.height,
                      listOfReleaseGoodsToDisplay[index].image_url != null
                          ? Image.network(
                              "${baseResourceUrl}${listOfReleaseGoodsToDisplay[index].image_url}",
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
                      Padding(
                        padding: EdgeInsets.only(
                          right: deviceWidth * 0.040,
                          left: deviceWidth * 0.040,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                MediumText(
                                  text: 'Ville ',
                                  color: AppColors.mainColor,
                                ),
                                3.height,
                                Text(
                                  '${listOfReleaseGoodsToDisplay[index].city?.intitule}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: true,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                MediumText(
                                  text: 'Quartier ',
                                  color: AppColors.mainColor,
                                ),
                                3.height,
                                Text(
                                  '${listOfReleaseGoodsToDisplay[index].quartier?.intitule}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  softWrap: true,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      25.height,
                      MediumText(
                        text: 'Localisation ',
                        color: AppColors.mainColor,
                      ),
                      5.height,
                      Text(
                        '${listOfReleaseGoodsToDisplay[index].localisation}',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                      ),
                      20.height,
                      MediumText(
                        text: 'Prix ',
                        color: AppColors.mainColor,
                      ),
                      5.height,
                      Text(
                        '${listOfReleaseGoodsToDisplay[index].cout}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: true,
                      ),
                      30.height,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/android/lit.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  /*  Text(
                                '${listOfReleaseGoodsToDisplay[index].nbChambre}',
                                style: TextStyle(color: AppColors.mainColor),
                              ),
*/
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        13),
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            /*   ClipRRect(
                                            borderRadius:BorderRadius.circular(12),

                                            child:
                                            */
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/android/douche.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        5),
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            Container(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/android/cuisine.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        4),
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            Container(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/android/ventilateur.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        1),
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            Container(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/icon/android/climatisation.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        2),
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  height: iconContainerH,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icon/android/garage.png',
                                        color: AppColors.mainColor,
                                        height: convenienceSize,
                                        width: convenienceSize,
                                      ),
                                      Text(
                                        retreiveConvenienceNb(
                                            listOfReleaseGoodsToDisplay[index]
                                                .releasegoodconvenience,
                                            6),
                                        style: TextStyle(
                                            color: AppColors.mainColor,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.purple,
      ),
    );
  }
}

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key, required this.releaseGoodDetails})
      : super(key: key);
  final ReleaseGoodModel3 releaseGoodDetails;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  Future souscrire(num? releasegoodId, String userAccess) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

// var city_id=1;
    String fullUrl =
        '${apiUrl}v1/bookreleasegoods?releasegood_id=$releasegoodId&user_id=$userAccess';
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.post(uri, headers: headers);
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

  Widget dialogDetails(ReleaseGoodModel3 releaseGood) {
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
        sortList(releaseGood.releasegoodconvenience!);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
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

                        /*  Text('Quartier: ${releaseGood.quartier?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text('Localisation: ${releaseGood.localisation}',style: TextStyle(fontSize: 18, color: Colors.grey),maxLines: 20,),
                    Text('Prix: ${releaseGood.cout}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text("Commentaire: ${releaseGood.commentaires?.compareTo('null')==0 ? '${releaseGood.commentaires}' : '---'}",style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text('Conditions: ${releaseGood.conditionsBailleur}',style: TextStyle(fontSize: 18, color: Colors.grey)),
*/
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
    );
  }

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
    return dialogDetails(widget.releaseGoodDetails);
  }
}

const double iconContainerH = 50.0;
const double convenienceSpace = 20.0;
const double convenienceSize = 30.0;
List<Releasegoodconvenience> listOfReleaseGoodConvenience = [];
ScrollController scrollController = ScrollController();
ScrollController scrollController2 = ScrollController();
ScrollController scrollController3 = ScrollController();

late double minScrollExtent1, maxScrollExtent1;
late int directionOfScroll;
String textButtonSouscrire = 'Souscrire';
bool circularVisibility = false, souscrireEnabled = true;

late Iterable<BookReleaseGoodModel> listOfBookReleaseGoodModel;
late BookReleaseGoodModel userBookReleaseGoodModel;
