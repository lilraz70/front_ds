import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../configs/app_routes.dart';
import '../../configs/http_config.dart';
import '../../configs/session_data.dart';
import '../../constants/colors.dart';
import '../../controllers/pub_controller.dart';
import '../../functions/utils.dart';
import '../../models/ReleaseGoodModel3.dart';
import '../../widgets/mediumText.dart';
import 'my_pub_view_content.dart';



class MyPubView extends StatefulWidget {
  const MyPubView({Key? key}) : super(key: key);

  @override
  State<MyPubView> createState() => _MyPubViewState();
}

class _MyPubViewState extends State<MyPubView> {
  dynamic hasInternetConnection = checkConnexion();
  PubController controller = Get.put(PubController());
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
    return Scaffold(
      body: FutureBuilder<List<ReleaseGoodModel3>>(
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
                  return myPubViewContent;
                } else {
                  return const Center(child: Text('No data'));
                }
            }
          }),
    );
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
  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        title: const Text('Mes publications'),
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.offAllNamed(RouteName.home);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.offAllNamed(
                RouteName.storeReleaseGood,
              );
            },
            child: const Icon(
              Icons.add,
              size: 30,
              color: Colors.green,
            ),
          ),
        ],
      ),
        body: SafeArea(
          child: WillPopScope(
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

                        Text(""),

                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(child: releaseGoodWidget())
                      ],
                    ),
                  ),
                 /* Positioned(
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
                          )))*/
                ],
              ),
            ),
          ),
      ),
        ),
    );
  }
}

MyPubViewContent myPubViewContent =
MyPubViewContent();
List<ReleaseGoodModel3> listOfReleaseGoodsInitial = [];
List<ReleaseGoodModel3> listOfReleaseGoodsToDisplay = [];
// String userAccess='';
bool connectivity = false;
const baseUrl = apiUrl;
var fullUrl = '${apiUrl}v1/release-goods-search/${user['id']}';
//var fullUrl = '${apiUrl}v1/release-goods';
late StreamSubscription subscription;
