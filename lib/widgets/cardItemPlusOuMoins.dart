import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front_ds/models/Conveniences.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:front_ds/widgets/mediumText.dart';

class CardItemPlusOrMinus extends StatefulWidget {
  const CardItemPlusOrMinus({Key? key, required this.position, required this.list, required this.convenience}) : super(key: key);
 // const CardItem({Key? key, required this.position, required this.convenience,   }) : super(key: key);


  final int position;
   final List<int> list;
  final Conveniences convenience;



  //final String title;
  @override
  State<CardItemPlusOrMinus> createState() => _CardItemPlusOrMinusState();
}

class _CardItemPlusOrMinusState extends State<CardItemPlusOrMinus> {



  int counter=0;
  @override
  Widget build(BuildContext context) {

    return  Card(
      //color: AppColors.mainColor2,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.mainColor2,
          width: 2
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      elevation: 15,
      child: ListTile(

        title: MediumText(text: widget.convenience.intitule),
        //title: MediumText(text: widget.title),
        trailing: SizedBox(
          width: 110,
          child: Wrap(

                  children: [
                    Row(
                      children: <Widget>[
                        IconButton(onPressed: (){

                  if(counter>0) {
                    setState(() {
                      counter--;
                    });

                    widget.list[widget.position] = counter;
                  }
                          }, icon: const Icon(Icons.remove)),
                        MediumText(text: "$counter"),
                        IconButton(onPressed: (){

                          if(widget.convenience.morethanone==1) {

                              setState(() {
                                counter++;
                              });


                            widget.list[widget.position] = counter;
                           }else if(counter<1){

                            setState(() {
                              counter++;
                            });


                            widget.list[widget.position] = counter;
                          }


                          }, icon: const Icon(Icons.add)),


                      ],
                    )
                  ],),
        ),
      ),
    );
  }


}
