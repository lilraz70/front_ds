import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
import '../models/ReleaseGoodModel3.dart';
import '../widgets/displayReleaseGoodWidgetInHome.dart';
import '../widgets/mediumText.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic hasInternetConnection = checkConnexion();

  Future<List<ReleaseGoodModel3>> retreiveReleaseGood(String fullUrl) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.Response response2 = await http.get(
      Uri.parse(fullUrl),
      headers: headers,
    );

    if (response2.statusCode == 200) {
      final List result = jsonDecode(response2.body)['data'];
      listOfReleaseGoodsInitial =
          result.map((e) => ReleaseGoodModel3.fromJson(e)).toList();
    } else {
      //   print('response failed:${response2.statusCode} - ${response2.reasonPhrase}');
      throw Exception(response2.reasonPhrase);
    }

    /* setState(() {

    });*/
    //listOfReleaseGoodsToDisplay=triGeneral();
    listOfReleaseGoodsToDisplay = listOfReleaseGoodsInitial;

    return listOfReleaseGoodsToDisplay;
  }

  Widget releaseGoodWidget() {
    return FutureBuilder<List<ReleaseGoodModel3>>(
        future: retreiveReleaseGood(fullUrl),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.indigo),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                //  print(snapshot.error);
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Echec de chargement! Réessayer.'),
                      IconButton(
                          onPressed: () {
                            retreiveReleaseGood(fullUrl).then((value) => {
                                  setState(() {
                                    listOfReleaseGoodsToDisplay =
                                        listOfReleaseGoodsInitial;
                                  })
                                });
                          },
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
                );
                //return releaseGoodWidget();
              } else if (snapshot.hasData) {
                return displayReleaseWidgetInHome;
              } else {
                return const Center(child: Text('No data'));
              }
          }
        });
  }

  void checkConnectivity() async {
    dynamic hasInternetConnection = checkConnexion();
    hasInternetConnection.then((val) async {
      if (val) {
        connectivity = true;
      } else {
        connectivity = false;
        Fluttertoast.showToast(
            msg: 'Vérifiez votre connexion internet',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 20,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  Future<void> cleanPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future logOut() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // var city_id=1;
    String fullUrl = '${baseUrl}logout';

    // print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.post(uri, headers: headers);

    var data = jsonDecode(response2.body.toString());

    return data;
  }

  Widget dialogLogOut() {
    return AlertDialog(
      title: const Text('Me déconnecter ?'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            logOut().then((value) => {
                  if (value.statusCode == 200)
                    {
                      cleanPrefs().then((value) => //context.go("/")
                          Get.offAllNamed(
                            RouteName.init,
                          ))
                    }
                  else
                    {
                      Fluttertoast.showToast(
                          msg: 'Echec. Réessayer',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 20,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0)
                    }
                });
          },
          child: const Text('Déconnecter'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Annuler'),
        ),
      ],
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Me déconnecter ?'),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {
                /*logOut().then((value) => {
                  if(value.statusCode==200){
                    cleanPrefs().then((value) => context.go("/"))
                  }else{
                    Fluttertoast.showToast(
                        msg: 'Echec. Réessayer',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 20,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0
                    )
                  }
                });*/
                logOut().then(
                    (value) => cleanPrefs().then((value) => Get.offAllNamed(
                          RouteName.init,
                        ) /*context.go("/")*/));
              },
              child: const Text('Déconnecter'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        connectivity = true;
      } else {
        connectivity = false;

        Fluttertoast.showToast(
            msg: 'Vérifiez votre connexion internet',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 10,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await _showExitBottomSheet(context);

    return exitResult ?? false;
  }

  Future<bool?> _showExitBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: _buildBottomSheet(context),
        );
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "Voulez-vous quitter l'\n application ?",
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OUI, Quitter'),
            ),
          ],
        ),
      ],
    );
  }

  void _showSimpleInfosDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(
              'Bon à savoir',
              style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blue,
            children: [
              MediumText(
                text: ' Avec Donia Services - Je libère:',
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              MediumText(
                text: '  - Gagnez une commission de 25% du loyer',
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              MediumText(
                text: '  - Publiez ou réservez un futur déménagement',
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              MediumText(
                text: '  - Nous vous contactons pour la suite',
                color: Colors.white,
              ),
              const SizedBox(
                height: 5,
              ),
              MediumText(
                text: '  - Les visites sont gratuites',
                color: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "    **Demandez l'avis de votre bailleur",
                style: TextStyle(
                    color: Colors.yellow, fontStyle: FontStyle.italic),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  retreiveReleaseGood(fullUrl).then((value) => {
                        setState(() {
                          listOfReleaseGoodsToDisplay =
                              listOfReleaseGoodsInitial;
                        })
                      });
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                    ),

                    //TitleText(text: 'Donia Services'),

                    const SizedBox(
                      height: 35,
                    ),

                    MediumText(
                        text:
                            'Trouvez des biens immobiliers qui seront libérés pour location',
                        color: Colors.indigo,
                        size: 12),

                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(child: releaseGoodWidget())
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 10,
                  child: SizedBox(
                      height: 50,
                      width: 50,
                      child: FloatingActionButton(
                        onPressed: () {
                          Get.offAllNamed(
                            RouteName.storeReleaseGood,
                          );
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(
                          Icons.add,
                          color: Colors.indigo,
                        ),
                      )))
            ],
          ),
        ),
       /* appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        _showSimpleInfosDialog();
                      },
                      child: Title(
                        color: Colors.white,
                        child: const Text(
                          'Donia Services',
                          style: TextStyle(fontSize: 22),
                        ),
                      )),
                  SizedBox(width: deviceWidth * 0.090,),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.offAllNamed(
                        RouteName.initReleaseGoodSearch,
                      );
                      //  context.push("/home/initReleaseGoodSearch");
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _showSimpleInfosDialog();
                    },
                  ),
                ],
              ),

            ],
          ),
        ),*/
      /*  endDrawer:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 275,
              child: Drawer(
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    ListTile(
                      trailing: const Icon(Icons.house_rounded,color: Colors.indigo ,),
                      title: MediumText(text: "Besoins",),
                      onTap: () {
                        Get.offAllNamed(RouteName.besoinView,);
                        //context.push("/home/mesPubs");
                      },
                    ),
                    ListTile(
                      trailing: const Icon(Icons.public,color: Colors.indigo ,),
                      title: MediumText(text: "Mes publications",),
                      onTap: () {
                        Navigator.pop(context);
                        Get.offAllNamed(RouteName.mesPubs,);
                        //context.push("/home/mesPubs");
                      },
                    ),

                    ListTile(
                      trailing: const Icon(Icons.account_circle_outlined,color: Colors.indigo),
                      title: MediumText(text: "Mon Compte",),

                      onTap: () {
                        Navigator.pop(context);
                        Get.offAllNamed(RouteName.monCompte,);
                        //   context.push("/home/monCompte");
                      },
                    ),


                    Divider(color: AppColors.mainColor2,),
                    ListTile(
                      trailing: const Icon(Icons.logout,color: Colors.indigo ,),
                      title: MediumText(text: "Se déconnecter",),

                      onTap: () {
                        _dialogBuilder(context);
                        //dialogLogOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),*/
      ),
    );
  }
}

DisplayReleaseWidgetInHome displayReleaseWidgetInHome =
    DisplayReleaseWidgetInHome();
List<ReleaseGoodModel3> listOfReleaseGoodsInitial = [];
List<ReleaseGoodModel3> listOfReleaseGoodsToDisplay = [];
// String userAccess='';
bool connectivity = false;
const baseUrl = apiUrl;
var fullUrl = '${apiUrl}v1/release-goods';
late StreamSubscription subscription;
