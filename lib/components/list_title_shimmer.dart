import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
class ListTitleShimmer extends StatelessWidget{
  const ListTitleShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: <Widget>[
        for(var i=1;i<=10; i++)
        ListTileShimmer(
          bgColor: Colors.grey.shade100,
          height: 3,
          // isPurplishMode: true,
        ),
      ]
    );
  }

}