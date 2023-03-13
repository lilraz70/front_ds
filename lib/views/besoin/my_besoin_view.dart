import 'package:flutter/material.dart';
import 'package:front_ds/controllers/besoin_controller.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/custum_tag.dart';
import '../../components/list_title_shimmer.dart';
import '../../configs/app_routes.dart';
import '../../configs/http_config.dart';
import '../../configs/session_data.dart';
import '../../constants/colors.dart';
import '../../constants/days_of_week.dart';
import '../../widgets/mediumText.dart';

class MyBesoinView extends StatefulWidget {
  const MyBesoinView({super.key});
  @override
  MyBesoinViewState createState() => MyBesoinViewState();
}

class MyBesoinViewState extends State<MyBesoinView> {
  @override
  Widget build(BuildContext context) {
    BesoinController controller = Get.put(BesoinController());
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceText = MediaQuery.textScaleFactorOf(context);
    Map authUser = SessionData.getUser();
    return RefreshIndicator(
      onRefresh: () async {
        return Future<void>.delayed(const Duration(seconds: 2), (() {
          return controller.onInit();
        }));
      },
      child: Scaffold(
        appBar:AppBar(
          leading: InkWell(
            onTap: ((){
              Get.offAllNamed(
                  RouteName.navigationView);
            }),
            child: const Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            ),
          ),
          title: const Text("Mes Besoins"),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(deviceWidth * 0.030),
            children: [
              //Header
              MediumText(
                  text: 'Mes besoins',
                  color: Colors.indigo,
                  size: 12),
              10.height,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (controller.listUserBesoin.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: deviceHeight * 0.8,
                            child: Obx(
                                  () => ListView.builder(
                                  controller: controller.scrollUserBesoinController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: controller.userBesoinInfinityLoading()
                                      ? controller.listUserBesoin.length + 1
                                      : controller.listUserBesoin.length,
                                  // boucle sur les articles
                                  itemBuilder: (context, index) {
                                    if (index <
                                        controller.listUserBesoin.length) {
                                      var besoin =
                                      controller.listUserBesoin[index];
                                      String? dateString = besoin.created_at;
                                      DateTime myDate = DateTime.parse(dateString!);
                                      String formattedDate =
                                          "${myDate.day} ${getMonthName(myDate.month)} à ${myDate.hour}:${myDate.minute}";
                                      return Card(
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
                                                          '$baseResourceUrl${authUser["photo_de_profil"]}'),
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
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${besoin.user?.name}",style: const TextStyle(color: Colors
                                                                      .grey, fontWeight: FontWeight.bold, fontSize: 10),),
                                                                  SizedBox(
                                                                    width:
                                                                    deviceWidth *
                                                                        0.02,
                                                                  ),
                                                                  const Text("•",style: TextStyle(color: Colors
                                                                      .grey,),),
                                                                  SizedBox(
                                                                    width:
                                                                    deviceWidth *
                                                                        0.02,
                                                                  ),
                                                                  Text(
                                                                    formattedDate,style: const TextStyle(color: Colors
                                                                      .grey,fontSize: 10),),

                                                                  SizedBox(
                                                                    width:
                                                                    deviceWidth *
                                                                        0.02,
                                                                  ),
                                                                  const Text("•", style: TextStyle(color: Colors
                                                                      .grey,),),
                                                                  SizedBox(
                                                                    width:
                                                                    deviceWidth *
                                                                        0.02,
                                                                  ),
                                                                  const Icon(
                                                                    Icons.public,
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                    child: Padding(
                                                      padding: const  EdgeInsets.only(right: 8),
                                                      child: CustumTag(backgroundColor: Colors.grey.shade200, children:const [
                                                      Icon(Icons.more_vert, color: Colors.blue,),
                                                      ]),

                                                    ),
                                                    itemBuilder: (context) => [
                                                      const PopupMenuItem(child: Text("Editer"), value: "edit",),
                                                      const PopupMenuItem(child: Text("Supprimer"), value: "delete",)
                                                    ],
                                                    onSelected: (val){
                                                      if(val == "edit"){
                                                        Get.toNamed(RouteName.besoinFormEditView,
                                                            arguments: besoin);
                                                      }
                                                      else{
                                                        Get.defaultDialog(
                                                          title: "Vous êtes sûre de supprimé ",
                                                         middleText: "${besoin.titre} ? ",
                                                          textConfirm: 'Supprimer',
                                                          textCancel: 'Annuler',
                                                          barrierDismissible: false,
                                                          cancelTextColor: Colors.black87,
                                                          confirmTextColor: Colors.red,
                                                          buttonColor: AppColors.mainColor,
                                                          onConfirm: () => controller.deleteBesoin(besoin.id),
                                                          onCancel: () => Get.back(),
                                                        );
                                                        //controller.deleteAnnonce(annonces[index].id);
                                                      }
                                                    },),
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
                                      );
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ),
                          )
                        ],
                      );
                    } else {
                      return SizedBox(
                          height: deviceHeight * 0.7,
                          child: const ListTitleShimmer());
                    }
                  }),
                ],
              ),
            ],
          ),
        ),

      ),
    );
  }
}
