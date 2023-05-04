import 'package:flutter/material.dart';
import 'package:front_ds/controllers/besoin_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/list_title_shimmer.dart';
import '../../configs/app_routes.dart';
import '../../configs/http_config.dart';
import '../../configs/session_data.dart';
import '../../constants/colors.dart';
import '../../constants/days_of_week.dart';
import '../../functions/utils.dart';
import '../../widgets/mediumText.dart';
import 'besoin_form_view.dart';

class BesoinView extends StatefulWidget {
  @override
  BesoinViewState createState() => BesoinViewState();
}

class BesoinViewState extends State<BesoinView> {
  BesoinController controller = Get.put(BesoinController());
  @override
  initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceText = MediaQuery.textScaleFactorOf(context);
    Map authUser = SessionData.getUser();
    dynamic hasInternetConnection = checkConnexion();
    return RefreshIndicator(
      onRefresh: () async {
        return Future<void>.delayed(const Duration(seconds: 2), (() {
          return controller.onInit();
        }));
      },
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(deviceWidth * 0.030),
            children: [
              //Header
              MediumText(
                  text: 'Acceder aux bésoins de la communautée',
                  color: Colors.indigo,
                  size: 12).center(),
              10.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (controller.listBesoin.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: deviceHeight * 0.8,
                            child: Obx(
                                  () => ListView.builder(
                                  controller: controller.scrollController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.infinityLoading()
                                      ? controller.listBesoin.length + 1
                                      : controller.listBesoin.length,
                                  // boucle sur les articles
                                  itemBuilder: (context, index) {
                                    if (index <
                                        controller.listBesoin.length) {
                                      var besoin =
                                      controller.listBesoin[index];
                                      String? dateString = besoin.created_at;
                                      DateTime myDate = DateTime.parse(dateString!);
                                      String formattedDate =
                                          "${myDate.day} ${getMonthName(myDate.month)} à ${myDate.hour}:${myDate.minute}";
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: 10,
                                            bottom: deviceHeight * 0.030),
                                        child: Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                deviceWidth * 0.030),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    besoin.user?.photo_de_profil !=
                                                        null
                                                        ? InkWell(
                                                      onTap: (() {}),
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                        NetworkImage(
                                                            '$baseResourceUrl${besoin.user?.photo_de_profil}'),
                                                        maxRadius: 20,
                                                        backgroundColor:
                                                        Colors.white,
                                                      ),
                                                    )
                                                        : InkWell(
                                                      onTap: (() {}),
                                                      child:
                                                      const CircleAvatar(
                                                        backgroundImage:
                                                        AssetImage(
                                                            "assets/images/defaultavatar.png"),
                                                        maxRadius: 20,
                                                        backgroundColor:
                                                        Colors.white,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(left: deviceWidth * 0.030),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "${besoin.titre}",
                                                                  textAlign : TextAlign.center,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                  overflow: TextOverflow.clip,
                                                                ),
                                                                10.height,
                                                                Wrap(
                                                                  children: [
                                                                    Text(
                                                                      "${besoin.user?.name}",
                                                                      style: const TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10,
                                                                      ),
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                    const SizedBox(width: 5),
                                                                    const Text("•", style: TextStyle(color: Colors.grey)),
                                                                    const SizedBox(width: 5),
                                                                    Text(
                                                                      formattedDate,
                                                                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                15.height,
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            besoin.description,),
                                                          15.height,

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return  Center(
                                          child: LoadingAnimationWidget.flickr(
                                            leftDotColor: AppColors.mainColor,
                                            rightDotColor: AppColors.mainColor2,
                                            size: 50,
                                          ),);
                                    }
                                  }),
                            ),
                          )
                        ],
                      );
                    } else {
                      return SizedBox(
                          height: deviceHeight * 0.7,
                          child: const Center(
                              child: Text("Aucun besoin pour le moment ")));
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(() => const BesoinFormView()
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
