
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../configs/app_routes.dart';
import '../../../configs/http_config.dart';
import '../../../configs/session_data.dart';


enum SampleItem { itemOne, itemTwo, itemThree }

class AppBarContent extends StatefulWidget {
  const AppBarContent({Key? key, this.title, this.withArrowBack, this.goToHomeView})
      : super(key: key);
  final String? title;
  final bool? withArrowBack;
  final bool? goToHomeView;

  @override
  AppBarContentState createState() => AppBarContentState();
}

class AppBarContentState extends State<AppBarContent> {

  @override
  Widget build(BuildContext context) {
    Map? authUser = SessionData.getUser();
    SampleItem? selectedMenu;

    return Center();
  }
}
