import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppCustomButton extends StatelessWidget {

  const AppCustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.isFilled,
    required this.bgColor,
    required this.textColor,
    this.withBorder,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;
  final bool isFilled;
  final Color bgColor;
  final Color textColor;
  final bool? withBorder;

  @override
  Widget build(BuildContext context) {

    bool isNoBorderBtn = (withBorder == false && isFilled == false);

    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: isFilled ? bgColor : Colors.transparent,
          border: Border.all(color: isNoBorderBtn ? Colors.transparent : bgColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ).center(),
      ),
    );
  }
}