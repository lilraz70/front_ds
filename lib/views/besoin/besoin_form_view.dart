import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../configs/app_routes.dart';
import '../../constants/colors.dart';
import '../../controllers/besoin_controller.dart';

class BesoinFormView extends StatefulWidget {
  const BesoinFormView({Key? key}) : super(key: key);

  BesoinFormViewState createState() => BesoinFormViewState();
}

class BesoinFormViewState extends State<BesoinFormView> {
  BesoinController controller = Get.put(BesoinController());

  @override
  void initState() {
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
          title: const Text(
            "Ajouter un besoin",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: Obx(() {
          if (controller.loading.value) {
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
                                textInputAction: TextInputAction.next,
                                controller: controller.titre,
                                keyboardType: TextInputType.text,
                                validator: (val) => val!.isEmpty
                                    ? 'Le titre est obligatoire'
                                    : null,
                                decoration: InputDecoration(
                                  hintText:
                                      "Renseignez le titre de votre besoin",
                                  hintStyle: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins-Regular",
                                    color: whiteColor,
                                  ).copyWith(
                                      color:
                                          AppColors.mainColor.withOpacity(.6)),
                                  border: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: Colors.grey,
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: Get.theme.colorScheme.primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: AppColors.mainColor2,
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  fillColor: Colors.grey.withOpacity(.1),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(
                                    10,
                                  ),
                                ),
                              ),
                              15.height,
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: controller.description,
                                keyboardType: TextInputType.multiline,
                                maxLines: 9,
                                validator: (val) => val!.isEmpty
                                    ? 'Veuillez saisir votre bésoin '
                                    : null,
                                decoration: InputDecoration(
                                  hintText:
                                      "Renseignez la description de votre besoin",
                                  hintStyle: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Poppins-Regular",
                                    color: whiteColor,
                                  ).copyWith(
                                      color:
                                          AppColors.mainColor.withOpacity(.6)),
                                  border: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: Colors.grey,
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: Get.theme.colorScheme.primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: Divider.createBorderSide(
                                      context,
                                      color: AppColors.mainColor2,
                                      width: .5,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      7,
                                    ),
                                  ),
                                  fillColor: Colors.grey.withOpacity(.1),
                                  filled: true,
                                  contentPadding: const EdgeInsets.all(
                                    10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    InkWell(
                      onTap: (() {
                        controller.post();
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.mainColor2,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.mainColor,
                                AppColors.mainColor2,
                                AppColors.mainColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Text(
                            "Ajouter",
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
      ));
    });
  }
}
