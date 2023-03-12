import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../configs/app_routes.dart';
import '../configs/http_config.dart';
import '../models/BookReleaseGoodModel.dart';
import '../models/ReleaseGoodModel3.dart';
import '../pages/mesPubs.dart';
import '../utils/colors.dart';
import 'mediumText.dart';

class DisplayReleaseWidgetOfUser extends StatefulWidget {
     //ReleaseGoodModel listOfReleaseGoodsToDisplay;
   const DisplayReleaseWidgetOfUser({Key? key, }) : super(key: key);



  @override
  State<DisplayReleaseWidgetOfUser> createState() => _DisplayReleaseWidgetOfUserState();


}

 String formatDatePresentation(String? dateStr) {
  var outputFormat = DateFormat('dd-MMM-yyyy');
  DateTime dateTime = DateTime.parse(dateStr!);

  var outputDate = outputFormat.format(dateTime);
  return outputDate;
}


class _DisplayReleaseWidgetOfUserState extends State<DisplayReleaseWidgetOfUser> {

 //set listOfReleaseGoodsToDisplay(ReleaseGoodModel listOfReleaseGoodsToDisplay) {}



  void updateDisplay(List<ReleaseGoodModel3> listOfReleaseGoodModel){
    setState(() {
      listOfReleaseGoodsToDisplay=listOfReleaseGoodModel;
    });
  }

  String retreiveConvenienceNb(List<Releasegoodconvenience>? list, int convID) {
    String number = '0';
    for (var element in list!) {
      if (int.parse(element.conveniencetypeId.toString()) == convID) {
        number = element.number.toString();

      }
    }

    return number;
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(

      itemCount:listOfReleaseGoodsToDisplay.length,
      // scrollDirection: Axis.horizontal,
      controller: scrollController,
      itemBuilder: (context, index) {
        return Column(

          children: [
            SizedBox(

              height: 230,
              width: 350,
              //padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  showDialog(context: context, builder:(BuildContext context) {
                    //return dialogDetails(listOfReleaseGoodsToDisplay[index]);
                    return DetailsWidget(releaseGoodDetails: listOfReleaseGoodsToDisplay[index]);
                  });
                },
                child: Card(


                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color:Colors.white,
                        width:1
                    ),
                    borderRadius: BorderRadius.circular(10.0),

                  ),
                  elevation: 15,
                  color: Colors.white70,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 40,
                        child: ListTile(
                          title: Text(
                            formatDatePresentation(listOfReleaseGoodsToDisplay[index].dateSortiPrevu),style: const TextStyle(fontSize: 15, color:Colors.blueGrey, fontWeight: FontWeight.bold), ),
                          trailing: Text('${listOfReleaseGoodsToDisplay[index].propertytype?.intitule}',style:  const TextStyle(fontSize: 15, color: Colors.blueGrey, fontWeight: FontWeight.bold)),

                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(right: 25,left: 25),
                        height: 90,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                            /*  Text('Ville: ${listOfReleaseGoodsToDisplay[index].city?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                              Text('Quartier: ${listOfReleaseGoodsToDisplay[index].quartier?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                              Text('Localisation: ${listOfReleaseGoodsToDisplay[index].localisation}',style: TextStyle(fontSize: 18, color: Colors.grey),maxLines: 20,),
                              Text('Prix: ${listOfReleaseGoodsToDisplay[index].cout}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                             */

                              Row(
                                children: [
                                  MediumText(text: 'Ville: ',color:AppColors.mainColor ,),
                                  Text('${listOfReleaseGoodsToDisplay[index].city?.intitule}')
                                ],
                              ),
                              const SizedBox(height: 3,),
                              Row(
                                children: [
                                  MediumText(text: 'Quartier: ',color:AppColors.mainColor ,),
                                  Text('${listOfReleaseGoodsToDisplay[index].quartier?.intitule}')
                                ],
                              ),

                              const SizedBox(height: 3,),

                              Row(
                                children: [
                                  MediumText(text: 'Localisation: ',color:AppColors.mainColor ,),
                                  Flexible(child: Text('${listOfReleaseGoodsToDisplay[index].localisation}',)),
                                ],
                              ),

                              const SizedBox(height: 3,),
                              Row(
                                children: [
                                  MediumText(text: 'Prix: ',color:AppColors.mainColor ,),
                                  Text('${listOfReleaseGoodsToDisplay[index].cout}')
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,

                        child: Row(
                          children: [

                            SizedBox(
                              height: iconContainerH,

                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/icon/android/lit.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  /*  Text(
                                  '${listOfReleaseGoodsToDisplay[index].nbChambre}',
                                  style: TextStyle(color: AppColors.mainColor),
                                ),
*/
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        13),
                                    style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),


                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            /*   ClipRRect(
                                              borderRadius:BorderRadius.circular(12),

                                              child:
                                              */
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/icon/android/douche.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        5),
                                    style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                  )


                                ],
                              ),
                            ),


                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/icon/android/cuisine.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        4),
                                    style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/icon/android/ventilateur.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        1),
                                    style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            SizedBox(
                              height: iconContainerH,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    'assets/icon/android/climatisation.png',
                                    color: AppColors.mainColor,
                                    height: convenienceSize,
                                    width: convenienceSize,
                                  ),
                                  Text(
                                    retreiveConvenienceNb(
                                        listOfReleaseGoodsToDisplay[index]
                                            .releasegoodconvenience,
                                        2),
                                    style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),


                            const SizedBox(
                              width: convenienceSpace,
                            ),
                            ClipRRect(
                                borderRadius:
                                BorderRadius.circular(12),
                                child: Container(
                                  height: iconContainerH,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,

                                    children: [
                                      Image.asset(
                                        'assets/icon/android/garage.png',
                                        color: AppColors.mainColor,
                                        height: convenienceSize,
                                        width: convenienceSize,

                                      ),
                                      Text(
                                        retreiveConvenienceNb(
                                            listOfReleaseGoodsToDisplay[index]
                                                .releasegoodconvenience,
                                            6),
                                        style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }, separatorBuilder: (BuildContext context, int index) =>
    const Divider( color: Colors.purple,),


    );

  }


}

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key, required this.releaseGoodDetails}) : super(key: key);
  final ReleaseGoodModel3 releaseGoodDetails;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {



  Future supprimer(num? releasegoodId) async {

     Map<String, String> headers = {
       "Content-Type": "application/json",
       'Accept': 'application/json',
       'Authorization': 'Bearer $token',
     };

// var city_id=1;
     String fullUrl = '${apiUrl}v1/release-goods/$releasegoodId';

     final uri = Uri.parse(fullUrl);
     http.Response response2 = await http.delete(uri, headers: headers);
     //var data = jsonDecode(response2.body.toString());

     return response2;

  }

Widget dialogConfirmDelete(ReleaseGoodModel3 releaseGood){
  return AlertDialog(
    title: const Text('Voulez-vous vraiment supprimer ?'),
    actionsAlignment: MainAxisAlignment.spaceBetween,
    actions: [
      TextButton(
        onPressed: () {

          setState(() {
            deleteButtonDisplayed=false;
            circularVisibility=true;

          });
          supprimer(releaseGood.id).then((value) => {

            setState(() { circularVisibility=false;}),

            if(value.statusCode==204){

              setState(() {
                listOfReleaseGoodsToDisplay.remove(releaseGood);

              }),
              Navigator.pop(context),

              Fluttertoast.showToast(
                  msg: "Supprimé avec succès.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 20,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              ),

            }else{
              deleteButtonDisplayed = true,
              Fluttertoast.showToast(
                  msg: "Echec de suppression! Réessayer.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 20,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              ),
            }
          });
        },
        child: const Text('Oui'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Non'),
      ),
    ],
  );

}
  Widget dialogDetails(ReleaseGoodModel3 releaseGood){


    String convenienceText(Releasegoodconvenience? releasegoodconvenience){

      String text='';
      if(releasegoodconvenience?.conveniencetype?.morethanone=='1' ) {
        text='${releasegoodconvenience?.conveniencetype?.intitule} x${releasegoodconvenience?.number}';
      }else{
        text='${releasegoodconvenience?.conveniencetype?.intitule}';
      }

      return text;
    }

    List<Releasegoodconvenience> sortList(List<Releasegoodconvenience> listOfReleaseGood){
      listOfReleaseGood.sort((a,b) => a.conveniencetype!.intitule!.compareTo(b.conveniencetype!.intitule)); //par ordre alphabétique
      listOfReleaseGood.sort((a,b) => b.conveniencetype!.morethanone!.compareTo(a.conveniencetype!.morethanone!)); // selon qu'il soit dénombrable ou non
      return listOfReleaseGood;
    }

    listOfReleaseGoodConvenience=sortList(releaseGood.releasegoodconvenience!);

    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      title: MediumText(text: 'Libre le ${formatDatePresentation(releaseGood.dateSortiPrevu)}',color: Colors.indigo,size: 20),
      content: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 5, //width of scrollbar
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right,
        controller: scrollController4,
        child: Container(
          padding: const EdgeInsets.only(left: 5, right: 5),
          
          width: 350,
          height: 600,

          child: ListView(
              controller: scrollController4,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(
                  height: 230,

                  child: Scrollbar(
                    thumbVisibility: true, //always show scrollbar
                    thickness: 3, //width of scrollbar
                    radius: const Radius.circular(20), //corner radius of scrollbar
                    scrollbarOrientation: ScrollbarOrientation.right,
                    controller: scrollController3,
                    child: ListView(
                      controller: scrollController3,
                      children: [
                        Row(
                          children: [
                            MediumText(text: 'Type: ',color:AppColors.mainColor ,),
                            Text('${releaseGood.propertytype?.intitule}')
                          ],
                        ),

                        const SizedBox(height: 5,),

                        Row(
                          children: [
                            MediumText(text: 'Quartier: ',color:AppColors.mainColor ,),
                            Text('${releaseGood.quartier?.intitule}')
                          ],
                        ),

                        const SizedBox(height: 5,),

                        Row(
                          children: [
                            MediumText(text: 'Localisation: ',color:AppColors.mainColor ,),
                            Flexible(child: Text('${releaseGood.localisation}',)),
                          ],
                        ),


                        const SizedBox(height: 5,),

                        Row(
                          children: [
                            MediumText(text: 'Prix: ',color:AppColors.mainColor ,),
                            Text('${releaseGood.cout}')
                          ],
                        ),

                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            MediumText(text: 'Commentaires: ',color:AppColors.mainColor ,),
                            Flexible(child: Text(releaseGood.commentaires.toString().compareTo('null')==0 ? '---' : '${releaseGood.commentaires}' ))
                          ],
                        ),

                        const SizedBox(height: 7,),

                        Row(
                          children: [
                            MediumText(text: 'Conditions: ',color:AppColors.mainColor ,),
                            Flexible(child: Text('${releaseGood.conditionsBailleur}'))
                          ],
                        ),




                        /*  Text('Quartier: ${releaseGood.quartier?.intitule}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text('Localisation: ${releaseGood.localisation}',style: TextStyle(fontSize: 18, color: Colors.grey),maxLines: 20,),
                    Text('Prix: ${releaseGood.cout}',style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text("Commentaire: ${releaseGood.commentaires?.compareTo('null')==0 ? '${releaseGood.commentaires}' : '---'}",style: TextStyle(fontSize: 18, color: Colors.grey)),
                    Text('Conditions: ${releaseGood.conditionsBailleur}',style: TextStyle(fontSize: 18, color: Colors.grey)),
*/
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                MediumText(text: 'Les commodités',color: Colors.indigo,size: 17,),

                Container(
                  height: 200,
                  padding: const EdgeInsets.only(left: 5,right: 5,top: 10),
                  child: Scrollbar(
                    thumbVisibility: true, //always show scrollbar
                    thickness: 3, //width of scrollbar
                    radius: const Radius.circular(20), //corner radius of scrollbar
                    scrollbarOrientation: ScrollbarOrientation.right,
                    controller: scrollController2,

                    child: ListView.builder(
                        controller: scrollController2,
                        itemCount: listOfReleaseGoodConvenience.length,
                        itemBuilder: (context,i){

                          /* return ListTile(
                            leading: Icon(Icons.circle,color: Colors.blueGrey,size: 10,),
                            title: MediumText(text: '${releaseGood.releasegoodconvenience?.elementAt(i).conveniencetype?.intitule}',color: Colors.blueGrey,),
                          );*/
                          return SizedBox(
                            height: 30,

                            child: Row(
                              children: [
                                const SizedBox(width: 20,),
                                Icon(Icons.circle,color: AppColors.mainColor,size: 7,),
                                const SizedBox(width: 10,),
                                MediumText(text: convenienceText(listOfReleaseGoodConvenience.elementAt(i)),color: AppColors.mainColor,)
                              ],
                            ),
                          );
                        }),
                  ),
                ),

                const SizedBox(height: 15,),

                Row(
                  children: [
                    MediumText(text: 'Code: ',color:Colors.blue ,size: 13),
                    Text(releaseGood.libelle.toString(), style:  TextStyle(fontSize: 13),),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: IconButton(onPressed: () async{
                        await FlutterClipboard.copy(releaseGood.libelle.toString()).then((value) => {
                          Fluttertoast.showToast(
                              msg: "Copié !",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 20,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0
                          )


                        });
                        }, icon:  const Icon(Icons.copy,size: 15,)),
                    )


                  ],
                ),

                const SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Visibility(
                      visible: modifyButtonDisplayed,
                      child: IconButton(
                          onPressed: (){

                            Navigator.pop(context);
                            Get.offAllNamed(
                              RouteName.updateReleaseGood,
                              parameters: {
                                "releaseGoodString":jsonEncode(releaseGood)
                              }
                            );
                           /* context.pushNamed('updateReleaseGood', params: {
                              "releaseGoodString":jsonEncode(releaseGood)
                            });*/


                          }, icon: const SizedBox(height:15, width:15, child: Icon(Icons.mode_edit, color: Colors.green, size: 20,))),
                    ),

                    Row(children: [
                      Visibility(
                        visible: deleteButtonDisplayed,
                        child: IconButton(
                            onPressed: (){
                              dialogConfirmDelete(releaseGood);

                            }, icon: const SizedBox(height:15, width:15, child: Icon(Icons.delete, color: Colors.red, size: 20,))),
                      ),

                      Visibility(
                          visible: circularVisibility,
                          child: const CircularProgressIndicator(color: Colors.red,)
                      )
                    ],)


                  ],
                ),

              ]


          ),
        ),
      ),

    );
  }

 /* void updateList(ReleaseGoodModel3 releaseGood){
    setState(() {
      widget.releaseGoodDetails=
    });
  }
*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    deleteButtonDisplayed=true;
    circularVisibility=false;

  }
  @override
  Widget build(BuildContext context) {
    return dialogDetails(widget.releaseGoodDetails);
  }
}




const double iconContainerH = 50.0;
const double convenienceSpace = 23.0;
const double convenienceSize = 30.0;
List<Releasegoodconvenience> listOfReleaseGoodConvenience=[];
ScrollController scrollController=ScrollController();
ScrollController scrollController2=ScrollController();
ScrollController scrollController3=ScrollController();
ScrollController scrollController4=ScrollController();


bool circularVisibility=false;

int idReleaseGood=0;

late Iterable<BookReleaseGoodModel> listOfBookReleaseGoodModel;
late BookReleaseGoodModel userBookReleaseGoodModel;

bool deleteButtonDisplayed=true, modifyButtonDisplayed=true;