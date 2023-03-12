import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
class ListHorizontalShimmer extends StatelessWidget{
  const ListHorizontalShimmer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for(var i=1;i<=5; i++)
          ListTileShimmer(
            bgColor: Colors.grey.shade100,
            height: 8,
            // isPurplishMode: true,
          ),
        ]
      ),
    );
  }
}