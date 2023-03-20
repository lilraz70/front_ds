import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../configs/app_routes.dart';
import '../../constants/colors.dart';
import '../../controllers/besoin_controller.dart';
import '../../models/besoin.dart';

class BesoinFormEditView extends StatefulWidget{
  const BesoinFormEditView({Key? key}) : super(key: key);

  BesoinFormEditViewState createState()=> BesoinFormEditViewState();
}

class BesoinFormEditViewState extends State<BesoinFormEditView>{
  BesoinController controller = Get.put(BesoinController());
  Besoin besoin = Get.arguments;
  @override
  void initState() {
    controller.titre.text = besoin.titre!;
    controller.description.text = besoin.description;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var devicewidth = MediaQuery.of(context).size.width;
    return GetBuilder<BesoinController>(builder: (_) {
      return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: InkWell(
                onTap: (() {
                  Get.offAllNamed(RouteName.besoinView);
                }),
                child: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              title: const Text("Ajouter un besoin", style: TextStyle(fontSize: 15),),
            ),
            body: Obx(() {
              if (controller.loading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Form(
                            key: controller.formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  20.height,
                                  TextFormField(
                                    controller: controller.titre,
                                    keyboardType: TextInputType.text,
                                    validator: (val) => val!.isEmpty ? 'Le titre est obligatoire' : null,
                                    decoration: const InputDecoration(
                                        hintText: "Renseigner le titre ",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38))),
                                  ),
                                  15.height,
                                  TextFormField(
                                    controller: controller.description,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 9,
                                    validator: (val) => val!.isEmpty ? 'Veuillez saisir votre bésoin ' : null,
                                    decoration: const InputDecoration(
                                        hintText: "La description de votre bésoin",
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.black38))),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.customBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: (() {
                                controller.edit(id: besoin.id!);
                              }),
                              child: const Text(
                                "Modifier",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
          )
      );
    });
  }
}
