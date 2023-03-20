import 'package:flutter/material.dart';
import 'package:front_ds/api/services/besoin_services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../configs/app_routes.dart';
import '../configs/session_data.dart';
import '../functions/utils.dart';
import '../models/besoin.dart';

class BesoinController extends GetxController {
  static Map authUser =  SessionData.getUser();
  RxList demandeList = [].obs;
  TextEditingController description = TextEditingController();
  TextEditingController titre = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxList<Besoin> listBesoin = List<Besoin>.empty(growable:  true).obs;
  RxList<Besoin> listUserBesoin = List<Besoin>.empty(growable:  true).obs;
  final scrollController = ScrollController();
  final scrollUserBesoinController = ScrollController();
  RxBool infinityLoading = false.obs ;
  RxBool userBesoinInfinityLoading = false.obs ;
  RxBool isloading = false.obs;
  RxList<dynamic> lists = [].obs;
  RxList<dynamic> userBesoinLists = [].obs;
  int page = 1;
  int userBesoinPage = 1;
  Future<void> post() async {
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
  Future<void> edit({required int id}) async {
    if (formKey.currentState!.validate()) {
      loading(true);
      var request = await BesoinServices.editBesoin(id: id,description: description.text, titre:titre.text);
      if(request.ok){
        loading(false);
        description.text = "";
        titre.text = "";
        showMessage(
            type: "success",
            title: "La modification a reussi",
            message: "Besoin modifier  avec succèss");

      }else{
        loading(false);
        Get.back();
        showMessage(
            type: 'error',
            title: "La modificationa echoué ",
            message: "Veuillez réessayez ");
      }
    }}
  Future<void> getUserBesoin() async {
      try{
        isloading(true);
        var request = await BesoinServices.getUserBesoin(id: 1 /*authUser["id"]*/,page :  userBesoinPage);
        if(request.ok){
          userBesoinLists = userBesoinLists +  request.data['data']['data'];
          listUserBesoin.assignAll(addBesoinListFromJson(userBesoinLists));

        }
      }finally{
        isloading(false);
      }
  }
  Future<void> getAllBesoin() async {
    try{
      isloading(true);
      var request = await BesoinServices.getAllBesoin(page : page);
      if(request.ok){
        lists = lists +  request.data['data']['data'];
        listBesoin.assignAll(addBesoinListFromJson(lists));
      }
    }finally{
      isloading(false);
    }
  }
  Future<void>  scrollLister() async {
    if(infinityLoading()) return ;
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){

      page = page +1;
      infinityLoading(true);
      await getAllBesoin();
      Future<void>.delayed(const Duration(seconds: 3), ((){
        return infinityLoading(false);
      }));

    }
  }
  Future<void>  scrollUserBesoinLister() async {
    if(infinityLoading()) return ;
    if(scrollUserBesoinController.position.pixels == scrollUserBesoinController.position.maxScrollExtent){

      userBesoinPage =  userBesoinPage +1;
      userBesoinInfinityLoading(true);
      await getAllBesoin();
      Future<void>.delayed(const Duration(seconds: 3), ((){
        return userBesoinInfinityLoading(false);
      }));

    }
  }



  deleteBesoin(int? id) async {
    try{
      loading(true);
      var request = await BesoinServices.deleteBesoin(id);
      if(request.ok){
        Get.back();
        Get.offAllNamed(
          RouteName.myBesoinView,
        );
        showMessage(type: 'success', title : "Succès!!!", message : "Besoin supprimé avec succès ");
      }else {
        loading(false);
        Get.back();
        showMessage(type: 'error', title : "La suppression a echoué!!!", message : "veuillez réessayer. ");
      }
    }finally{
      Get.back();
     loading(false);
    }
  }
    @override
    void onInit() {
      // TODO: implement onInit
      super.onInit();
      getUserBesoin();
      getAllBesoin();
      scrollController.addListener(scrollLister);
      scrollUserBesoinController.addListener(scrollUserBesoinLister);
    }
  @override
  void onClose() {
    super.onClose();
  }
  }
