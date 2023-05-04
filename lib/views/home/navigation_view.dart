import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:front_ds/views/profil/profil_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../configs/app_routes.dart';
import '../../configs/http_config.dart';
import '../../configs/session_data.dart';
import '../../constants/colors.dart';
import '../../pages/home.dart';
import '../../pages/initReleaseGoodSearch.dart';
import '../../widgets/mediumText.dart';
import '../besoin/besoin_view.dart';


class NavigationView extends StatefulWidget {
  const NavigationView({Key? key}) : super(key: key);
  @override
  NavigationViewState createState() => NavigationViewState();
}

class NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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

                /*IconButton(
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
                ),*/
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
        actions : <Widget> [

          CachedNetworkImage(
            imageUrl: "$baseResourceUrl${authUser["photo_de_profil"]}",
            imageBuilder: (context, imageProvider) => Padding(
              padding: EdgeInsets.only(right: deviceWidth * 0.030),
              child: InkWell(
                onTap: ((){

                }),
                child:
                CircleAvatar(
                  backgroundImage: imageProvider,
                  maxRadius: 20,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            placeholder: (context, url) => LoadingAnimationWidget.beat(
              color: Colors.white,
              size: 50,
            ),
            errorWidget: (context, url, error) =>  Image.asset("assets/images/defaultavatar.png"),
          ),
        ],
      ),
      body: SafeArea(
          child: getSlectedWidget(index: _selectedIndex)
      ),
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xff6200ee),
          unselectedItemColor: Colors.black,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
  Widget getSlectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0 : widget = const Home();
      break;
      case 1:
        widget = BesoinView();
        break;
      case 2:
        widget =  const InitReleaseGoodSearch();
        break;
      case 3:
        widget =  const ProfileView(); //  ShopView();
        break;
      default:
        widget = const Home();
        break;
    }
    return widget;
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
}

final _navBarItems = [
  SalomonBottomBarItem(
    icon: const Icon(Icons.home),
    title: const Text("Accueil"),
    selectedColor: Colors.purple,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.favorite_border),
    title: const Text("Besoin"),
    selectedColor: Colors.pink,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.search),
    title: const Text("Rechercher"),
    selectedColor: Colors.orange,
  ),
  SalomonBottomBarItem(
    icon: const Icon(Icons.person),
    title: const Text("Profil"),
    selectedColor: AppColors.mainColor,
  ),
];
