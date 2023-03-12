import 'package:flutter/material.dart';
import 'package:front_ds/api/services/besoin_services.dart';
import 'package:get/get.dart';

import '../functions/utils.dart';
import '../models/besoin.dart';

class BesoinController extends GetxController {

  RxList demandeList = [].obs;
  TextEditingController description = TextEditingController();
  TextEditingController titre = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxList<Besoin> listBesoin = List<Besoin>.empty(growable:  true).obs;
  final scrollController = ScrollController();
  RxBool infinityLoading = false.obs ;
  RxBool isloading = false.obs;
  RxList<dynamic> lists = [].obs;
  int page = 1;
  void post() async {
    if (formKey.currentState!.validate()) {
      loading(true);
      var request = await BesoinServices.postBesoin(description: description.text, titre:titre.text);
      if(request.ok){
        loading(false);
        description.text = "";
        titre.text = "";
        showMessage(
            type: "success",
            title: "L'ajout a reussi",
            message: "L'ajout a  avec succèss");

      }else{
        loading(false);
        Get.back();
        showMessage(
            type: 'error',
            title: "L'ajout a echoué ",
            message: "Veuillez réessayez ");
      }
    }}
  Future<void> getAllBesoin() async {

      try{
        isloading(true);
        var request = await BesoinServices.getAllBesoin(page : page);
        if(request.ok){
         // print(request.data['data']['data']);
          lists = lists +  request.data['data']['data'];
          listBesoin.assignAll(addBesoinListFromJson(lists));
          print(listBesoin);
        }
      }finally{
        isloading(false);
      }
  }
  Future<void>  scrollLister() async {
    if(infinityLoading()) return ;
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      //    print("lister called");
      page = page +1;
      infinityLoading(true);
      await getAllBesoin();
      Future<void>.delayed(const Duration(seconds: 3), ((){
        return infinityLoading(false);
      }));

    }else {
      //    print("dont called lister ");
    }
  }
    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      getAllBesoin();
      scrollController.addListener(scrollLister);
    }
  @override
  void onClose() {
    super.onClose();
  }
  }
