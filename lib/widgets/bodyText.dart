import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BodyText extends StatelessWidget {
  Color? color;
  final String text;
  double size;

  //TextOverflow overFlow;
  BodyText(String s,
      {Key? key, this.color = Colors.black, required this.text, this.size = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Sen',
          color: color,
          fontSize: size,
          fontWeight: FontWeight.normal),
    );
  }
}
