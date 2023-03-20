import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import '../api/services/user_services.dart';
import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../configs/session_data.dart';
import '../constants/colors.dart';
import '../functions/utils.dart';
import '../models/user.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class EditProfilController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController pseudo = TextEditingController();
  TextEditingController telephone = TextEditingController();
  TextEditingController photoDeProfil = TextEditingController();
  RxBool emptyField = false.obs;
  RxBool isLoading = false.obs;
  final signupformKey = GlobalKey<FormState>();
  Map user = SessionData.getUser();
  File? imageFile;
  final picker = ImagePicker();


  String? PhotoDeProfilValidator(String? value) {
    if (value!.isEmpty) {
      return "Veuillez choisir une photo de profil.";
    } else {
      return null;
    }
  }

  String? NameValidator(String? value) {
    if (value!.isEmpty) {
      return "Veuillez renseigner votre nom.";
    } else {
      return null;
    }
  }

  String? PseudoValidator(String? value) {
    if (value!.isEmpty) {
      return "Veuillez renseigner votre Prenom.";
    }
    return null;
  }


  String? telephoneValidator(String? value) {
    if (value!.isEmpty) {
      return "Veuillez renseigner votre numero de téléphone.";
    }
    return null;
  }


  Future<void> updateUser() async {
    if (signupformKey.currentState!.validate()) {
      isLoading(true);
      User user = User(
        name: name.text,
        pseudo: pseudo.text,
        telephone: telephone.text,
      );
      var request = await UserServices.update(user);
      if (request.ok) {
        User Updateuser =  User(
          id: request.data['data']['id'],
          name: request.data['data']['name'],
          pseudo: request.data['data']['pseudo'],
          telephone: request.data['data']['telephone'],
          photo_de_profil: request.data['data']['photo_de_profil'],
        );
        SessionData.saveUser(Updateuser.toJson());
        isLoading(false);
        showMessage(type: 'success', title: "Modification reussi", message:"Modification reussi avec success");
        Get.offAllNamed(
          RouteName.editProfilView,
        );

      }else {
        isLoading(false);
        Get.back();
        showMessage(type: 'error', title: "Modification echoué", message:"Veuillez réessayer");
      }
    }
  }

  void logOut() async {
    var request = await UserServices.existToApp();
    if (request.ok) {
      Get.offAllNamed(
        RouteName.login,
      );
    } else {
      toast("Oups!! Veuillez Réassayez");
    }
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        final uri = Uri.parse('$baseUrl/v1/change_profil_picture/${user['id']}');
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll({
          "Content-Type": contentType,
          "Authorization": authorization + token,
        });
        request.files.add(
            await http.MultipartFile.fromPath('photo_de_profil', imageFile!.path));
        var response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString() ;
          var request = json.decode(responseBody);
          imageFile = null;
          User user =  User(
            id: request['data']['id'],
            name: request['data']['name'],
            pseudo: request['data']['pseudo'],
            telephone: request['data']['telephone'],
            photo_de_profil: request['data']['photo_de_profil'],

          );
          SessionData.saveUser(user.toJson());
          showMessage(type: 'success', title: "Success", message:"Photo de profil changée");
          Get.offAllNamed(
              RouteName.navigationView);
        } else {
          showMessage(type: 'error', title: "Modification echoué", message:"Veuillez reprendre");
        }
      }else{
        showMessage(type: 'error', title: "Modification echoué", message:"Veuillez choisir une image");
      }
    }else  {
      Get.back();
      showMessage(type: 'error', title: "Modification echoué", message:"Veuillez réeesayez");
    }

  }



  @override
  void onInit() {
    name.text = user['name']  ??  "" ;
    pseudo.text = user['pseudo']  ??  ""   ;
    telephone.text = user['telephone']  ??   "";
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
  }
}
