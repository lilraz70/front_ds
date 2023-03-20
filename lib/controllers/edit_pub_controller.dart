import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../configs/http_config.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
class EditPubController extends GetxController{
  static Map authUser =  SessionData.getUser();
  RxString? pubImage =  "".obs;
  List<XFile> pubImages = [];
  List<dynamic> pubListImagePath = [];
  List<dynamic> deleteListImageId = [];
  var pubSelectedFileCount = 0.obs;
  File? imageFile;
  final picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;


  void selectedMultipleImage({required int id}) async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images) {
        listImagePath.add(file.path);
      }
    } else {
      showMessage(type: 'error',title: "erreur", message: 'Ajoute echoué');
    }
    selectedFileCount.value = listImagePath.length;

    if(listImagePath.isNotEmpty){
      final uri = Uri.parse('$baseUrl/v1/upload_image');
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = id.toString();
      request.headers.addAll({
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if(listImagePath.isNotEmpty){
        for (String path in listImagePath) {
          request.files.add(
              await http.MultipartFile.fromPath("images[]", path));
        }
      }
      var response = await request.send();

      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        var images = jsonDecode(data)['data'];
       pubListImagePath.clear();
        pubListImagePath = images;
       // images.forEach((element) {
       // pubListImagePath.add(element['image_url']);
       //  });
      pubSelectedFileCount.value = pubListImagePath.length;
        Get.back();
        showMessage(type: 'success',title: "Success", message: 'Image ajouter avec succes');
      }
    }else {
      Get.back();
      showMessage(type: 'error',title: "erreur", message: 'Ajoute echoué');
    }
  }

  Future getImage({required int id}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    if(imageFile?.path != null){
      final uri = Uri.parse('$baseUrl/v1/upload_image');
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = id.toString();
      request.headers.addAll({
        "Content-Type": "application/json",
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      if(imageFile != null){
        request.files.add(
            await http.MultipartFile.fromPath('image_url', imageFile!.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        var data = await response.stream.bytesToString();
        pubImage?.value = jsonDecode(data)['data']['image_url'];
        Get.back();
        showMessage(type: 'success',title: "Success", message: 'Image ajouter avec succes');
      }
    }else {
      Get.back();
      showMessage(type: 'error',title: "erreur", message: 'Ajoute echoué');
    }
    update();
  }




  @override
  void onInit() {
    super.onInit();
  }

}