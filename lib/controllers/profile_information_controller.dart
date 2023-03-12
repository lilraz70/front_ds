import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/services/user_services.dart';
import '../configs/app_routes.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
import '../models/user.dart';

class ProfileInformationController extends GetxController {
  TextEditingController phone = TextEditingController();
  String phoneNumber = Get.arguments['phoneNumber'];
  String id = Get.arguments['id'];
  String type = Get.arguments['type'];
  RxBool emptyField = false.obs;
  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  dynamic hasInternetConnection = checkConnexion();
  List<String> errorMessages = [];
  String? nameValidator(String? value) {
    if(value!.isEmpty) {
      return "Veuillez renseigner votre nom et prenom.";
    }
    return null;
  }
  String? pseudoValidator(String? value) {
    if(value!.isEmpty) {
      return "Veuillez renseigner votre pseudo.";
    }
    return null;
  }
  Future<void> postUserData() async {
    hasInternetConnection.then((val) async {
      if (val) {
        if(formKey.currentState!.validate() ) {
          if(type == "phone"){
            User user = User(
              name: name.text,
              pseudo: pseudo.text,
              telephone: phoneNumber,
            );
            var request = await UserServices.register(user);
            if (request.ok) {
              User user = User(
                id: request.data['data']['id'],
                name: request.data['data']['name'],
                pseudo: request.data['data']['pseudo'],
                telephone: request.data['data']['telephone'],
                photo_de_profil: request.data['data']['photo_de_profil'],
              );
              SessionData.saveUser(user.toJson());
              SessionData.saveToken(request.data['data']['token']);
              SessionData.setLoggedInStatus(true);
              Get.offAllNamed(
                RouteName.home,
              );
            }else{
              showMessage(type: 'error', title: "Inscription echoué", message:"veuillez réessayer");
            }
          }else if(type == "google"){
            User user = User(
              name: name.text,
              pseudo: pseudo.text,
              telephone: phone.text,
              google_id: id,
            );
            var request = await UserServices.googleRegister(user);
            if (request.ok) {
              User user = User(
                id: request.data['data']['id'],
                name: request.data['data']['name'],
                pseudo: request.data['data']['pseudo'],
                google_id: id,
                telephone: request.data['data']['telephone'],
                photo_de_profil: request.data['data']['photo_de_profil'],
              );
              SessionData.saveUser(user.toJson());
              SessionData.saveToken(request.data['data']['token']);
              SessionData.setLoggedInStatus(true);
              Get.offAllNamed(
                RouteName.home,
              );
            }else{
              errorMessages = converValidationErrors(value:request.data['errors'] );
              showMessage(type: 'error', title: "Inscription echoué", message:"  ${errorMessages}");
            }
          }else if(type == "facebook"){
            User user = User(
              name: name.text,
              pseudo: pseudo.text,
              telephone: phone.text,
              facebook_id: id,
            );
            var request = await UserServices.facebookRegister(user);
            if (request.ok) {
              User user = User(
                id: request.data['data']['id'],
                name: request.data['data']['name'],
                pseudo: request.data['data']['pseudo'],
                facebook_id: id,
                telephone: request.data['data']['telephone'],
                photo_de_profil: request.data['data']['photo_de_profil'],
              );
              SessionData.saveUser(user.toJson());
              SessionData.saveToken(request.data['data']['token']);
              SessionData.setLoggedInStatus(true);
              Get.offAllNamed(
                RouteName.home,
              );
            }else{
              errorMessages = converValidationErrors(value:request.data['errors'] );
              showMessage(type: 'error', title: "Inscription echoué", message:"${errorMessages.join(', ')}");
            }
          }

        }else{
        }
      }else {
        showMessage(type: "internet");
      }
    });
  }

  @override
  void onInit() {
    phoneNumber;
    id;
    type;
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

}