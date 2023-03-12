import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_ds/models/UserModel.dart';
import 'package:http/http.dart' as http;

import '../configs/http_config.dart';
import '../utils/colors.dart';

class MonCompte extends StatefulWidget {
  const MonCompte({Key? key}) : super(key: key);

  @override
  State<MonCompte> createState() => _MonCompteState();
}
Widget userInfos(){

  Future retreiveDropdownInfoPropertyType() async {

    Map<String, String> headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // var city_id=1;
    String fullUrl = '${baseUrl}v1/users/${user['id']}';

   // print(fullUrl);
    final uri = Uri.parse(fullUrl);
    http.Response response2 = await http.get(uri, headers: headers);
    var data = jsonDecode(response2.body.toString())['data'];

    // print('${data['id']}');


     userModel = UserModel.fromJson(data);

    return response2;

  }
  return FutureBuilder(

      future: retreiveDropdownInfoPropertyType(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Row(

              children: const [

                Center(child: CircularProgressIndicator(color: Colors.blue)),
              ],
            );
          case ConnectionState.done:
          default:
            if (snapshot.hasError) {
              // print(snapshot.error);
              return userInfos();
            /*  return Center(
                child: Text('Erreur occured: ${snapshot.error}'),
              );*/
            } else if (snapshot.hasData) {

              // if(firstDrawerDisplay) {
              //typeSelectionne=listOfProperty.elementAt(listOfPropertyId.indexOf(propertyId)); //+1 parce qu'il ya choisir le type en 1er. on pourra bien l'enlever après
              // }
              return
                Column(
                  children: [
                    Row(
                      children: [
                        const Text("Nom: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text("${userModel.name}", style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20))
                      ],
                    ),

                    const SizedBox(height: 5,),

                    Row(
                      children: [
                        const Text("Email: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text("${userModel.email}", style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20))
                      ],
                    ),

                    const SizedBox(height: 5,),

                    Row(
                      children: [
                        const Text("Téléphone: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text("${userModel.phone}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20))
                      ],
                    ),

                    const SizedBox(height: 5,),

                    Row(
                      children: [
                        const Text("Pseudonyme: ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        Text("${userModel.username}", style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20))
                      ],
                    ),

                    const SizedBox(height: 5,)
                  ],
                );
            } else {
              return
                const Center(child: Text('No data'));
            }
        }
      }
  );
}



class _MonCompteState extends State<MonCompte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          //color: AppColors.mainColor2,
          padding: const EdgeInsets.only(
          top: 20, left: 15, right: 15),

        child: Column(
          children: [
            Image.asset(
              'assets/images/logomdpi.png',
             /* height: 100,
              width: 100,*/
            ),

            const SizedBox(height: 40,),
            userInfos(),

            const SizedBox(height: 50,),

           /* TextButton(

                onPressed: (){

              context.pushNamed('user', params: {
              "userString":jsonEncode(userModel)
            });

              }, child: Text("Mettre à jour", style: TextStyle(color: AppColors.mainColor, fontSize: 15),))*/
          ],
        ),
      ),
    );
  }
}

const baseUrl = apiUrl;
late UserModel userModel;