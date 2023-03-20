import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../api/services/user_services.dart';
import '../configs/app_routes.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
import '../models/user.dart' as Users;

class OtpVerificationController extends GetxController {
  String phoneNumber = Get.arguments['phoneNumber'];
  String verificationId = Get.arguments['verificationId'];

  TextEditingController otp = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;
  RxBool hasError = false.obs;
  final formKey = GlobalKey<FormState>();

  Future<void> verifyOTP() async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    bool error = false;
    User? user;
    AuthCredential credential;
    if (otp.text.length != 6) {
      hasError.value = true;
    } else {
      hasError.value = false;
      try {
        credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp.text,
        );
        user = (await firebaseAuth.signInWithCredential(credential)).user;
      } catch (e) {
        /* toast(e.toString());
        debugPrint(e.toString());*/
        error = true;
        showMessage(
            type: 'error',
            title: "vérification echouée ",
            message: "Le code entre est incorrect ");
      }
      if (!error && user != null) {
        showMessage(
            type: "success",
            title: "Vérifier",
            message: "Numéro de téléphone vérifier avec succèss");
        var request =
        await UserServices.getUserByPhone(telephone: phoneNumber);
        print(request.data);
        if (request.ok) {
          if(request.data['success'] == true){
            Users.User user = Users.User(
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
              RouteName.navigationView,
            );
          } else {
            Get.offAllNamed(RouteName.profileInformation, arguments: {
              'type':"phone",
              'phoneNumber': phoneNumber,
              'id':""});
          }
        } else {
          showMessage(
              type: 'error',
              title: "Authentification echouée ",
              message: "Veuillez réeesayer");
        }
      } else {
        showMessage(
            type: 'error',
            title: "vérification echouée ",
            message: "Veuillez réeesayer");
      }
    }
  }

  @override
  void onInit() {
    phoneNumber;
    verificationId;
    super.onInit();
  }

  @override
  void onClose() {
    // errorController!.close();
    super.onClose();
  }
}
