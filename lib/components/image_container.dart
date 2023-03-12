
import 'package:flutter/material.dart';
import 'package:front_ds/constants/colors.dart';

import '../configs/http_config.dart';

class ImageContainer extends StatelessWidget{

  const  ImageContainer ({ Key? key,   this.height = 125, required this.widht, required this.imageUrl, this.padding, this.margin, this.borderRaduis = 20 , this.child} ):super(key : key);


  final double height;
  final double widht;
  final String? imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRaduis;
  final Widget? child;

  @override
  Widget build(BuildContext context) {

    return imageUrl != null ? Container(
      height: height,
      width: widht,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage('$baseResourceUrl$imageUrl'),fit: BoxFit.cover),
      ),
      child: child ,
    ) :  Container(
      height: height,
      width: widht,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.customAmber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child ,
    );
  }

}