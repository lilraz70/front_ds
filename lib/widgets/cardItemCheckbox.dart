import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:front_ds/models/Conveniences.dart';
import 'package:front_ds/utils/colors.dart';
import 'package:front_ds/widgets/mediumText.dart';

class CardItemCheckBox extends StatefulWidget {
  const CardItemCheckBox({Key? key, required this.position, required this.list, required this.convenience, required this.checkBoxValue}) : super(key: key);
 // const CardItem({Key? key, required this.position, required this.convenience,   }) : super(key: key);


  final int position;
   final List<int> list;
  final Conveniences convenience;
  final bool checkBoxValue;


  //final String title;
  @override
  State<CardItemCheckBox> createState() => _CardItemCheckBoxState();
}

class _CardItemCheckBoxState extends State<CardItemCheckBox> {
late bool valueState;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueState=widget.checkBoxValue;
  }
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
      child: CheckboxListTile(
        title: MediumText(text: widget.convenience.intitule,),
        activeColor: Colors.indigo,
        value: valueState,
        onChanged: (v){
          setState(() {
            valueState=v!;
          });

          if(!valueState) {
            widget.list[widget.position] = 0;
          }else {
            widget.list[widget.position] = 1;
          }
      },)
    );
  }


}
