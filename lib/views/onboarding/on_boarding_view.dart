import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../configs/app_routes.dart';
import '../../constants/colors.dart';

final pages = [

   PageData(
  image_url: "assets/images/onboarding1.jpg",
    title: "Trouver la maison qu'il vous faut ",
    bgColor:AppColors.mainColor,
    textColor: Colors.white,
  ),
   PageData(
    image_url: "assets/images/onboarding2.jpg",
    title: "Rechercher facilement",
    bgColor: AppColors.mainColor2, //Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
  const PageData(
    image_url: "assets/images/onboarding3.jpg",
    title: "Gagner des commission sur vos locations",
    bgColor: Color(0xffffffff),
    textColor: Color(0xff3b1790),
  ),

];

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3), // visual center
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        // enable itemcount to disable infinite scroll
        itemCount: pages.length,
        opacityFactor: 2.0,
        scaleFactor: 2,
         verticalPosition: 0.7,
         direction: Axis.vertical,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
        onFinish: ((){
          Get.offAllNamed(
              RouteName.authView,);
        }),
      ),
    );
  }
}

class PageData {
  final String? title;
  final String? image_url;
  final Color bgColor;
  final Color textColor;

  const PageData({
    this.title,
    this.image_url,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(page.image_url!, fit: BoxFit.cover,width: screenWidth * 1,height: screenHeight * 0.3,),
        50.height,
        Text(
          page.title ?? "",
          style: TextStyle(
              color: page.textColor,
              fontSize: screenHeight * 0.035,),
           textAlign: TextAlign.center,
        ),
        200.height,
      ],
    );
  }
}
