import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../configs/session_data.dart';
class ReleaseGoodController extends GetxController{

  File? imageFile;
  final picker = ImagePicker();
  static Map authUser =  SessionData.getUser();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;

  void selectedMultipleImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar("Erreur", "Aucune image selectionner");
    }
    selectedFileCount.value = listImagePath.length;
  }


  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    update();
  }



@override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() {
    super.onInit();
  }
  @override
  void onClose() {
    super.onClose();
  }
}