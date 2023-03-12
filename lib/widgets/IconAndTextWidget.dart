import 'package:flutter/cupertino.dart';
import 'package:front_ds/widgets/mediumText.dart';
import 'package:front_ds/widgets/smallText.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color iconColor;
  const IconAndTextWidget({Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.iconColor
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: 45,),
        SizedBox(width: 3,),
        MediumText(text: text,color: color,)

      ],
    );
  }
}
