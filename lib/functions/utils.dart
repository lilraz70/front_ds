import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../constants/colors.dart';


converValidationErrors({required value}){
  List<String> errorMessages = [];
   value.forEach((key, value) {
    List<dynamic> messages = value;
    errorMessages.addAll(messages.map((msg) => '$msg').toList());
  });
  return errorMessages;
}

 Future<bool> checkConnexion() async {
   bool hasInternetConnection =
   await InternetConnectionChecker().hasConnection;
   return hasInternetConnection;
 }
 void topToast({
  required String title
}){
   toast(title, length: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER, bgColor: AppColors.customBlue, textColor: Colors.white);
 }



 void showMessage({required String type, String? title ,String? message}){
  if(type =="internet"){
    Get.snackbar(  icon: Icon(Icons.warning),duration: Duration(milliseconds: 5000),"Internet indisponible !!! ", "Veuillez vérifier votre connexion internet. ", snackPosition: SnackPosition.TOP, backgroundColor: AppColors.red, colorText: Colors.white);
  } else if(type == "error"){
    Get.snackbar( icon: Icon(Icons.warning),duration: Duration(milliseconds: 5000),title!, message!, snackPosition: SnackPosition.TOP, backgroundColor: AppColors.red, colorText: Colors.white);
  }else if(type == "success"){
    Get.snackbar( icon: Icon(Icons.message),duration: Duration(milliseconds: 5000),title!, message!, snackPosition: SnackPosition.TOP, backgroundColor: AppColors.mainColor, colorText: Colors.white);
  }
 }