import 'package:flutter/material.dart';
import 'package:front_ds/constants/colors.dart';
import 'package:get/get.dart';

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
                        onPressed: () {},
                        heroTag: 'Mes publications',
                        elevation: 0,
                        label: const Text("Mes publications"),
                        icon: const Icon(Icons.public),
                        backgroundColor: AppColors.mainColor,
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
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
   ProfileInfoItem( title: "Déconnexion", icon: Icons.logout , action:((){}) ),
    //ProfileInfoItem("Following", 200),
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
