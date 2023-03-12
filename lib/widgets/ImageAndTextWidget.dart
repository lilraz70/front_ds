import 'package:flutter/cupertino.dart';
import 'package:front_ds/widgets/mediumText.dart';
import 'package:front_ds/widgets/smallText.dart';

class ImageAndTextWidget extends StatelessWidget {
  final Image image;
  final String text;
  final Color color;
  final Color iconColor;
  const ImageAndTextWidget({Key? key,
    required this.image,
    required this.text,
    required this.color,
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       image,
        //const SizedBox(width: 3,),
        MediumText(text: text,color: color,)

      ],
    );
  }
}
