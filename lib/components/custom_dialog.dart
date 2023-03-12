import 'package:flutter/material.dart';
import 'package:get/get.dart';


Future<void> customDialog({
  required Widget content,
  required Widget action,
}) async {
  return Get.defaultDialog(
      barrierDismissible: false,
      radius: 15,
      title: "",
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(15),

      content: content,

      actions: [

        action

      ]

  );
}