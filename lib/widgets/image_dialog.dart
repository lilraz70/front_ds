import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../configs/http_config.dart';

class ImageDialog extends StatefulWidget {
  const ImageDialog({Key? key,}) : super(key: key);

  @override
  _ImageDialogState createState() => _ImageDialogState();
}

class _ImageDialogState extends State {
  String imageUrl = Get.arguments ;
@override
void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appercu de l\'image'),
        elevation: 0,
      ),
      body: Center(
        child: Image.network(
          '$baseResourceUrl$imageUrl',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}