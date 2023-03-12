import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void warningAlert(BuildContext context, String title, String message) {
  SnackBar snackBar = SnackBar(
    margin: EdgeInsets.zero,
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: ContentType.help,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
