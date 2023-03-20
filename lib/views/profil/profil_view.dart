import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:front_ds/constants/colors.dart';
import 'package:front_ds/functions/utils.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../api/services/google_sign_in_api.dart';
import '../../configs/app_routes.dart';
import '../../configs/http_config.dart';
import '../../configs/session_data.dart';
import '../../controllers/edit_profil_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
         Expanded(flex: 2, child: TopPortion()),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "${authUser['name']}",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          Get.offAllNamed(
                            RouteName.myPubView,
                          );
                          //Navigator.pushNamed(context, '/myPubView');
                        },
                        heroTag: 'Mes publications',
                        elevation: 0,
                        label: const Text("Mes publications"),
                        icon: const Icon(Icons.public),
                        backgroundColor: AppColors.mainColor,
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {
                          Get.offAllNamed(
                            RouteName.myBesoinView,
                          );
                        },
                        heroTag: 'Mes besoins',
                        elevation: 0,
                        backgroundColor: Colors.red,
                        label: const Text("Mes besoins"),
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  ProfileInfoRow({Key? key}) : super(key: key);

  final List<ProfileInfoItem> _items =  [
    ProfileInfoItem(title:  "Mes informations", icon: Icons.person, action: () {
      Get.offAllNamed(
      RouteName.editProfilView,
    ); },  ),
   ProfileInfoItem( title: "Déconnexion", icon: Icons.logout , action:(() async {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      String fullUrl = '$baseUrl/api/logout';
      final uri = Uri.parse(fullUrl);
      http.Response response2 = await http.post(uri, headers: headers);
      var data = jsonDecode(response2.body);
      if(data['success'] == true){
        if(user['google_id'] != null){
          final GoogleSignIn googleSignIn = GoogleSignIn();
          await googleSignIn.signOut();
        }
        if(user['facebook_id'] != null){
          await FacebookAuth.instance.logOut();
        }
        Get.offAllNamed(RouteName.authView);
        showMessage(type: "success", title: "Déconnexion réussie", message: "Vous avez été déconnecté avec succès");
      }else {
        showMessage(type: "error", title: "Echec", message: "Echec de la déconnexion, Veuillez réessayer");
      }
   }) ),
  ];

  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
            child: Row(
              children: [
                if (_items.indexOf(item) != 0) const VerticalDivider(),
                Expanded(child: singleItem(context, item)),
              ],
            )))
            .toList(),
      ),
    );
  }
  Widget singleItem(BuildContext context, ProfileInfoItem item) => GestureDetector(
    onTap: () => item.action(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(item.icon)
        ),
        Text(
          item.title,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    ),
  );

  Future<void> cleanPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  Future logOut() async {

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

          },
          child: const Text('Annuler'),
        ),
      ],
    );
  }
}

class ProfileInfoItem {
  final String title;
  final IconData icon;
  final VoidCallback action;
  const ProfileInfoItem({required this.title, required this.icon, required this.action});
}

class TopPortion extends StatelessWidget {
   TopPortion({Key? key}) : super(key: key);
  EditProfilController controller = Get.put(EditProfilController());
  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.mainColor, AppColors.mainColor2]),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if( authUser["photo_de_profil"] != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            '$baseResourceUrl${authUser["photo_de_profil"]}'
                        )),
                  ),
                ),
                if( authUser["photo_de_profil"] == null)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/defaultavatar.png"),),
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: InkWell(
                      onTap: ()=>  controller.getImage(),
                      child: const  Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
