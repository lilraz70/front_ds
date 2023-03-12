import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../configs/app_routes.dart';
import '../../controllers/edit_profil_controller.dart';
import 'edit_information.dart';


class EditProfilView extends StatefulWidget{
  @override
  EditeProfilViewState createState() => EditeProfilViewState();
}

class EditeProfilViewState extends State<EditProfilView>{
  @override
  Widget build(BuildContext context) {

    EditProfilController controller = Get.put(EditProfilController());
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ((){
            Get.offAllNamed(
                RouteName.profilView);
          }),
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
          title: const Text('Information personnelles', style: TextStyle(color: Colors.white), ) ,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                30.height,
                Form(
                    key: controller.signupformKey,
                    child:EditInformationView(),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}