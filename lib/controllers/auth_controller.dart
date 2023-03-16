import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/services/google_sign_in_api.dart';
import '../api/services/user_services.dart';
import '../configs/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
import '../models/user.dart' as Users;

class AuthController extends GetxController {

  RxBool signUp = false.obs;
  Map<String, dynamic>? facebookUserData;
  List<String> errorMessages = [];
  void changeSignUpValue() {
    bool a = !signUp.value;
    signUp.value = a;
  }

  // RxBool validNumber = true.obs;

  TextEditingController phone = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? _verificationId;
  int? forceResendingToken;
  dynamic hasInternetConnection = checkConnexion();

  Future<void> requestOTP() async {
    hasInternetConnection.then((val) async {
      if (val) {
        String fullPhoneNumber = phone.text;
        //  debugPrint("===> $fullPhoneNumber");
        verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
          User? user;
          bool error = false;
          try {
            user = (await firebaseAuth.signInWithCredential(phoneAuthCredential)).user!;
          } catch (e) {
            error = true;
            Get.back();
            showMessage(type: 'error', title: "vérification echouée echoué", message:"Le code entre est incorrect");
          }
        }

        verificationFailed(FirebaseAuthException authException) {
          //  debugPrint(authException.message.toString());
          Get.back();
          showMessage(type: 'error', title: "vérification echouée ", message:"Veuillez réessayer plus tard");
        }

        codeSent(String? verificationId, [int? forceResendingToken]) async {

         // toast("Le code OTP à été envoyé au numéro renseigné.");
          showMessage(type: "success", title: "Code OTP", message: "Le code OTP à été envoyé au numéro $fullPhoneNumber");
          this.forceResendingToken = forceResendingToken;
          _verificationId = verificationId;
          Get.back();
          // loading.value = false;

          //  debugPrint("_verificationId ==> $_verificationId");

          Get.toNamed(
              RouteName.otpVerification,
              arguments: {
                'phoneNumber': fullPhoneNumber,
                'verificationId': _verificationId,
              }
          );
        }
        codeAutoRetrievalTimeout(String verificationId) {
          _verificationId = verificationId;
        }
        try {
          await firebaseAuth.verifyPhoneNumber(
            phoneNumber: fullPhoneNumber,
            timeout: const Duration(seconds: 30),
            forceResendingToken: forceResendingToken,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          );
        } catch (e) {
          Get.back();
          showMessage(type: 'error', title: "vérification echouée", message:"Nous avons pas pu vérifier le numéro. Veuillez tenter à nouveau !");
        }
      }else {
        Get.back();
        showMessage(type: "internet");
      }
    });
  }
  Future<void> facebook() async {
    hasInternetConnection.then((val) async {
      if (val) {
        final LoginResult result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          final userData = await FacebookAuth.instance.getUserData();
          facebookUserData = userData;
          if(facebookUserData!['id'] != null  ){
            var request = await UserServices.getUserByFacebook(facebookUserData!['id']);
            if (request.ok) {
              Users.User user = Users.User(
                id: request.data['data']['id'],
                name: request.data['data']['name'],
                pseudo: request.data['data']['pseudo'],
                telephone: request.data['data']['telephone'],
                facebook_id: request.data['data']['facebook_id'],
                photo_de_profil: request.data['data']['photo_de_profil'],
              );
              SessionData.saveUser(user.toJson());
              SessionData.saveToken(request.data['data']['token']);
              SessionData.setLoggedInStatus(true);
              Get.offAllNamed(
                RouteName.navigationView,
              );
            }else{
              Get.offAllNamed(RouteName.profileInformationSociaux, arguments: {
                'type':"facebook",
                'phoneNumber': "",
                'id':facebookUserData!['id']
              });

            }
          }else {
            Get.back();
            showMessage(type: 'error', title : "L'authentification a echoué!!!", message : "veuillez réessayer. ");
          }
        } else {
          Get.back();
          showMessage(type: 'error', title : "L'authentification a echoué!!!", message : "veuillez réessayer. ");
        }
      } else {
        showMessage(type: "internet");
      }
    });
  }
  Future<void> google() async {
    hasInternetConnection.then((val) async {
      if (val) {
        final googleUser =  await GoogleSignInApi.login();
        if(googleUser!.id != null ){
          var request = await UserServices.getUserByGoogle(googleUser.id);
          if (request.ok) {
            Users.User user = Users.User(
              id: request.data['data']['id'],
              name: request.data['data']['name'],
              pseudo: request.data['data']['pseudo'],
              telephone: request.data['data']['telephone'],
              google_id: request.data['data']['goodle_id'],
              photo_de_profil: request.data['data']['photo_de_profil'],
            );
            SessionData.saveUser(user.toJson());
            SessionData.saveToken(request.data['data']['token']);
            SessionData.setLoggedInStatus(true);
            Get.offAllNamed(
              RouteName.navigationView,
            );
          }else{
            Get.offAllNamed(RouteName.profileInformationSociaux, arguments: {
              'type':"google",
              'phoneNumber': "",
              'id':googleUser.id
            });
          }
        }else {
          Get.back();
          showMessage(type: 'error', title : "L'authentification a echoué!!!", message : "veuillez réessayer. ");
        }
      } else {
        showMessage(type: "internet");
      }
    });
  }

}