import 'dart:core';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:front_ds/models/Conveniences.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:front_ds/widgets/mediumText.dart';

class CardItemPlusOrMinus2 extends StatefulWidget {
  const CardItemPlusOrMinus2({Key? key, required this.position, required this.list, required this.convenience, required this.counter}) : super(key: key);
 // const CardItem({Key? key, required this.position, required this.convenience,   }) : super(key: key);


  final int position;
   final List<int> list;
  final Conveniences convenience;
  final int counter;



  @override
  State<CardItemPlusOrMinus2> createState() => _CardItemPlusOrMinus2State();
}

class _CardItemPlusOrMinus2State extends State<CardItemPlusOrMinus2> {

late int count;


@override
  void initState() {
    super.initState();
   setState(() {
      count=widget.counter;
    });

  }

  void setCounter(int){

  }

  @override
  Widget build(BuildContext context) {
    //print(count);
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

                  if(count>0) {
                    setState(() {
                      count--;
                    });

                    widget.list[widget.position] = count;
                  }
                          }, icon: const Icon(Icons.remove)),
                        MediumText(text: "$count"),
                        IconButton(onPressed: (){

                          if(widget.convenience.morethanone==1) {

                              setState(() {
                                count++;
                              });


                            widget.list[widget.position] = count;
                           }else if(count<1){

                            setState(() {
                              count++;
                            });


                            widget.list[widget.position] = count;
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
